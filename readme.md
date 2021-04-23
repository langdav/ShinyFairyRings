How to run:
  - open and run "start_here.R"
  - needed packages get installed automatically (I hope I did not forget any)
  
Please note: there is a video embedded on the 'U-Net' page. To see it, you need to open the homepage in your browser, as the video is not appearing in RViewer

The following packages are needed for the application to run:
"shiny", "shinydashboard", "shinydashboardPlus", "Rcpp", "png", "tidyverse", "dygraphs", "leaflet", "raster", "ggplot2", "rasterVis", "plotly", "shinycssloaders"

You may install them automatically by using the code below:
for(package in c("shiny", "shinydashboard", "shinydashboardPlus", "Rcpp", "png", "tidyverse", "dygraphs", "leaflet", "raster", "ggplot2", "rasterVis", "plotly", "shinycssloaders")){
  if (!require(package, character.only = TRUE)){
    install.packages(package)
    library(package,character.only = TRUE)
  }
}

