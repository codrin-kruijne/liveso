library(shiny)
library(xlsx)
library(dplyr)
library(plotly)
library(maps)
library(leaflet)
library(countrycode)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # # Leaflet map
  # output$worldmap <- renderLeaflet({
  #   library(maps)
  #   mapCountries = map("world", fill = TRUE, plot = FALSE)
  #   leaflet(data = mapCountries,
  #           options = leafletOptions(noWrap = TRUE)) %>%
  #     addTiles() %>%
  #     addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
  # })
  
  # Plotly output
  output$plotly_map <- renderPlotly({
    # HPI data
    df <- read.xlsx("data/hpi-data-2016.xlsx",
                    sheetName = "Complete HPI data",
                    rowIndex = 6:146,
                    header = TRUE,
                    colIndex = 2:15)
    df$iso3 <- countrycode(df$Country, "country.name", "iso3c")
    
    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = "winkel triple")
    )
    
    p <- plot_geo(data = df,
                  z = ~Happy.Planet.Index,
                  color = ~Happy.Planet.Index,
                  text = ~Country,
                  locations = ~iso3,
                  type = 'choropleth') %>%
            layout(geo = g)
  })
  
})
