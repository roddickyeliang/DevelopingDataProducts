# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output, session) {
  symbol <<- ""
  cursymb <<- ""
  
  observe({
    clean <- FALSE
    if(input$symb != "" && input$symb != cursymb) {
      cursymb <<- input$symb
      clean <- TRUE
    }
    if(clean) {
      updateSelectInput(session, "comsymb", selected = '(Select)')
    }
  })
  
  dataInput <- reactive({
    validate(
      need(input$symb != "" || input$comsymb != "(Select)", "Please select or input a stock symbol to examine"),
      errorClass = "symberror"
    )
    
    if(input$comsymb == '(Select)') {
      symbol <<- input$symb
    } else {
      symbol <<- input$comsymb
    }
    getSymbols(symbol, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  finalInput <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  
  output$plot <- renderPlot({
    chartSeries(finalInput(), name = paste("Stock Analysis for", symbol, sep =" "), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = c(addVo(),addBBands()))
  })
  
})