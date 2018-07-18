library(shiny)
library(plotly)
library(leaflet)

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
        h1("Country"),
        verbatimTextOutput("country"),
        leafletOutput("country_map")
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
        h3("Adapt to Changing Conditions")
      ),
      column(2,
        h3("Be Locally Attuned and Responsive")
      ),
      column(2,
        h3("Integrate Development wth Growth")
      ),
      column(2,
        h3("Be Resource Effcient (Materals and Energy)")
      ),
      column(2,
        h3("Do Life-Friendly Chemistry")
      )
    ),
    fluidRow(
      h2("How does this country compare on previous indicators?")
    ),
    fluidRow( # Comparison Indicators
      column(3, # GDP Column
        h3("GDP")
      ),
      column(3, # SPI Column
        h3("Social Progress Index"),
        verbatimTextOutput("SPI")
      ),
      column(3, # Footprint Column
             h3("Ecological footpint")
      ),
      column(3, # HPI Column
        h3("Happy Planet Index"),
        verbatimTextOutput("HPI")
      )
    )
  )
)
