library(shiny)
library(plotly)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    # Show a world map
    fluidRow(
      h1("World Map"),
      # leafletOutput("worldmap"),
      plotlyOutput("plotly_map")
    )
  )
)
