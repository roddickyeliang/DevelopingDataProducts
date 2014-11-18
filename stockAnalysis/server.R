# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  symbol <<- ""
  
  dataInput <- reactive({  
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