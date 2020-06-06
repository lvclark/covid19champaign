library(shiny)
source("allcounties.R")
source("how_bad_is_it.R")

# set some default counties
defcounties <- sapply(allcounties, function(x) x[1])
defcounties["Illinois"] <- "Champaign"
defcounties["Maine"] <- "York"
defcounties["Florida"] <- "Marion"
defcounties["Massachusetts"] <- "Essex"

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
  ),
  
  mainPanel(p("Data obtained from ",
    a("COVID-19 Data Hub", href = 'https://covid19datahub.io/'),
    "."),
    p("View source code on ", a("GitHub", href = "https://github.com/lvclark/covid19champaign"),
      ". Feel free to modify and distribute with attribution."))
)

server <- function(input, output, session){
  output$linegraph <- 
    renderPlot(how_bad_is_it(input$startdate, input$state, input$county)[[2]])
  
  observe(
    updateSelectInput(session, "county", label = "County",
                      choices = allcounties[[input$state]],
                      selected = defcounties[input$state])
  )
  
}

shinyApp(ui = ui, server = server)
