# This script creates the user interface for the Shiny application.

library(shiny)
library(shinythemes) 
library(plotly)
library(leaflet)

# Bootswatch theme component generators https://bootswatch.com/3/united/

generateAlert <- function(type, message){
  # Types: warning (yellow), danger (red), success (green), info (blue)
  tags$div(class = paste0("alert alert-dismissable alert-", type), tags$button(type = "button", class = "close", `data-dismiss` = "alert", "x"), message)
}

generatePanel <- function(type, title, content){
  # Types: primary (orange), success (green), danger (red), warning (yellow), info (blue)
  tags$div(class = paste0("panel panel-", type),
           tags$div(class="panel-heading",
                    tags$h3(class = "panel-title", title)),
           tags$div(class = "panel-body", content))
}

generateBlockquote <- function(words, origin){
  tags$blockquote(class = "blockquote-reverse", tags$p(words), tags$small(origin))
}

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(theme = shinytheme("united"),
             position = "fixed-top",
             tags$head(tags$style(type="text/css", "body {padding-top: 70px;}")),
             selected = "Overview",
             title = "Natural progress",
             tabPanel("Overview",
                      fluidRow(align = "center", # World map selector and focus country
                        column(1),
                        column(10, align = "left",
                               
                               h1("The evolution of measuring progress"),
                               p("Governments have been using GDP as a monetary measure to inform decision making and guage results. While increasing economic results has brought a lot of benefits, we are being confronted with detrimental side effects. Alternative performance indexes have been developed to provede more nuanced views. This site gives you a view of several metrics and explores a new one that is based on strategies from nature.")),
                        column(1)
                      ),
                      fluidRow(align = "center", # Selector world map
                        column(1),
                        column(10, 
                               generateAlert("info", "Click a country to see some of its scores."),
                               leafletOutput("leaflet_world")),
                        column(1)
                      ),
                      fluidRow(align = "center", # Comparison Indicators
                        h2("How does this country compare on previous indicators?")
                      ),
                      fluidRow(
                        column(1),
                        column(10,
                          plotlyOutput("metrics_plot")),
                        column(1)
                      )),
             navbarMenu("Exploration",
                        tabPanel("Evolution of metrics",
                                 fluidRow(align = "center",
                                   column(3),
                                   column(6,
                                          h1("A timeline of indeces"),
                                          p("Over thelast decades several proposalshave emerged to improve the way of measuring societal progress."),
                                          generatePanel("info", "Measuring Economy", "Gros Domstic Product"),
                                          tags$i(class="glyphicon glyphicon-arrow-down"), tags$br(), tags$br(),
                                          generatePanel("warning", "Human Progress", "Human Development Index"),
                                          tags$i(class="glyphicon glyphicon-arrow-down"), tags$br(), tags$br(),
                                          generatePanel("danger", "Social Imperative", "Social Progress Index"),
                                          tags$i(class="glyphicon glyphicon-arrow-down"), tags$br(), tags$br(),
                                          generatePanel("success", "Imact on Nature", "Ecological Footprint"),
                                          tags$i(class="glyphicon glyphicon-arrow-down"), tags$br(), tags$br(),
                                          generatePanel("warning", "Happiness and well-being", "Quality of life"),
                                          tags$i(class="glyphicon glyphicon-arrow-down"), tags$br(), tags$br(),
                                          generatePanel("primary", "Natural progress", "Quality oflife for all organisms, now ad in future")),
                                   column(3)
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
                                          h1("Happiness and well-being"),
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
                                          h1("Evolve to survive"),
                                          h2("Replicate Strategies that Work"),
                                          h2("Integrate the Unexpected"),
                                          h2("Reshuffle Information")),
                                   column(1)
                                 )),
                        tabPanel("Adapt to Changing Conditions",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Adapt to changing conditions"),
                                          h2("Incorporate Diversity"),
                                          h2("Maintain Integrity Through Self-Renewal"),
                                          h2("Embody Resilience Through Variation, Redundancy, and Decentralization")),
                                   column(1)
                                 )),
                        tabPanel("Be Locally Attuned and Responsive",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Be locally attuned and responsive"),
                                          h2("Leverage Cyclical Processes"),
                                          h2("Use Readily Available Materials and Energy"),
                                          h2("Use Feedbacl Loops"),
                                          h2("Cultivate Cooperative Relationships")),
                                   column(1)
                                 )),
                        tabPanel("Integrate Development wth Growth",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Integrate Development with Growth"),
                                          h2("Self-Organize"),
                                          h2("Build from the Bottom-Up"),
                                          h2("Combine Modular and Nested Components")),
                                   column(1)
                                 )),
                        tabPanel("Be Resource Effcient (Materals and Energy)",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Be resource Efficient (Materials and Energy)"),
                                          h2("Use Low Energy Processes"),
                                          h2("Use Multi-Functional Design"),
                                          h2("Recycle All Materials"),
                                          h2("Fit Form to Function")),
                                   column(1)
                                 )),
                        tabPanel("Do Life-Friendly Chemistry",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Do Life-Friendly Chemistry"),
                                          h2("Break Down Products into Benign Constituents"),
                                          h2("Build Selectively with a Small Subset of Elements"),
                                          h2("Do Chemistry in Water")),
                                   column(1)
                                 ))
             ), # End of navbarMenu "Life's Principles"
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
                                          tags$a(href = "http://data.footprintnetwork.org/", tags$img(src = "Global Footprint Network-logo-blue.svg", width = "250px")),
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
                                          p("The way data is presented can influence very much how it is perceived. Our aim is to show you the objective data as well as argue for new ways of measuring progress that address som of the limitations of previous efforts. We link back to all original sources and share the code we created and data gathered as open source resources to be scrutinized and improved upon. We welcome your "), tags$a(href="mailto:codrin@biomimicryNL.org", "feedback."),
                                          h2("Map projections"),
                                          p("Historically the way the world has been projected on maps (the way you represent the surface of a 3D sphere on a 2D piece of paper, has biased the way people looking at the world, e.g. underrepresenting the size of Africa. Maybe we should use the"), tags$a(href="https://en.wikipedia.org/wiki/Winkel_tripel_projection", "Winkel Triple Projection."),
                                          h2("Navigation"),
                                          p("We welcome the visitor with a current state of the world that will show the to be developed index results and when a country is selected the comparison on previous metrics. From there the background of the previous metrics can be explored as well as the considerations made for developing the Natural Progress Index."),
                                          h2("Choropleth colors"),
                                          p(" Should we use colors on a continuous scale that allows comparison between countries, or on a diverging scale to give a sense of good or problematic state?"),
                                          h2("Inicator comparisons"),
                                          p("Should we compare absolute numbers or relative (normalized) scores? How do we help people to make sense of the units? To what degree do we want to instill a sense of (subjective) urgency?"),
                                          h2("Plot scales"),
                                          p("Are people biased to see rising graph as something good? How to deal with that?")),
                                   column(1)
                                 )),
                        tabPanel("Open Source",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Open Source"),
                                          h2("Code on GitHub"),
                                          p("The code for the data gathering and wrangling and R Shiny app is available on GitHub:"),
                                          tags$br(),
                                          tags$br(),
                                          tags$a(href = "https://github.com/codrin-kruijne/liveso", tags$img(src = "GitHub-Mark-120px-plus.png", width = "120")),
                                          h2("Data on ..."),
                                          p("We are exploring the use of Data.World to make data gathered available"),
                                          tags$a(href = "https://data.world/", tags$img(src = "DataWorld-logo.png", width = "120"))),
                                   column(1)
                                 )),
                        tabPanel("Developers",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Developers"),
                                          tags$p("This project has been initiated by Codrin Kruijne as a firt project for a Data Science portfolio."),
                                          tags$a(href = "https://www.linkedin.com/in/codrinkruijne/", tags$img(src = "LinkedInCodrinKruijne.PNG", width = "300")),
                                          tags$br(),
                                          tags$br(),
                                          tags$a(href = "https://www.datacamp.com/profile/codrinkruijne", tags$img(src = "DataCampLogo.png", width = "252")),
                                          generateBlockquote("O so wise words", "o wise one")),
                                   column(1)
                                 ))
                        ), # end of navbarMenu "About",
             footer = fluidRow(align = "center",
                               tags$br(), tags$br(),
                               tags$div(class = "progress", tags$div(class = "progress-bar", style = "width: 100%;")),
                               column(3,
                                      h4("Objective"),
                                      p("blablabla")),
                               column(3,
                                      h4("Results"),
                                      p("blablabla")),
                               column(3,
                                      h4("Contribute"),
                                      p("blablabla")),
                               column(3,
                                      h4("Connect"),
                                      p("blablabla"))
             )
  ) # End of navbarPage
)
