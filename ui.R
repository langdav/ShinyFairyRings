for(package in c("shiny", "shinydashboard", "shinydashboardPlus", "Rcpp", "png", "tidyverse", "dygraphs",
                 "leaflet", "raster", "ggplot2", "rasterVis", "plotly", "shinycssloaders")){
  library(package,character.only = TRUE)
}
rm(package)

# User interface ----
shinyUI(dashboardPage(skin = "blue",
                          title = "Detect Fairy Rings using machine learning",
                          header = dashboardHeader(title = tags$a(href='https://github.com/langdav/EnvySys_FairyRings',
                                                                  tags$img(src='logo_new.png', width="50px"))),
                          
                          sidebar = dashboardSidebar(
                            sidebarMenu(
                              menuItem("Research question", tabName = "rq",icon = icon("search")),
                              menuItem("Methods", tabName = "methods", icon = icon("microscope"), startExpanded = FALSE,
                                       menuSubItem("Approach: SegOptim", tabName = "seg",icon = icon("object-group")),
                                       menuSubItem("Approach: U-Net", tabName = "unet",icon = icon("project-diagram"))),
                              menuItem("Data", tabName = "methods", icon = icon("database"), startExpanded = FALSE,
                                       menuSubItem("Training areas", tabName = "train", icon = icon("train")),
                                       menuSubItem("Rasterstack", tabName = "rasterstack",icon = icon("layer-group"))),
                              menuItem("Results", tabName = "results",icon = icon("desktop"))
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
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 5, offset = 1,
                                                       fluidRow(
                                                         includeMarkdown("descriptions/desc_area_of_int.Rmd")
                                                       ),
                                                       fluidRow(
                                                         imageOutput(outputId = "area_of_interest",
                                                                     inline = T) %>% withSpinner(color="#0dc5c1"),
                                                         h5("Orthophoto of the area of interest.")
                                                       )
                                                     ),
                                                     column(
                                                       width = 5, offset = 0,
                                                       leaflet::leafletOutput("map", height = 700) %>% withSpinner(color="#0dc5c1"))
                                                   )
                                                 ),
                                                 
                                                 ## Tab: segOptim ###
                                                 #--------------------
                                                 tabItem(
                                                   tabName = "seg",
                                                   fluidRow(
                                                     column(width = 6, offset = 1,
                                                            h2("SegOptim - object based image classification"),
                                                            includeMarkdown("descriptions/desc_segoptim.Rmd")
                                                     ),
                                                     column(width = 3, offset = 0,
                                                            imageOutput(outputId = "segopt_scheme",
                                                                        inline = T) %>% withSpinner(color="#0dc5c1"),
                                                            h5("Scheme of the SegOptim workflow.")
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
                                                            includeMarkdown("descriptions/desc_unet.Rmd"),
                                                     ),
                                                     column(width = 5, offset = 1,
                                                            imageOutput(outputId = "unet_example",
                                                                        inline = T) %>% withSpinner(color="#0dc5c1"),
                                                            h5("Examples of U-Net image augmentation."),
                                                            
                                                            imageOutput(outputId = "unet_architecture",
                                                                        inline = T) %>% withSpinner(color="#0dc5c1"),
                                                            h5("Structure of the U-Net architecture. 
                                                               Contracting part on the left, expansive part on the right side.")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     br(),
                                                     column(width = 10, offset = 2,
                                                            h3("An explanation form the U-Net authors on how their algorithm works."),
                                                            tags$iframe(width="1000", height="750",
                                                                        src="https://lmb.informatik.uni-freiburg.de/people/ronneber/u-net/u-net-teaser.mp4",
                                                                        frameborder="2",
                                                                        allow="accelerometer; encrypted-media; gyroscope; picture-in-picture",
                                                                        allowfullscreen=NA)
                                                     )
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
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       h5("Training areas (white boxes) and their positions within the area of interest.")
                                                     )
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
                                                       h5("The original image was (left) was reduced to the extend of the image 
                                                          in the middle and resampled to a resolution of 10x10cm."),
                                                       br())),
                                                   fluidRow(
                                                     column(
                                                       width = 8, offset = 2,
                                                       includeMarkdown("descriptions/desc_used_rasterstack.Rmd")
                                                     ),
                                                     br()
                                                   ),
                                                   
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       box(
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
                                                           width = 8, offset = 1,
                                                           plotlyOutput(outputId = "plotly_stack",
                                                                        height = 900) %>% withSpinner(color="#0dc5c1")
                                                           #shinyWidgetOutput("test") %>% withSpinner(color="#0dc5c1")
                                                         ),
                                                         column(
                                                           width = 2, offset = 0,
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
                                                     ),
                                                     column(width = 9, offset = 2,
                                                            h5("Results of U-Net (left), SegOptim wight RGB-Stack (middle-left), 
                                                               SegOptim with large Stack (middle-right) and an RGB image with 
                                                               linear-stretched values for visibility of the Fairy Rings (right).")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 7, offset = 1,
                                                       includeMarkdown("descriptions/desc_results_part1.Rmd"),
                                                       br(),
                                                       imageOutput(outputId = "results_table",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       h5("Results of the validation. Numbers show, how often the respective class was counted. 
                                                          Upper right field: Fairy Ring in validation, classified as Fairy Ring by algorithm; 
                                                          Upper left field: Fairy Ring in validation, classified as non Fairy Ring by algorithm; 
                                                          Lower right field: Non Fairy Ring in validation, classified as Fairy Ring by algorithm; 
                                                          Lower left field: Non Fairy Ring in validation, classified as Non Fairy Ring by algorithm."),
                                                       br(),
                                                       includeMarkdown("descriptions/desc_results_part2.Rmd")
                                                     ),
                                                     column(
                                                       width = 3, offset = 0,
                                                       imageOutput(outputId = "validation",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       h5("Validation raster. A randomly chosen excerpt of the area of interest, that was classified by hand."),
                                                       br(),
                                                       imageOutput(outputId = "left_corner",
                                                                   inline = T) %>% withSpinner(color="#0dc5c1"),
                                                       h5("Lower left corner of the RGB-image; colorspace is a bit off, likely du to a passing cloud.")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       h2("Discussion"),
                                                       includeMarkdown("descriptions/desc_discussion.Rmd")
                                                     )
                                                   ),
                                                   fluidRow(
                                                     column(
                                                       width = 10, offset = 1,
                                                       box(
                                                         width = 12,
                                                         title = NULL,
                                                         closable = F,
                                                         status = "primary",
                                                         column(
                                                           width = 1, offset = 0,
                                                           radioButtons("chosen_result", label ="Result:",
                                                                        choices = results_list, 
                                                                        selected = 1)),
                                                         column(
                                                           width = 9, offset = 1,
                                                           plotlyOutput(outputId = "plotly_result",
                                                                        height = 1000) %>% withSpinner(color="#0dc5c1")
                                                         )
                                                       )
                                                     )
                                                   )
                                                 )
                                               )
                          )
)
)

