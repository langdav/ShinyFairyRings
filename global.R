## load packages ###
#------------------
# shinycss needed for adding loading animation
packages <- c("shiny", "shinydashboard", "shinydashboardPlus", "png", "tidyverse", "dygraphs", "leaflet", "raster", "ggplot2", "rasterVis", "plotly", "shinycssloaders")
for(package in packages){
  if (!require(package, character.only = TRUE)){
    install.packages(package)
    library(package,character.only = TRUE)
  }
}
rm(package, packages)

## Define functions ####
### plotting function ###
#------------------------
# plotting_stuff <- function(name_of_image){
#   ima <- readPNG(paste0("images/", name_of_image, ".png"))
#   par(mar = rep(0,4), bg = NA)
#   plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
#   rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
# }

plotting_stuff <- function(name_of_image, w = 600, h = 500){
  renderPlot({
    ima <- readPNG(paste0("images/", name_of_image, ".png"))
    par(mar = rep(0,4), bg = NA)
    plot(NULL, xlim = c(0, 100), ylim = c(0, 100), bty = "n", axes = F)
    rasterImage(ima, 0, 0, 100, 100, interpolate = TRUE)
  }, width = w, height = h)
}

# Read Data ####
#---------------
# Rasterstack vs Rasterbrick:
## in a stack, the bands are stores as links to the data that is stored on the computer; 
## in a brick, the bands are stored in the actual R object

#fr_brick <- stack("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_rgb_resamp10x10.tif")
#fr_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/input_rgb_res10x10.tif")
# fr_big_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/big_stack.tif")
#fr_small_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/small_stack.tif")
fr_selected_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/input_Stacks/selected_variables.grd")
#area_of_interest <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/data/BertRGB20130601.tif")

# ## get some information
# fr_brick
# 

# Create images of different bands ####
#--------------------------------------
# grayscale_colors <- gray.colors(100,            # number of different color levels
#                                 start = 0.0,    # how black (0) to go
#                                 end = 1.0,      # how white (1) to go
#                                 gamma = 2.2,    # correction between how a digital
#                                 # camera sees the world and how human eyes see it
#                                 alpha = NULL)   #Null=colors are not transparent
#
#
## create RGB image of whole area of interest
# png(filename="images/aio_all.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(area_of_interest, axes = F, colNA='transparent', bgalpha = 0)
# dev.off()
# 
# # create RGB image
# png(filename="images/rgb.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick)
# dev.off()
# 
# # create RGB image (lin-stretched; increasing contrast)
# png(filename="images/rgb_lin.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick, stretch = "lin")
# dev.off()
# 
# # create RGB image (hist-stretched; increasing contrast)
# png(filename="images/rgb_hist.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plotRGB(fr_brick, stretch = "hist")
# dev.off()
# 
# ## create grayscale image of red band
# png(filename="images/red_band.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[1]], axes = F, col = grayscale_colors)
# dev.off()
# 
# ## create grayscale image of green band
# png(filename="images/green_band.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[2]], axes = F, col = grayscale_colors)
# dev.off()
# 
# ## create grayscale image of blue band
# png(filename="images/blue_band.png", width = 500, height = 500)
# par(mar = rep(0, 4), bg = NA)
# plot(fr_brick[[3]], axes = F, col = grayscale_colors)
# dev.off()
# 
# 
# rm(fr_brick)
# rm(fr_big_brick)

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


## create list of layers for radioButtons-input for plotly_brick
layers <- list()
for(i in 1:18){
  layers[[i]] <- i
}
rm(i)

fr_selected_small <- brick(paste0(getwd(), "/data/fr_selected_small.tif"))
names(fr_selected_small) <- names(fr_selected_brick)
names(layers) <- names(fr_selected_brick)
#rm(fr_selected_brick)

## create list of layers for radioButtons-input for plotly_results
results_list <- list("U-Net" = 1,
                     "SegOptim_RGB" = 2,
                     "SegOptim_Full_Stack" = 3)

# for(i in names(fr_selected_brick)){
#   p <- ggplotly(gplot(fr_selected_brick[[i]]) +
#                   geom_tile(aes(fill = value)) +
#                   scale_fill_gradient(low = 'white', high = 'black') +
#                   coord_equal() +
#                   theme_bw() +
#                   theme(rect = element_rect(fill = "transparent"),
#                         panel.background = element_rect(fill = "transparent"),
#                         panel.border = element_blank(),
#                         panel.grid.major = element_blank(),
#                         panel.grid.minor = element_blank(),
#                         axis.title = element_blank(),
#                         axis.line = element_blank(),
#                         axis.ticks = element_blank(),
#                         axis.text = element_blank(),
#                         plot.margin = margin(rep(0,4), "px")),
#                 tooltip = "value")
#   saveRDS(p, paste0("data/plotly/", i, ".rds"))
# }


# result_brick <- brick("C:/Users/hhans/HESSENBOX/Umweltysteme_20/segmentation_2020_geo/fuer_david/out_unet.tif")
# 
# values(result_brick)[values(result_brick) == 0] = 1
# values(result_brick)[is.na(values(result_brick))] = 0
# 
# p <- ggplotly(gplot(result_brick) +
#                 geom_tile(aes(fill = value)) +
#                 scale_fill_gradient(low = 'white', high = "black") +
#                 coord_equal() +
#                 theme_bw() +
#                 theme(rect = element_rect(fill = "transparent"),
#                       panel.background = element_rect(fill = "transparent"),
#                       panel.border = element_blank(),
#                       panel.grid.major = element_blank(),
#                       panel.grid.minor = element_blank(),
#                       axis.title = element_blank(),
#                       axis.line = element_blank(),
#                       axis.ticks = element_blank(),
#                       axis.text = element_blank(),
#                       plot.margin = margin(rep(0,4), "px"),
#                       legend.position = "none"),
#               tooltip = "value")
# 
# saveRDS(p, paste0("data/plotly/", "U-Net", ".rds"))



  