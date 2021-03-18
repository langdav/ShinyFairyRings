# User interface ----
shinyUI(dashboardPagePlus(skin = "blue",
                          title = "Detect Fairy Rings using machine learning",
                          collapse_sidebar = F,
                          header = dashboardHeader(title = tags$a(href='http://www.natur40.org',
                                                                  tags$img(src='logo_new.png', width="40px"))),
                          sidebar = dashboardSidebar(
                            sidebarMenu(
                              menuItem("Area Of Interest", tabName = "aoi",icon = icon("microscope")),
                              menuItem("RGB Stack", tabName = "rgb_stack",icon = icon("layer-group")
                                       # menuSubItem("red band", tabName = "r", icon = icon("stream")),
                                       # menuSubItem("green band", tabName = "g", icon = icon("stream")),
                                       # menuSubItem("blue band", tabName = "b", icon = icon("stream"))
                              ),
                              menuItem("Method 2", tabName = "method2",icon = icon("chart-line")),
                              menuItem("Method 3", tabName = "method3",icon = icon("tree"))
                            )
                          ),
                          
                          body = dashboardBody(id="body",
                                               tabItems(
                                                 tabItem(
                                                   tabName = "aoi",
                                                   fluidRow(
                                                     column(
                                                       h3("Blablabl...Region of interest....blabla...S"),
                                                       br(),
                                                       leaflet::leafletOutput("map", height = 400),
                                                       width = 10, offset = 1)
                                                   ),
                                                   br(),
                                                   fluidRow(
                                                     column(
                                                       imageOutput(outputId = "area_of_interest"),
                                                       width = 3, offset = 1),
                                                     column(
                                                       includeMarkdown("descriptions/desc_area_of_int.Rmd"),
                                                       width = 6, offset = 1)
                                                   )
                                                 ),
                                                 tabItem(
                                                   tabName = "rgb_stack",
                                                   fluidRow(
                                                     column(
                                                       h3("Blablabl...RGB Rasterstack"),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_used_rasterstack.Rmd"),
                                                       br(),
                                                       imageOutput(outputId = "aoi_to_stack"),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_rescaling.Rmd"),
                                                       br(),
                                                       imageOutput(outputId = "res_demo"),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_layers.Rmd"),
                                                       br(),
                                                       width = 10, offset = 1)),
                                                   fluidRow(
                                                     column(
                                                       radioButtons("chosen_layer", label ="Layer:",
                                                                    choices = layers, 
                                                                    selected = 1),
                                                       width = 1, offset = 1),
                                                     column(
                                                       plotlyOutput(outputId = "plotly",
                                                                    height = 600),
                                                       width = 5, offset = 1),
                                                     column(
                                                       uiOutput("doc_to_display"),
                                                       width = 3, offset = 0
                                                     ))
                                                 )
                                               )
                          )
)
)

