## load packages ###
#------------------
library(png)
library(raster)

## Define plotting function ###
#------------------------------
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
#fr_selected_brick <- brick("YOUR_DIRECTORY/selected_variables.grd")


## create/read list of layers for radioButtons-input for plotly_brick ###
#------------------------------------------------------------------------
# layers <- list()
# for(i in 1:18){
#   layers[[i]] <- i
# }
# names(layers) <- names(fr_selected_brick)
# saveRDS(layers, "data/selected_layers_list.rds")
# rm(i)
layers <- readRDS("data/selected_layers_list.rds")
  

## create layers plotly_brick ###
#--------------------------------
# for(i in names(fr_selected_brick)){
#   p <- ggplotly(gplot(fr_selected_brick[[i]], maxpixels = 50000) +
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


## create list of layers for radioButtons-input for plotly_results ###
#---------------------------------------------------------------------
results_list <- list("U-Net" = 1,
                     "SegOptim_RGB" = 2,
                     "SegOptim_Full_Stack" = 3)
 


## create  plotly_results ###
#----------------------------
# plotly_results <- list("out_unet" = "U-Net",
#                        "segoptim_rgb_result" = "SegOptim_RGB",
#                        "segoptim_result_rasterStack" = "SegOptim_Full_Stack")
# for(i in 1:length(plotly_results)){
#   result_brick <- brick(paste0("YOUR_DIRECTORY", names(plotly_results)[i], ".tif"))
#   if(names(plotly_results)[i] == "out_unet"){
#     values(result_brick)[values(result_brick) == 0] = 1
#     values(result_brick)[is.na(values(result_brick))] = 0
#   }
#   p <- ggplotly(gplot(result_brick, maxpixels = 500000) +
#                   geom_tile(aes(fill = value)) +
#                   scale_fill_gradient(low = 'white', high = "black") +
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
#                         plot.margin = margin(rep(0,4), "px"),
#                         legend.position = "none"),
#                 tooltip = "value")
#   saveRDS(p, paste0("data/plotly/", plotly_results[[i]], ".rds"))
# }

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
  