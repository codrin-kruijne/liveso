library(shiny)
library(xlsx)
library(dplyr)
library(plotly)
library(countrycode)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # HPI data
  HPI <- read.xlsx("data/hpi-data-2016.xlsx",
                   sheetName = "Complete HPI data",
                   rowIndex = 6:146,
                   header = TRUE,
                   colIndex = 2:15,
                   stringsAsFactors = FALSE)
  HPI[2:3] <- lapply(HPI[2:3], as.factor)
  
  # SPI data
  SPI <- read.xlsx("data/SPI 2017 Results.xlsx",
                   sheetName = "2017 SPI",
                   rowIndex = 1:273,
                   header = TRUE,
                   colIndex = 1:76,
                   stringsAsFactors = FALSE)
  SPI[3:76] <- lapply(SPI[3:76], as.numeric)
  SPI[1:2] <- lapply(SPI[1:2], as.factor)
  
  #  merge country data
  
  df <- SPI[c("Country", "Country.Code", "Social.Progress.Index")]
  df_merged <- df %>% left_join(HPI[c("Country", "Happy.Planet.Index")], by = "Country")
  
  # Create hover text
  df_merged$hover <- with(df_merged, paste(Country, '<br>',
                                           "HPI", round(Happy.Planet.Index, 2), '<br>',
                                           "SPI", round(Social.Progress.Index, 2)))
  
  # World map selector
  output$world_map <- renderPlotly({
    
    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = "winkel triple")
    )
    
    p <- plot_geo(data = df_merged,
                  z = ~Happy.Planet.Index,
                  color = ~Happy.Planet.Index,
                  text = ~hover,
                  locations = ~Country.Code,
                  type = 'choropleth') %>%
            layout(geo = g)
  })
  
  # Country map
  output$country_map <- renderPlotly({
    d <- event_data("plotly_click")
    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      scope = "usa",
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = "winkel triple")
    )
    
    p <- plot_geo(data = df_merged,
                  type = 'choropleth') %>%
      layout(geo = g)
  })
  
  # Testing output click
  
  output$country <- renderPrint({
    d <- event_data("plotly_click")
    # print(str(d))
    # print(d)
    df_points <- df_merged %>% filter(!is.na(Happy.Planet.Index) & !is.na(Social.Progress.Index)) %>% arrange(Country)
    if (is.null(d)) "Click on a country to view data" else df_points[d$pointNumber + 1,]$Country
  })
 
  output$SPI <- renderPrint({
    d <- event_data("plotly_click")
    df_points <- df_merged %>% filter(!is.na(Happy.Planet.Index) & !is.na(Social.Progress.Index)) %>% arrange(Country)
    if (is.null(d)) "Click on a country to view data" else df_points[d$pointNumber + 1,]$Social.Progress.Index
  })
   
  output$HPI <- renderPrint({
    d <- event_data("plotly_click")
    df_points <- df_merged %>% filter(!is.na(Happy.Planet.Index) & !is.na(Social.Progress.Index)) %>% arrange(Country)
    if (is.null(d)) "Click on a country to view data" else df_points[d$pointNumber + 1,]$Happy.Planet.Index
  })

})
