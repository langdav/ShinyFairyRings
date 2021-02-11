library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(png)
library(dygraphs)

# User interface ----
shinyUI(dashboardPagePlus(skin = "blue-light",
                          title = "Detect Fairy Rings using machine learning",
                          header = dashboardHeader(title = "Detect Fairy Rings using machine learning"),
                          sidebar = dashboardSidebar(
                            sidebarMenu(
                              menuItem("Area Of Interest", tabName = "tree",icon = icon("tree")),
                              menuItem("Method 1", tabName = "tree",icon = icon("tree")),
                              menuItem("Method 2", tabName = "graph",icon = icon("chart-line")),
                              menuItem("Method 3", tabName = "tree",icon = icon("tree"))
                            )
                          ),
                          
                          body = dashboardBody(id="body",
                                               tabItems(
                                                 tabItem(
                                                   tabName = "tree",
                                                   fluidRow(
                                                     column(
                                                       boxPlus(
                                                         helpText("W\u00e4hle aus, welche Messdaten du sehen m\u00F6chtest:"),
                                                         
                                                         radioButtons("var", 
                                                                      label = "W\u00e4hle eine Variable aus:",
                                                                      choices = c("Temperatur", "Luftfeuchtigkeit"),
                                                                      selected = "Temperatur"),
                                                         
                                                         dateInput("date",
                                                                   label = 'Datum:',
                                                                   value = "2020-06-16"),
                                                         
                                                         sliderInput("time", 
                                                                     label = "Uhrzeit:",
                                                                     min = 0,
                                                                     max = 23,
                                                                     value = 14,
                                                                     step = 1),
                                                         radioButtons("dimension",
                                                                      label = "Werte am Stamm oder in der Krone?",
                                                                      choices = list("Stamm" = "vertical",
                                                                                     "Krone" = "horizontal"),
                                                                      selected = "vertical"),
                                                         radioButtons("tree_id", label ="Welcher Baum?",
                                                                      choices = list("Baum 1" = "mof_cst_00076",
                                                                                     "Baum 2" = "mof_cst_00051",
                                                                                     "Baum 3" = "mof_cst_00028",
                                                                                     "Baum 4" = "mof_cst_00002",
                                                                                     "Baum 5" = "mof_cst_00050"), 
                                                                      selected = "mof_cst_00076")), width = 6),
                                                     column(
                                                       boxPlus(
                                                         h3(textOutput("selected_var")),
                                                         fluidRow(
                                                           imageOutput(outputId = "image1")
                                                           # column(width = 3,
                                                           #        plotOutput(outputId = "Plot")),
                                                           # column(width = 12,
                                                           #        imageOutput(outputId = "image1"))
                                                         )), width = 6)
                                                   )
                                                 ),
                                                 tabItem(
                                                   tabName = "graph",
                                                   fluidRow(boxPlus(
                                                     fluidPage(
                                                       dygraphOutput("dyTemp"),
                                                       dygraphOutput("dyHum")
                                                     )
                                                   )
                                                   ),
                                                   boxPlus(
                                                     fluidRow(helpText("W\u00e4hle aus, welche Messdaten du sehen m\u00F6chtest:"),
                                                              column(dateInput("dygraph_date",
                                                                               label = 'Datum:',
                                                                               value = "2020-06-16"),
                                                                     width = 2),
                                                              column(radioButtons("timespan", label = "Zeitspanne:",
                                                                                  choices = list("Tag" = 86400, "Woche" = 604800, "Monat" = 1092000),
                                                                                  selected = 86400),
                                                                     width = 2),
                                                              column(checkboxGroupInput("positions", label="Messposition:",
                                                                                        choiceNames = list("Level1", "Level2", "Level3", "Level4", "Level5", "Level6", "Level7"),
                                                                                        choiceValues = list("l1", "l2", "l3", "l4", "l5", "l6", "l7"),
                                                                                        selected="l1"),
                                                                     width = 2),
                                                              column(radioButtons("dygraph_tree_id", label ="Baum:",
                                                                                  choices = list("Baum 1" = "mof_cst_00076",
                                                                                                 "Baum 2" = "mof_cst_00051",
                                                                                                 "Baum 3" = "mof_cst_00028",
                                                                                                 "Baum 4" = "mof_cst_00002",
                                                                                                 "Baum 5" = "mof_cst_00050"
                                                                                  ), 
                                                                                  selected = "mof_cst_00076"),
                                                                     width = 2)
                                                     )
                                                   )
                                                 )
                                               )
                          )
))

