# User interface ----
shinyUI(dashboardPagePlus(skin = "blue",
                          title = "Detect Fairy Rings using machine learning",
                          collapse_sidebar = F,
                          header = dashboardHeader(title = tags$a(href='http://www.natur40.org',
                                                                  tags$img(src='logo_new.png', width="40px"))),
                          
                          sidebar = dashboardSidebar(
                            sidebarMenu(
                              menuItem("Research question", tabName = "rq",icon = icon("microscope")),
                              menuItem("Methods", tabName = "methods", icon = icon("microscope"), startExpanded = FALSE,
                                       menuSubItem("Approach: SegOptim", tabName = "seg",icon = icon("object-group")),
                                       menuSubItem("Approach: U-Net", tabName = "unet",icon = icon("project-diagram"))),
                              menuItem("Data", tabName = "methods", icon = icon("microscope"), startExpanded = FALSE,
                                       menuSubItem("Training areas", tabName = "train", icon = icon("train")),
                                       menuSubItem("Rasterstack", tabName = "rasterstack",icon = icon("layer-group"))),
                              menuItem("Results", tabName = "results",icon = icon("university"))
                            )
                          ),
                          
                          body = dashboardBody(id="body",
                                               tags$head(includeCSS('www/style.css')),
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
                                                       leaflet::leafletOutput("map", height = 500) %>% withSpinner(color="#0dc5c1"))
                                                   ),
                                                   br(),
                                                   fluidRow(
                                                     column(
                                                       width = 4, offset = 1,
                                                       imageOutput(outputId = "area_of_interest",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1")),
                                                     column(
                                                       width = 5, offset = 1,
                                                       br(),
                                                       includeMarkdown("descriptions/desc_area_of_int.Rmd")
                                                     )
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
                                                     column(width = 4, offset = 1,
                                                            h2("U-Net - a convolutional neural network"),
                                                            includeMarkdown("descriptions/desc_unet.Rmd")
                                                     ),
                                                     column(width = 5, offset = 1,
                                                            imageOutput(outputId = "unet_architecture",
                                                                        inline = T) %>% withSpinner(color="#0dc5c1")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(width = 4, offset = 6,
                                                            tags$iframe(width="750", height="500", 
                                                                        src="https://lmb.informatik.uni-freiburg.de/people/ronneber/u-net/u-net-teaser.mp4", 
                                                                        frameborder="0", 
                                                                        allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", 
                                                                        allowfullscreen=NA))
                                                   )
                                                 ),
                                                 
                                                 ## Tab: training areas ###
                                                 #-------------------------
                                                 tabItem(
                                                   tabName = "train",
                                                   fluidRow(
                                                     column(width = 10, offset = 1,
                                                            h2("Input data - Training areas")
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
                                                   tabName = "rasterstack",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h3("Input data - Rasterstack"),
                                                       imageOutput(outputId = "rasterstack_demo",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       h5("The original image was (left) was reduced to the extend of the image in the middle and resampled to a resolution of 10x10cm"),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_used_rasterstack.Rmd"),
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
                                                 #------------------
                                                 tabItem(
                                                   tabName = "results",
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h2("Results")
                                                     ),
                                                     column(
                                                       width = 12, offset = 0,
                                                       imageOutput(outputId = "results_all",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1")
                                                     )
                                                   )
                                                 )
                                               )
                          )
)
)

