# User interface ----
shinyUI(dashboardPagePlus(skin = "blue",
                          title = "Detect Fairy Rings using machine learning",
                          collapse_sidebar = F,
                          header = dashboardHeader(title = tags$a(href='http://www.natur40.org',
                                                                  tags$img(src='logo_new.png', width="40px"))),
                          
                          sidebar = dashboardSidebar(
                            sidebarMenu(
                              menuItem("Research question", tabName = "rq",icon = icon("microscope")),
                              menuItem("Approach: SegOptim", tabName = "seg",icon = icon("object-group")),
                              menuItem("Approach: U-Net", tabName = "unet",icon = icon("project-diagram")),
                              menuItem("Training areas", tabName = "train", icon = icon("train")),
                              menuItem("RGB Stack", tabName = "rgb_stack",icon = icon("layer-group")),
                              menuItem("Results", tabName = "results",icon = icon("layer-group"), startExpanded = TRUE,
                                       menuSubItem("SegOptim", tabName = "result_seg", icon = icon("stream")),
                                       menuSubItem("U-Net", tabName = "result_unet", icon = icon("stream"))
                              )
                            )
                          ),
                          
                          body = dashboardBody(id="body",
                                               tabItems(
                                                 
                                                 ## Tab: Research question ###
                                                 #----------------------------
                                                 tabItem(
                                                   tabName = "rq",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            h2("Fairy Rings")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 6, offset = 1,
                                                       includeMarkdown("descriptions/desc_fairy_rings.Rmd")
                                                     ),
                                                     column(
                                                       width = 3, offset = 0,
                                                       imageOutput(outputId = "fairy_drake",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"))
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 6, offset = 1,
                                                       h2("Area of interest")
                                                     ),
                                                     column(
                                                       width = 10, offset = 1,
                                                       leaflet::leafletOutput("map", height = 400) %>% withSpinner(color="#0dc5c1"))
                                                   ),
                                                   br(),
                                                   fluidRow(
                                                     column(
                                                       width = 5, offset = 1,
                                                       includeMarkdown("descriptions/desc_area_of_int.Rmd")
                                                     ),
                                                     column(
                                                       width = 4, offset = 0,
                                                       imageOutput(outputId = "area_of_interest",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"))
                                                   )
                                                 ),
                                                 
                                                 ## Tab: segOptim ###
                                                 #--------------------
                                                 tabItem(
                                                   tabName = "seg",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            h2("SegOptim - object based image classification"),
                                                            includeMarkdown("descriptions/desc_segoptim.Rmd")
                                                     )
                                                   )
                                                 ),
                                                 
                                                 ## Tab: Unet ###
                                                 #---------------
                                                 tabItem(
                                                   tabName = "unet",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            h2("U-Net - a convolutional neural network"),
                                                            includeMarkdown("descriptions/desc_unet.Rmd")
                                                     )
                                                   )
                                                 ),
                                                 
                                                 ## Tab: training areas ###
                                                 #-------------------------
                                                 tabItem(
                                                   tabName = "train",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            h2("Training areas")
                                                     )
                                                   ),
                                                   
                                                   fluidRow(
                                                     column(width = 6, offset = 1,
                                                            includeMarkdown("descriptions/desc_training.Rmd")
                                                     ),
                                                     column(
                                                       width = 3, offset = 0,
                                                       imageOutput(outputId = "training",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"))
                                                   )
                                                 ),
                                                 
                                                 ## Tab: RGB Stack ###
                                                 #--------------------
                                                 tabItem(
                                                   tabName = "rgb_stack",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h3("Blablabl...RGB Rasterstack"),
                                                       includeMarkdown("descriptions/desc_used_rasterstack.Rmd"),
                                                       br(),
                                                       imageOutput(outputId = "aoi_to_stack",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_rescaling.Rmd"),
                                                       br(),
                                                       imageOutput(outputId = "res_demo",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
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
                                                         status = "primary",
                                                         column(
                                                           width = 1, offset = 0,
                                                           radioButtons("chosen_layer", label ="Layer:",
                                                                        choices = layers, 
                                                                        selected = 1)),
                                                         column(
                                                           width = 5, offset = 1,
                                                           plotlyOutput(outputId = "plotly",
                                                                        height = 600) %>% withSpinner(color="#0dc5c1")
                                                         ),
                                                         column(
                                                           width = 5, offset = 0,
                                                           uiOutput("doc_to_display") %>% withSpinner(color="#0dc5c1")
                                                         )
                                                       )
                                                     )
                                                   )
                                                 ),
                                                 
                                                 ## Tab: Results ###
                                                 ### Results SegOptim ###
                                                 #-----------------------
                                                 tabItem(
                                                   tabName = "result_seg",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h2("Results of the SegOptim approach"),
                                                       imageOutput(outputId = "seg_res",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1")
                                                     )
                                                   )
                                                 ),
                                                 
                                                 ### Results U-Net ###
                                                 #--------------------
                                                 tabItem(
                                                   tabName = "result_unet",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h2("Results of the U-Net approach"),
                                                       imageOutput(outputId = "unet_res",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1")
                                                     )
                                                   )
                                                 )
                                               )
                          )
)
)

