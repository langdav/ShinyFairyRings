# load packages ###
#------------------
packages <- c("shiny", "shinydashboard", "shinydashboardPlus", "png", "tidyverse", "dygraphs", "leaflet")
for(package in packages){
  if (!require(package, character.only = TRUE)){
    install.packages(package)
    library(package,character.only = TRUE)
  }
}
rm(package, packages)


# Read Data ####
#---------------
# Rasterstack vs Rasterbrick:
## in a stack, the bands are stores as links to the data that is stored on the computer; 
## in a brick, the bands are stored in the actual R object

library(raster)
#fr_brick <- stack("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_rgb_resamp10x10.tif")
fr_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/input_rgb_res10x10.tif")
# fr_big_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/big_stack.tif")
fr_small_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/small_stack.tif")
fr_selected_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/selected_variables.tif")

test_brick <- brick(paste0(getwd(), "/data/sel_var_clipped_small.tif"))

# ## get some information
# fr_brick
# 

# Create images of different bands ####
#--------------------------------------
grayscale_colors <- gray.colors(100,            # number of different color levels
                                start = 0.0,    # how black (0) to go
                                end = 1.0,      # how white (1) to go
                                gamma = 2.2,    # correction between how a digital
                                # camera sees the world and how human eyes see it
                                alpha = NULL)   #Null=colors are not transparent

# create RGB image
# png(filename="images/rgb.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick)
# dev.off()
# 
# # create RGB image (lin-stretched; increasing contrast)
# png(filename="images/rgb_lin.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick, stretch = "lin")
# dev.off()
# 
# # create RGB image (hist-stretched; increasing contrast)
# png(filename="images/rgb_hist.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick, stretch = "hist")
# dev.off()
# 
# ## create grayscale image of red band
# png(filename="images/red_band.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[1]], axes = F, col = grayscale_colors)
# dev.off()
# 
# ## create grayscale image of green band
# png(filename="images/green_band.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[2]], axes = F, col = grayscale_colors)
# dev.off()
# 
# ## create grayscale image of blue band
# png(filename="images/blue_band.png", width = 920, height = 920)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[3]], axes = F, col = grayscale_colors)
# dev.off()
# 
# rm(fr_brick)
# rm(fr_big_brick)






library(ggplot2)

library(rasterVis)
library(plotly)

# s <- matrix(c(1, -.75, -.75, 1), ncol = 2)
# obs <- mvtnorm::rmvnorm(500, sigma = s)
# 
# 
# fig <- plot_ly(values(fr_brick[[1]]))
# fig2 <- subplot(
#   fig %>% add_markers(alpha = 0.2),
#   fig %>% add_histogram2d()
# )
# 
# fig2
# 
# plot_ly(z = fr_brick[[1]], type = "heatmap")
# 
# test <- gplot(test_brick[[5]]) + 
#   geom_tile(aes(fill = value)) +
#   scale_fill_gradient(low = 'white', high = 'black') +
#   coord_equal() +
#   theme_bw() + 
#   theme(panel.border = element_blank(),
#         panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank(),
#         axis.line = element_line(colour = "black"),
#         axis.title = element_blank())
# 
# 
# ggplotly(test)

# leaflet() %>% addTiles() %>%
#   addRasterImage(fr_brick[[1]], colors = grayscale_colors, opacity = 0.8, maxBytes = 6 * 1024 * 1024) %>%
#   addLegend(pal = pal, values = values(fr_brick),
#             title = "Surface temp")
