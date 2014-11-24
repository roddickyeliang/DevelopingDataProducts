library(shiny)

comsymb <- c('(Select)','AAPL', 'BABA', 'FB', 'GOOG', 'IBM', 'MS', 'MSFT', 'MSI', 'MSTR', 'SAP', 'TWTR', 'YHOO')

shinyUI(fluidPage(
  
  includeCSS("styles.css"),
  
  h1("Basic Stock Price Analysis"), 
  
  sidebarLayout(
    sidebarPanel(
      h4('Getting Started with this Web App'),
      p('1.Select or input a stock symbol to examine'),
      p('2.Pick a range of dates to review'),
      p('3.Choose whether to plot stock prices or the log of the stock prices on the y axis, and'),
      p('4.Decide whether or not to correct prices for inflation.'),
      p('By default, Line Chart displays the MSTR ticker (an index of the MicroStrategy Inc.). 
        To look up some common symbols like GOOG(Google) or AAPL(Apple), select a stock symbol from the list. 
        To look up a different stock, type in a stock symbol that Yahoo finance will recognize.
        You can find a list of stock symbols here:', a('http://finance.yahoo.com/lookup'), style = "font-family: 'times'; font-si16pt"),
      strong("Select a stock to examine. 
        Information will be collected from yahoo finance."),      
      
      selectInput('comsymb', 'Choose Common Symbol from List', comsymb, selected = "(Select)"),
      
      textInput("symb", "Or Input Symbol", ""),
        
      dateRangeInput("dates", 
        "Date range",
        start = "2014-01-01", 
        end = as.character(Sys.Date())),
      
      checkboxInput("log", "Plot y axis on log scale", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "Adjust prices for inflation", value = FALSE)
    ),
    
    mainPanel(
      br(),
      h4('About the plot'),
      p('The Line Chart displays the stock price trend for selected stock symbol within a range of dates.'),
      p('This App will get the financial data from Yahoo finance:', a("http://finance.yahoo.com/"), ". Then it will use line chart to display the stock prices."),
      p('If you are interested in stock, play with this App!'),
      plotOutput("plot")
    )
  )
))