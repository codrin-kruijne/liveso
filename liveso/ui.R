library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    fluidRow(
      h1("Towards a global Natural Progress Index")
    ),
    fluidRow( # Selector map
      column(8,
        plotlyOutput("world_map")       
      ),
      column(4,
        verbatimTextOutput("country"),
        plotlyOutput("country_map")
      )
    ),
    fluidRow( # Country Natural Progress Indicator
      h2("How does this country measure up to Life's Principles?")
    ),
    fluidRow(
      column(2,
        h3("Evolve to Survive")
      ),
      column(2,
        h3("Evolve to Survive")
      ),
      column(2,
        h3("Evolve to Survive")       
      ),
      column(2,
        h3("Evolve to Survive")
      ),
      column(2,
        h3("Evolve to Survive")
      ),
      column(2,
        h3("Evolve to Survive")
      )
    ),
    fluidRow(
      h2("How does this company compare on previous indicators?")
    ),
    fluidRow( # Comparison Indicators
      column(4, # GDP Column
        h3("GDP")
      ),
      column(4, # SPI Column
        h3("Social Progress Index"),
        verbatimTextOutput("SPI")
      ),
      column(4, # HPI Column
        h3("Happy Planet Index"),
        verbatimTextOutput("HPI")
      )
    )
  )
)
