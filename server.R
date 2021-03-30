source("global.R")

shinyServer(function(input, output, session) {
  
  ## plot fairy_drake ###
  #---------------------------
  output$fairy_drake <- plotting_stuff("fairy_drake")
  
  ## draw map ###
  #--------------
  output$map <- renderLeaflet({
    if(is.null(input$map_marker_click)){
      leaflet() %>%
        addProviderTiles(providers$OpenStreetMap,
                         options = providerTileOptions(noWrap = TRUE)) %>%
        addMarkers(data = cbind(1.660626,42.099371), label = "CLICK ME", labelOptions = labelOptions(permanent = T)) %>%
        #addPopups(1.660626,42.099371, "Pont of interest") %>%
        #fitBounds(0, 40, 10, 50) %>%
        setView(1.660626,42.099371, zoom = 5)
    } else {
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldImagery,
                         options = providerTileOptions(noWrap = TRUE)) %>%
        addRectangles(lng1 = 1.659, lat1 = 42.0977, lng2 = 1.664, lat2 = 42.1005, fill = F, color = "red") %>%
        setView(1.6614,42.099, zoom = 16)
    }
  })
  
  ## plot area of interest ###
  #---------------------------
  output$area_of_interest <- plotting_stuff("aoi_all", 650, 550)
  
  ## plot segopt_scheme ###
  #----------------------------
  output$segopt_scheme <- plotting_stuff("segopt_scheme", 500, 800)
  
  ## plot unet_architecture & example###
  #-------------------------------------
  output$unet_architecture <- plotting_stuff("u-net-architecture",750, 500)
  output$unet_example <- plotting_stuff("unet_example", 750, 750)
  
  ## plot training area ###
  #------------------------
  output$training <- plotting_stuff("training_areas", 600, 600)
  
  ## plot stack overview $ plotly_stack output + markdown, that is describing the chosen layer###
  #----------------------------------------------------------------------------------------------
  output$rasterstack_demo <- plotting_stuff("stack_overview", 1600, 500)
  
  output$plotly_stack <- renderPlotly(
    plotly_stack <- readRDS(paste0("data/plotly/", names(fr_selected_brick)[as.integer(input$chosen_layer)], ".rds"))
  )
  
  output$doc_to_display <- renderUI({
    layer_description <- paste0("descriptions/layers/", names(fr_selected_small)[as.integer(input$chosen_layer)], ".Rmd")
    includeMarkdown(layer_description)
  })
  
  ## plot results & validation & render plotly_result output###
  #------------------------------------------------------------
  output$results_all <- plotting_stuff("comparison_all",1800,450)
  output$validation <- plotting_stuff("validation", 500)
  
  output$plotly_result <- renderPlotly(
    plotly_result <- readRDS(paste0("data/plotly/", names(results_list)[as.integer(input$chosen_result)], ".rds"))
  )
}
)
