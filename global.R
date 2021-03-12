### load packages
packages <- c("shiny", "shinydashboard", "shinydashboardPlus", "png", "tidyverse", "dygraphs", "leaflet")
for(package in packages){
  if (!require(package, character.only = TRUE)){
    install.packages(package)
    library(package,character.only = TRUE)
  }
}
rm(package, packages) 

convert.to.pos <- function(chosen_date, chosen_time) {
  date <- as.character(chosen_date)
  time <- as.character(chosen_time)
  
  datetime <- as.POSIXct(paste0(date,time), tz = "UTC", format = "%Y-%m-%d %H")
  return(datetime)
}

## prepare Data ###
# ecowitt <- readRDS("data/temp_humid.RDS")
# ecowitt$tree_id <- gsub(" ","",ecowitt$tree_id)
# 
# trees_list <- NULL
# for(i in unique(ecowitt$tree_id)){
#   tree <- ecowitt %>% subset(tree_id == i)
#   tree_lvls <- NULL
#   for(u in unique(ecowitt[which(ecowitt$tree_id == i), "level"])){
#     tree_lvl <- tree[which(tree$level == u), c("datetime", "temp", "humid" )]
#     colnames(tree_lvl)[2] <- paste0("temp_",u)
#     colnames(tree_lvl)[3] <- paste0("humid_",u)
#     if(is.null(tree_lvls)){
#       tree_lvls <- tree_lvl
#     } else {
#       tree_lvls <- merge(tree_lvls, tree_lvl, by = "datetime", incomparables = NA)
#     }
#   }
#   row.names(tree_lvls) <- tree_lvls$datetime
# 
#   #assign(i,tree_lvls[,-1])
# 
#   trees_list[[i]] <- tree_lvls
# }
# 
## reduce entrys to only one entry for every hour; reduce time-accuracy to hour (as it is enough for this usecase; reduces size of data from > 9MB to < 1MB)
# trees_list <- lapply(trees_list, function(tree){
#   tree$datetime <- trunc(tree$datetime,"hours")
#   tree <- tree[!duplicated(tree$datetime),]
#   return(tree)
# })
#
# saveRDS(trees_list, "data/trees_list.RDS")

# Read Data ####
#trees_list <- readRDS("data/trees_list.RDS")
