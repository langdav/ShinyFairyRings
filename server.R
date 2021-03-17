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
        addRectangles(lng1 = 1.6609, lat1 = 42.0986, lng2 = 1.6619, lat2 = 42.0993, fill = F, color = "red") %>%
        setView(1.6614,42.099, zoom = 17)
    }
  })
  
  ## plot area of interest ###
  #---------------------------
  output$area_of_interest <- renderPlot({
    
    ima <- readPNG("images/rgb.png")
    par(mar = rep(0,4))
    par(bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
    
 }, width = 550, height = 550)
  
  ## plot rgb ###
  #--------------
  output$resampling_example <- renderPlot({
    
    ima <- readPNG("images/res_demo.png")
    par(mar = rep(0,4), bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, -10, -10, 110, 110, interpolate = TRUE)
    
  }, width = 900, height = 450)
  
  ## plot rgb ###
  #--------------
  output$rgb <- renderPlot({
    
    ima <- readPNG("images/rgb.png")
    par(mar = rep(0,4))
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, -10, -10, 110, 110, interpolate = TRUE)
    
  }, width = 400, height = 400)
  
  ## plot red band ###
  #-------------------
  output$red_band <- renderPlot({
    
    ima <- readPNG("images/red_band.png")
    par(mar = rep(0,4))
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, -10, -10, 110, 110, interpolate = TRUE)
    
  }, width = 400, height = 400)
  
  ## plot green band ###
  #---------------------
  output$green_band <- renderPlot({
    
    ima <- readPNG("images/green_band.png")
    par(mar = rep(0,4))
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, -10, -10, 110, 110, interpolate = TRUE)
    
  }, width = 400, height = 400)
  
  ## plot green band ###
  #---------------------
  output$blue_band <- renderPlot({
    
    ima <- readPNG("images/blue_band.png")
    par(mar = rep(0,4))
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, -10, -10, 110, 110, interpolate = TRUE)
    
  }, width = 400, height = 400)
  
  output$test <- renderPlotly(
    test <- ggplotly(gplot(fr_selected_brick[[5]]) + 
                       geom_tile(aes(fill = value)) +
                       scale_fill_gradient(low = 'white', high = 'black') +
                       coord_equal() +
                       theme_bw() + 
                       theme(panel.border = element_blank(),
                             panel.grid.major = element_blank(),
                             panel.grid.minor = element_blank(),
                             axis.line = element_line(colour = "black"),
                             axis.title = element_blank()))
  )
 }
)
