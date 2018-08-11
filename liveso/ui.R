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
                               
                               h1("How should we evaluate progress?"),
                               p("Governments have been using economic groth as a material measure to inform policy making and assessment. While increasing economic results has brought wealth, we are also being confronted with detrimental side effects like climate change. Alternative performance indexes have been created to provide more nuanced views. This site gives you an ", tags$a(href = "#Overview","overview of several metrics", "data-toggle" = "tab"), " and explores developing a new one that is based on strategies from nature.")),
                        column(1)
                      ),
                      fluidRow(align = "center", # Selector world map
                               column(1),
                               column(10, 
                                      leafletOutput("leaflet_world")),
                               column(1)
                      ),
                      fluidRow(align = "center", # Comparison Indicators
                               column(1),
                               column(10,
                                      tags$br(),
                                      generateAlert("info", "Click a country to see some of its scores."),
                                      h2("How does this country compare on previous indicators?")),
                               column(1)
                      ),
                      fluidRow(
                               column(1),
                               column(10,
                                      plotlyOutput("metrics_plot")),
                                      # conditionalPanel(condition = "metrics_plot != NULL",
                                      #                  plotlyOutput("metrics_plot"))),
                               column(1)
                      )),
             navbarMenu("Review ",
                        tabPanel("Evolution of metrics",
                                 fluidRow(align = "left",
                                   column(2),
                                   column(8,
                                          h1("A timeline of indeces"),
                                          p("Over the last decades several proposals have emerged to improve the way of measuring societal progress beyond economic growth that has been the standad for th last centuries."), tags$br(), tags$br(),
                                          generatePanel("info", "17th century - Economic Growth", p("Still mainstream is measuring economic growth using", tags$a(href = "https://en.wikipedia.org/wiki/Gross_domestic_product", "Gross Domstic Product."), "The idea is that the better the economy, the better the material situation for people. The problem with GDP is that it does not take into account the harmful effects on the environment.")),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          generatePanel("warning", "Since 1990 - Human Development", p("The ", tags$a(href = "https://en.wikipedia.org/wiki/Human_Development_Index", "Human Development Index"), "takes as main dimensions a decent standard of living and adds a the notions of long and healthy life and knowledge to make the most of it.")),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          generatePanel("success", "Since 1999 - Imact on Nature", p("The ", tags$a(href = "https://en.wikipedia.org/wiki/Ecological_footprint", "Ecological Footprint"), "measures the impact of mankind on natural systems and covers carbon footprint from energy, built-up land, forest, cropland and pasture and fisheries. Currently most coutnries are consuming more than they can produce and thus we are consuming our production capacity.")),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          generatePanel("warning", "Since 2012 - Happiness and well-being", p("A question that arises is to what degree we have an improved quality of life and it seems that after basic needs are met, people do not become happier by pursuing material progress, yet the destruction of ecosystems increases. More attention to measuring happiness and well-being is covered in the ", tags$a(href = "https://en.wikipedia.org/wiki/World_Happiness_Report", "World Happiness Report"))),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          generatePanel("danger", "Since 2013 - Social Imperative", p("The ", tags$a(href = "https://en.wikipedia.org/wiki/Social_Progress_Index", "Social Progress Index"), "expands on these notions and is based on three dimensions; basic human needs, foundations of well-being and opportunity. The problem with this index is that the effect of these human pursuits on the ecosystems we depend upon are still subordinate to human progress.")),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          # Since 2015 - Social Development Goals Index http://www.sdgindex.org/overview/
                                          generatePanel("default", "2016 - Happy Planet", p("Combinin ghte idea of the pursuit of many happy life years as well as recognising the limitations of the ecosysems that need to enable them, the ", tags$a(href = "https://en.wikipedia.org/wiki/Happy_Planet_Index", "Happy PLanet Index"), " sought to combine these two major components. While it measures the current state, it seems to lack the nuance of future capacity.")),
                                          tags$div(align = "center", tags$i(class="glyphicon glyphicon-arrow-down")), tags$br(),
                                          generatePanel("primary", "Natural progress", "The objective of this project is to explore whether we can use best practices from nature, described as Life's Principles in Biomimicry, to create a metric that comprises socital progress as well as ensuring ecological regeneration so that we can improve the quality of life for all organisms, now and in future.")),
                                   column(2)
                                 )),
                        tabPanel("- Gross Domestic Product",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Gross Domestic Product; economic growth"),
                                          leafletOutput("econ_world"),
                                          plotlyOutput("gdp_plot"),
                                          plotlyOutput("gini_plot")),
                                   column(1)
                                 )),
                        tabPanel("- Human Development Index",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Human Development Index"),
                                          leafletOutput("hdi_world"),
                                          plotlyOutput("hdi_plot"),
                                          plotlyOutput("hdi_fp_plot")),
                                   column(1)
                                 )),
                        tabPanel("- Ecological Footprint",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Ecological Footprint"),
                                          leafletOutput("fp_world"),
                                          plotlyOutput("fp_plot"),
                                          plotlyOutput("fp_wh_plot")),
                                   column(1)
                                 )),
                        tabPanel("- Happiness and well-being",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Happiness and well-being"),
                                          leafletOutput("h_world"),
                                          plotlyOutput("h_plot"),
                                          plotlyOutput("h_wb_plot")),
                                   column(1)
                                 )),
                        tabPanel("- Social Progress Index",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Social Progress Index")),
                                   column(1)
                                 )),
                        tabPanel("- Social Development Goals",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Social Development Goals Index")),
                                   column(1)
                                 )),
                        tabPanel("- Happy Planet Index",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          h1("Happy Planet Index")),
                                   column(1)
                                 )),
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
             tabPanel("Analyses",
                      fluidRow(
                        column(1),
                        column(10,
                               h1("Analyses of combined data")),
                        column(1)
                      )),
             navbarMenu("Life's Principles",
                        tabPanel("Biomimicry and Life's Principles",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Biomimicry"),
                                          p("Biomimicry is the conscious pursuit of life's genius"),
                                          h2("3.8 billion years of R&D"),
                                          p("Life has evolved to thrive in the same conditions that we face. Recognising that the organisms that surround us hold some experience we could learn from, biomimicry is a meme that covers our relationship with nature, our connection with nature and our pursuit to design using her insights.")),
                                   column(4,
                                          tags$br(), tags$br(),
                                          tags$img(src = "biomimicry/Biomimicry38_DesignLens_Diagram_Only_Essential_Elements_RGB.png", width = "338px", height = "338px", align = "right")),
                                 column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h2("Creating conducive to life"),
                                          p("The Biomimicry Thinking process is a design method that incorporates knowledge from organisms and best practices from nature.")),
                                   column(4,
                                          tags$br(), tags$br(),
                                          tags$img(src = "biomimicry/Biomimicry38_DesignLens_Diagram_Only_Biomimicry_Thinking_RGB.png", width = "338px", height = "338px", align = "right")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h2("Succesful patterns"),
                                          p("Life's principles are patterns of solutions that all organisms embody to some degree and can be seen as 'best practices' from 3.8 biollion years of evolution. Life's Principles can be used as design guidelines to ensure the pursuit of sustainable solutions, as well as measures to evaluate against.")),
                                   column(4,
                                          tags$br(), tags$br(),
                                          tags$img(src = "biomimicry/Biomimicry38_DesignLens_Diagram_Only_Lifes_Principles_Top6_RGB.png", width = "338px", height = "338px", align = "right")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Evolve to Survive",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Evolve to survive"),
                                          p("\"Continually incorporate and embody information to ensure enduring performance.\""),
                                          h2("Replicate Strategies that Work"),
                                          p("\"Repeat succesfull approaches.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Education?"),
                                          h2("Integrate the Unexpected"),
                                          p("\"Incorporate mistakes in ways that can lead to new forms and functions. \""),
                                          h4("How to translate this concept to society?"),
                                          p("Creativity?"),
                                          h2("Reshuffle Information"),
                                          p("\"Exchange and alter information to create new options. \""),
                                          h4("How to translate this concept to society?"),
                                          p("Innovation?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Evolve_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Adapt to Changing Conditions",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Adapt to changing conditions"),
                                          p("\"Appropriately respond to dynamic contexts.\""),
                                          h2("Incorporate Diversity"),
                                          p("\"Include multiple forms, processes, or systems to meet a functional need.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Diversity of what? People and technologies?"),
                                          h2("Maintain Integrity Through Self-Renewal"),
                                          p("\"Persis by constantly adding energy and matter to heal and improve the system.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Maintenance, repair of what?"),
                                          h2("Embody Resilience Through Variation, Redundancy, and Decentralization"),
                                          p("\"Maintain function following disturbance by incorporating a variety of duplicate forms, processes, or systems that are not located exclusively together.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Basic infrastructure? Water, foor, energy, transportation?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Adapt_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Be Locally Attuned and Responsive",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Be locally attuned and responsive"),
                                          p("\"Fit into and integrate with the surrounding environment.\""),
                                          h2("Leverage Cyclical Processes"),
                                          p("\"Take advantage of phenomena that repeat themselves.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Use Readily Available Materials and Energy"),
                                          p("\"Build with abundant, accesible materials while harnessing freely available energy.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Use Feedbacl Loops"),
                                          p("\"Engage in cyclic information flows to modify a reaction appropriately.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Cultivate Cooperative Relationships"),
                                          p("\"Find value through win-win interactions.\""),
                                          h4("How to translate this concept to society?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Attuned_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Integrate Development wth Growth",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Integrate Development with Growth"),
                                          p("\"Invest optimally in strategies that promote both development and growth.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Self-Organize"),
                                          p("\"Create conditions to allow components to interact in concert to move toward an enriched system.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Participative democracy?"),
                                          h2("Build from the Bottom-Up"),
                                          p("\"Assemble components one unit at a time.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Small government?"),
                                          h2("Combine Modular and Nested Components"),
                                          p("\"Fit multiple units within each  other progressively from simple to complex.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Reuse orgganisational best practices?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Growth_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Be Resource Effcient (Materals and Energy)",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Be resource Efficient (Materials and Energy)"),
                                          p("\"Skilfully and conservatively take advantage of resources and opportunities.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Degree of solar, wind, tidal, gravitational?"),
                                          h2("Use Low Energy Processes"),
                                          p("\"Minimize energy consumption by reducing requisite temperatures, pressures, and/or time for reaction.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Energy use?"),
                                          h2("Use Multi-Functional Design"),
                                          p("\"Meet multiple needs with one elegant solution.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Recycle All Materials"),
                                          p("\"Keep all materials in a closed loop.\""),
                                          h4("How to translate this concept to society?"),
                                          p("Garbage generation?"),
                                          h2("Fit Form to Function"),
                                          p("\"Select for shape or pattern based on need.\""),
                                          h4("How to translate this concept to society?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Efficient_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("- Do Life-Friendly Chemistry",
                                 fluidRow(
                                   column(1),
                                   column(6,
                                          h1("Do Life-Friendly Chemistry"),
                                          p("\"Use chemistry that supports life processes.\""),
                                          h2("Break Down Products into Benign Constituents"),
                                          p("\"Use chemistry in which decomposition results in no harmful by-products.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Build Selectively with a Small Subset of Elements"),
                                          p("\"Assemble relatively few elements in elegant ways.\""),
                                          h4("How to translate this concept to society?"),
                                          h2("Do Chemistry in Water"),
                                          p("\"Use water as a solvent.\""),
                                          h4("How to translate this concept to society?")),
                                   column(4,
                                          tags$img(src = "biomimicry/Biomimicry38_LP_Vertical_Life-Friendly_WEB.jpg", width = "270px", height = "270px")),
                                   column(1)
                                 ),
                                 fluidRow(
                                   column(1),
                                   column(10,
                                          tags$br(),
                                          generateAlert("warning", "Biomimicry diagrams and descriptions are all copyright 2013 Biomimicry 3.8 and licenced under Creative Commons BY-NC-ND. Life's Principles g6 (generation 6).")),
                                   column(1)
                                 )),
                        tabPanel("Discussion of Life's Principles as metrics",
                                 fluidRow(
                                   column(1),
                                   column(10),
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
                                          p("The way data is presented can influence very much how it is perceived. Our aim is to show you the objective data as well as argue for new ways of measuring progress that address som of the limitations of previous efforts. We link back to all original sources and share the code we created and data gathered as open source resources to be scrutinized and improved upon. We welcome your ", tags$a(href="mailto:codrin@biomimicryNL.org", "feedback.")),
                                          h2("Map projections"),
                                          p("Historically the way the world has been projected on maps (the way you represent the surface of a 3D sphere on a 2D piece of paper, has biased the way people looking at the world, e.g. underrepresenting the size of Africa. Maybe we should use the", tags$a(href="https://en.wikipedia.org/wiki/Winkel_tripel_projection", "Winkel Triple Projection.")),
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
             footer = fluidRow(align = "left",
                               tags$br(), tags$br(),
                               tags$div(class = "progress", tags$div(class = "progress-bar", style = "width: 100%;")),
                               column(1),
                               column(2,
                                      h4("Objective"),
                                      p("Our objective is to review metrics that evaluate the progress of society and to exlopre strategies from nature in developing a metric that evaluates societal and ecological state.")),
                               column(2,
                                      h4("Results"),
                                      p("We are working on gathering and standardising existing metrics, visualising them to provoke questioning and exploring the quantification of best practices from nature to use as progress metrics.")),
                               column(2,
                                      h4("Open"),
                                      p("We strive for open results to be scrutinized and built upon. See GitHub and Data.World for sources.")),
                               column(2,
                                      h4("Contribute"),
                                      p("We could really use some help on either the data engineering, visualisation, user interface or communication part of the project!")),
                               column(2,
                                      h4("Connect"),
                                      p("Please contact one of the developers if you have the motivation and skills to contribute voluntarily to this project!")),
                               column(1)
             )
  ) # End of navbarPage
)
