# This script creates the user interface for the Shiny application.

library(shiny)
library(shinythemes) 
library(plotly)
library(leaflet)

# Bootswatch theme component generators https://bootswatch.com/united/

generateCard <- function(type, header, title, message){
  # styles: primary, secondary, success, danger, warning, info, light, dark
  tags$div(class = paste0("card border-", type, " mb-3"), style = "max-width: 20rem;",
           tags$div(class="card-header", header),
           tags$div(class = "card-body",
                    tags$h4(class = "card-title", title),
                    tags$p(class = "card-text", message)))
}

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(theme = shinytheme("united"),
             title = "Natural progress",
             tabPanel("Overview",
                      fluidRow(align="center", # World map selector and focus country
                        column(1),
                        column(10, align = "left",
                               
                               h1("The evolution of progress metrics"),
                               p("Governments have been using GDP as a monetary measure to inform decision making and guage results. While increasing economic results has brought a lot of benefits, we are being confronted with detrimental side effects. Alternative performance indexes have been developed to provede more nuanced views. This site gives you a view of several metrics and explores a new one that is based on strategies from nature.")
                               ),
                        column(1)
                      ),
                      fluidRow(align = "center", # Selector world map
                        column(1),
                        column(10, 
                               p("Select a country to explore more measures"),
                               leafletOutput("leaflet_world")
                        ),
                        column(1)
                      ),
                      fluidRow(align = "center", # Comparison Indicators
                        h2("How does this country compare on previous indicators?")
                      ),
                      fluidRow(
                        column(1),
                        column(10,
                          plotlyOutput("metrics_plot")
                        ),
                        column(1)
                      )),
             navbarMenu("Exploration",
                        tabPanel("Evolution of metrics",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Index timeline"),
                                          generateCard("success", "HEADER", "Title", "message"),
                                          p(class = "warning", "This should be WARNING text.")),
                                   column(1)
                                 )),
                        tabPanel("Gross Domestic Product",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Gross Domestic Product; economic growth"),
                                          leafletOutput("econ_world"),
                                          plotlyOutput("gdp_plot"),
                                          plotlyOutput("gini_plot")),
                                   column(1)
                                 )),
                        tabPanel("Human Development Index",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Human Development Index"),
                                          leafletOutput("hdi_world"),
                                          plotlyOutput("hdi_plot"),
                                          plotlyOutput("hdi_fp_plot")),
                                   column(1)
                                 )),
                        # tabPanel("Better Life Index",
                        #          fluidRow(
                        #            column(1),
                        #            column(10,
                        #                   h1("Better Life Index")),
                        #            column(1)
                        #          )),
                        # tabPanel("Social Progress Index",
                        #          fluidRow(
                        #            column(1),
                        #            column(10,
                        #                   h1("Social Progress Index")),
                        #            column(1)
                        #          )),
                        tabPanel("Ecological Footprint",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Ecological Footprint"),
                                          leafletOutput("fp_world"),
                                          plotlyOutput("fp_plot"),
                                          plotlyOutput("fp_wh_plot")),
                                   column(1)
                                 )),
                        tabPanel("Happiness",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Happiness"),
                                          leafletOutput("h_world"),
                                          plotlyOutput("h_plot"),
                                          plotlyOutput("h_wb_plot")),
                                   column(1)
                                 )),
                        # tabPanel("Happy Planet Index",
                        #          fluidRow(
                        #            column(1),
                        #            column(10,
                        #                   h1("Happy Planet Index")),
                        #            column(1)
                        #          )),
                        tabPanel("Metrics insights",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Metrics insights"),
                                          h2("From human-centric to integrated"),
                                          h2("From local to global"),
                                          h2("From moment to beyond generations"),
                                          h2("From state to (re)generative capacity")),
                                   column(1)
                                 ))
                        ), # End of navbarMenu "Research"
             navbarMenu("Life's Principles",
                        tabPanel("Life's Principles overview",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Life's Principles overview"),
                                          h2("Best practices from 3.8 billion years of R&D"),
                                          h2("Creating conditions conducive to life")),
                                   column(1)
                                 )),
                        tabPanel("Evolve to Survive",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Evolve to survive")),
                                   column(1)
                                 )),
                        tabPanel("Adapt to Changing Conditions",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Adapt to changing conditions")),
                                   column(1)
                                 )),
                        tabPanel("Be Locally Attuned and Responsive",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Be locally attuned and responsive")),
                                   column(1)
                                 )),
                        tabPanel("Integrate Development wth Growth",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Integrate Development with Growth")),
                                   column(1)
                                 )),
                        tabPanel("Be Resource Effcient (Materals and Energy)",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Be resource Efficient (Materials and Energy)")),
                                   column(1)
                                 )),
                        tabPanel("Do Life-Friendly Chemistry",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Do Life-Friendly Chemistry")),
                                   column(1)
                                 ))
             ),
             navbarMenu("About",
                        tabPanel("Objectives",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Objectives"),
                                          p("The objectives of this projects are to provide a tool to explore different progress indexes to date, side-by-side and research how we could use best practices from nature to create a new index that integrates human and other life interests."),
                                          h2("Regenerative index"),
                                          p("Most indexes started with a very human centric view and an exclusive one as that; it did not represent all interests equally. As we experience the consequences of the destruction of nature by man over the last centuries, we need indexes that can guide us to create better conditions for mankind and that help (re)generate the ecosystems that we depend upon."),
                                          h2("Guiding questions"),
                                          p("The following questions came up and were explore while creating this tool."),
                                          h3("What you measure is what you get?"),
                                          h3("What indexes are there and how do they compare?"),
                                          h3("At what point does GDP growth hinder other factors?"),
                                          h3("To what degree is our dependence on ecosystem services acknowledged?"),
                                          h3("What if we move beyond human-centered measures?"),
                                          h3("Can patterns in nature be of value for progress evaluation?")),
                                   column(1)
                                 )),
                        tabPanel("Data quality",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Data Quality"),
                                          h2("Data sources"),
                                          h3("Geographical data"),
                                          p("In order to draw maps and countries we used data from Natural Earth which provides free vector and raster map data @ naturalearthdata.com."),
                                          tags$a(href = "https://www.naturalearthdata.com", tags$img(src = "Natural Earth-Logo-Black_sm.png")),
                                          h3("Gross Domestic Product"),
                                          p("GDP data was obtained from The World Bank Open Data portal which provides free and open access to global development data"),
                                          tags$a(href = "https://data.worldbank.org/indicator/NY.GDP.MKTP.CD", tags$img(src = "World Bank-logo-wb-header-en.svg")),
                                          h3("Inequality"),
                                          p("Inequality data was obtained from the United Natuins University World Income Inequality Database."),
                                          tags$a(href = "https://www.wider.unu.edu/project/wiid-world-income-inequality-database", tags$img(src = "UNU-WIDER-logo.svg")),
                                          h3("Human Development Index"),
                                          p("HDI data was obtained from the United Nations Development Programme Human Development Reports."),
                                          tags$a(href = "http://hdr.undp.org/en/humandev", tags$img(src = "HDI-f-logo.png")),
                                          h3("World Happiness Report"),
                                          p("Happiness Data was obtained from the World Happiness Report 2018."),
                                          tags$a(href = "http://worldhappiness.report/ed/2018/", tags$img(src = "whr-cover-2018.png")),
                                          h3("Social Progress Index"),
                                          tags$a(href = "http://www.socialprogressindex.com", tags$img(src = "SPI_logo_for_web_footer_2.png")),
                                          h3("Ecological Footprint"),
                                          tags$a(href = "http://data.footprintnetwork.org/", tags$img(src = "Global Footprint Network-logo-blue.svg")),
                                          h3("Happy Planet Index"),
                                          tags$a(href = "https://happyplanetindex.org", tags$img(src = "Happy Planet Index-Logo.png")),
                                          h2("Data completeness"),
                                          p("How can we provide a visual overview of how complete the data is per indicator and per country?"),
                                          h2("Merging data"),
                                          p("Data was obtained through a combination of API calls and document downloads and merged for the use in the application."),
                                          p("Challenges in data wrangling were the use of different country identifyers..."),
                                          p("How can we write checks to confirmed merged data corresponds to the sources?")),
                                   column(1)
                                 )),
                        tabPanel("Design choices",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Design Choices"),
                                          h2("Map projections"),
                                          h2("Navigation"),
                                          h2("Choropleth colors"),
                                          h2("Inicator comparisons"),
                                          h2("Plot scales")),
                                   column(1)
                                 )),
                        tabPanel("Open Source",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Open Source"),
                                          h2("Code on GitHub"),
                                          p("The code for the R Shiny app is available on GitHub:"),
                                          a(href="https://github.com/codrin-kruijne/liveso", "Get it here!"),
                                          h2("Data on ..."),
                                          p("To be determined how to make compiled data avialable ...")),
                                   column(1)
                                 )),
                        tabPanel("Developers",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Developers")),
                                   column(1)
                                 ))
                        ) # end of navbarMenu "About"
  ) # End of navbarPage
)
