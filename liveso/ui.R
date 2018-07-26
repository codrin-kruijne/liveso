# This script creates the user interface for the Shiny application.

library(shiny)
library(shinythemes)
library(plotly)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(theme = shinytheme("united"),
             title = "Natural progress",
             tabPanel("Overview",
                      fluidRow(align="center", # World map selector and focus country
                        column(1),
                        column(10, align = "left",
                               
                               h1("Towards a global Natural Progress Index"),
                               p("Governments have been using GDP as a monetary measure to inform decision making and guage results. While increasing economic results has brought a lot of benefits, we are being confronted with detrimental side effects. Alternative performance indexes have been developed to provede more nuanced views. This site gives you a view of several metrics and proposes a new one that is based on strategies from nature.")
                               ),
                        column(1)
                      ),
                      fluidRow( 
                        column(12, # Selector world map
                               p("Select a country to explore more measures"),
                               leafletOutput("leaflet_world")
                        )
                      ),
                      fluidRow(align = "center", # Comparison Indicators
                        h2("How does this country compare on previous indicators?")
                      ),
                      fluidRow(
                        column(1),
                        column(10,
                               plotOutput("index_plot")
                        ),
                        column(1)
                      )),
             tabPanel("GDP",
                      plotlyOutput("gdp_map")),
             tabPanel("Better Life"),
             tabPanel("Social Progress"),
             tabPanel("Eco Footprint"),
             tabPanel("Happy Planet"),
             tabPanel("Life's Principles",
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
                      )),
             navbarMenu("About",
                        tabPanel("Guiding questions",
                                 h1("What you measure is what you get?"),
                                 h1("What indexes are there and how do they compare?"),
                                 h1("At what point does GDP growth hinder other factors?"),
                                 h1("To what degree is our dependence on ecosystem services acknowledged?"),
                                 h1("What if we move beyond human-centered measures?"),
                                 h1("Can patterns in nature be of value for progress evaluation?")),
                        tabPanel("Data quality",
                                 h1("Data sources"),
                                 h1("Data completeness")),
                        tabPanel("Design choices"),
                        tabPanel("Biomimicry"),
                        tabPanel("Code and data"),
                        tabPanel("Developer"))
  ) # End of navbarPage
)
