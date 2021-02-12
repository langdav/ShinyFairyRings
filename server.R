library(shiny)
library(shinydashboard);library(shinydashboardPlus)
library(png)
library(dygraphs)

source("global.R")

shinyServer(function(input, output, session) {
  
  output$selected_var <- renderText({
    
    paste("Area of interest: blablabla, Italy")
  })
  
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldImagery,
                       options = providerTileOptions(noWrap = TRUE)
       ) %>%
      #addTiles() %>%
       addMarkers(data = cbind(1.660626,42.099371))
  })
  
  output$dyTemp <- renderDygraph({
    
  })
  
  output$dyHum <- renderDygraph({
    
  })
}
)
