library(shiny)
source("allcounties.R")
source("how_bad_is_it.R")

ui <- fluidPage(
  titlePanel("COVID-19 confirmed cases by date and county"),
  
  sidebarLayout(
    sidebarPanel(
      dateInput("startdate", "Start date", "2020-04-01",
                min = "2020-01-01", max = Sys.Date()),
      selectInput("state", "State", names(allcounties), "Illinois"),
      selectInput("county", "County", allcounties[["Illinois"]], "Champaign")
    ),
    mainPanel(plotOutput(outputId = "linegraph"))
  )
)

server <- function(input, output, session){
  output$linegraph <- 
    renderPlot(how_bad_is_it(input$startdate, input$state, input$county)[[2]])
  
  observe(
    updateSelectInput(session, "county", label = "County",
                      choices = allcounties[[input$state]])
  )
  
}

shinyApp(ui = ui, server = server)
