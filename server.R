source("global.R")

shinyServer(function(input, output, session) {
  
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
  output$area_of_interest <- renderPlot({
    
    ima <- readPNG("images/aoi_all.png")
    par(mar = rep(0,4))
    par(bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
    
 }, width = 600, height = 500)
  
  ## plot rgb ###
  #--------------
  output$aoi_to_stack <- renderPlot({
    
    ima <- readPNG("images/aoi_to_stack.png")
    par(mar = rep(0,4), bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
    
  }, width = 1200, height = 500)
  
  ## plot rgb ###
  #--------------
  output$res_demo <- renderPlot({
    
    ima <- readPNG("images/res_demo.png")
    par(mar = rep(0,4), bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
    
  }, width = 1200, height = 500)
  
  output$plotly <- renderPlotly(
    
    plotly <- ggplotly(gplot(fr_selected_small[[as.integer(input$chosen_layer)]]) + 
                       geom_tile(aes(fill = value)) +
                       scale_fill_gradient(low = 'white', high = 'black') +
                       coord_equal() +
                       theme_bw() + 
                       theme(rect = element_rect(fill = "transparent"),
                             panel.background = element_rect(fill = "transparent"),
                             panel.border = element_blank(),
                             panel.grid.major = element_blank(),
                             panel.grid.minor = element_blank(),
                             axis.title = element_blank(),
                             axis.line = element_blank(),
                             axis.ticks = element_blank(),
                             axis.text = element_blank()))
    
  )
  
  ## include markdown, that is describing the current layer ###
  #------------------------------------------------------------
  output$doc_to_display <- renderUI({
    layer_description <- paste0("descriptions/desc_", names(fr_selected_small)[as.integer(input$chosen_layer)], ".Rmd")
    includeMarkdown(layer_description)
  })
 }
)
