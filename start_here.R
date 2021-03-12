packages <- c("shiny", "shinydashboard", "shinydashboardPlus", "png", "tidyverse", "dygraphs", "leaflet")
for(package in packages){
  if (!require(package, character.only = TRUE)){
    install.packages(package)
    library(package,character.only = TRUE)
  }
}
rm(package, packages)  

source("ui.R")
source("server.R")

runApp("~/ShinyFairyRings")
  