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
                              menuItem("Approach: SegOptim", tabName = "seg",icon = icon("object-group")),
                              menuItem("Approach: U-Net", tabName = "unet",icon = icon("project-diagram"))
                            )
                          ),
                          
                          body = dashboardBody(id="body",
                                               tabItems(
                                                 tabItem(
                                                   tabName = "aoi",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h3("Blablabl...Region of interest....blabla...S"),
                                                       br(),
                                                       leaflet::leafletOutput("map", height = 400))
                                                   ),
                                                   br(),
                                                   fluidRow(
                                                     column(
                                                       width = 3, offset = 1,
                                                       imageOutput(outputId = "area_of_interest")),
                                                     column(
                                                       width = 6, offset = 1,
                                                       includeMarkdown("descriptions/desc_area_of_int.Rmd")
                                                     )
                                                   )
                                                 ),
                                                 tabItem(
                                                   tabName = "rgb_stack",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
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
                                                       br()
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       boxPlus(
                                                         width = 12,
                                                         title = "Choose Layer",
                                                         closable = F,
                                                         column(
                                                           width = 1, offset = 0,
                                                           radioButtons("chosen_layer", label ="Layer:",
                                                                        choices = layers, 
                                                                        selected = 1)),
                                                         column(
                                                           width = 5, offset = 1,
                                                           plotlyOutput(outputId = "plotly",
                                                                        height = 600)
                                                         ),
                                                         column(
                                                           width = 5, offset = 0,
                                                           uiOutput("doc_to_display")
                                                         )
                                                       )
                                                     )
                                                   )
                                                 ),
                                                 tabItem(
                                                   tabName = "seg",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            includeMarkdown("descriptions/desc_segoptim.Rmd")
                                                     )
                                                   )
                                                 ),
                                                 tabItem(
                                                   tabName = "unet",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            includeMarkdown("descriptions/desc_unet.Rmd")
                                                     )
                                                   )
                                                 )
                                               )
                          )
)
)

