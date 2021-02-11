library(shiny)
library(shinydashboard);library(shinydashboardPlus)
library(png)
library(dygraphs)

source("global.R")

shinyServer(function(input, output, session) {
  
  output$selected_var <- renderText({
    
    paste("Betrachte hier die unterschiedlichen Messwerte der", input$var, "in den verschiedenen H\u00F6hen des Baumes:")
  })
  
  output$image1 <- renderPlot({
    
  }, width = 400, height = 400)
  
  output$dyTemp <- renderDygraph({
    
  })
  
  output$dyHum <- renderDygraph({
    
  })
}
)
