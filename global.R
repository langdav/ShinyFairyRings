# Define functions ####
color.bar <- function(level1, level2, level3, level4 = NA, level5 = NA, vertical = T) {
  
  cols <- c("red", "orange", "yellow", "green", "blue")
  
  if(vertical){
    test_frame <- data.frame(level = c("level1","level2","level3","level4","level5"),
                             value = c(level1,level2,level3,level4,level5),
                             color = NA)
    chosen_cols <- data.frame(value = unique(test_frame$value),
                              color = cols[1:length(unique(test_frame$value))])
    
    for(i in 1:nrow(test_frame)){
      test_frame$color[i] <- chosen_cols$color[which(chosen_cols$value == test_frame$value[i])]
    }
    
    # plot(c(0,30), c(0,50), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main='')
    # for (i in 1:nrow(test_frame)) {
    #   y1 = (i-1)*10
    #   y2 = i*10
    #   rect(0,y1,5,y2, col = test_frame$color[i], border = NA)
    # }
  } else {
    test_frame <- data.frame(level = c("level1","level2","level3"),
                             value = c(level1,level2,level3),
                             color = NA)
    chosen_cols <- data.frame(value = unique(test_frame$value),
                              color = cols[1:length(unique(test_frame$value))])
    
    for(i in 1:nrow(test_frame)){
      test_frame$color[i] <- chosen_cols$color[which(chosen_cols$value == test_frame$value[i])]
    }
    
    # plot(c(0,50), c(0,30), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main='')
    # for (i in 1:nrow(test_frame)) {
    #   x1 = (i-1)*10
    #   x2 = i*10
    #   rect(x1,0,x2,5, col = test_frame$color[i], border = NA)
    # }
  }
  
  return(test_frame)
  
}

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
