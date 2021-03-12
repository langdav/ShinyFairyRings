source("global.R")

shinyServer(function(input, output, session) {
  
  # output$image1 <- renderPlot({
  #   if(!is.null(input$map_marker_click)){
  #     op <- par(mar = rep(0, 4))
  #     plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
  #     text(x = 50, y = 50, "F\u00fcr diese Urzeit liegen an \ndiesem Baum leider keine Daten vor.", cex = 2, col = "black")
  #     par(op)
  #   }
  #  
  # }, width = 400, height = 400)
  
  output$map <- renderLeaflet({
    if(is.null(input$map_marker_click)){
      leaflet() %>%
        addProviderTiles(providers$OpenStreetMap,
                         options = providerTileOptions(noWrap = TRUE)) %>%
        addMarkers(data = cbind(1.660626,42.099371), popup = "CLICK ME") %>%
        #addPopups(1.660626,42.099371, "Pont of interest") %>%
        #fitBounds(0, 40, 10, 50) %>%
        setView(1.660626,42.099371, zoom = 5)
    } else {
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldImagery,
                         options = providerTileOptions(noWrap = TRUE)) %>%
        addMarkers(data = cbind(1.660626,42.099371)) %>%
        setView(1.660626,42.099371, zoom = 17)
    }
  })
  
  output$dyTemp <- renderDygraph({
    
  })
  
  output$dyHum <- renderDygraph({
    
  })
}
)
