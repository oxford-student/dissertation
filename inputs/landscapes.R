library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")

# Load data
temp26 <- rast("temp_26.tif")
temp45 <- rast("temp_45.tif")
temp85 <- rast("temp_85.tif")

lc2030 <- rast("lc_2030.tif", lyrs=1:100)
lc2050 <- rast("lc_2050.tif", lyrs=1:100)

# Colours for plotting
colfunc<-colorRampPalette(c("royalblue","springgreen", "yellow","red"))

setwd("set your own working directory")

###############################################
# Baseline: no climate change or deforestation
###############################################

temp_baseline <- temp45[[1:100]]
for (i in 1:nlyr(temp_baseline)) {
  temp_baseline[[i]] <- temp45[[1]]
}

plot(temp_baseline, col=colfunc(100))
temp_baseline <- raster::brick(temp_baseline)

landscapes_list <- list()
for (i in 1:nlayers(temp_baseline)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp_baseline[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_baseline", timesteps = paste0(seq(1,
                       101, by = 1), "Year"), crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)


#####################
# RCP 2.6 landscapes
#####################

# 2030 deforestation peak
temp26_2030 <- mask(temp26, lc2030, inverse=FALSE, updatevalue=NA)
temp26_2030 <- subset(temp26_2030, c(100:1))
plot(temp26_2030, col=colfunc(100))
temp26_2030 <- raster::brick(temp26_2030)

landscapes_list <- list()
for (i in 1:nlayers(temp26_2030)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp26_2030[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_26_2030", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)

# 2050 deforestation peak
temp26_2050 <- mask(temp26, lc2050, inverse=FALSE, updatevalue=NA)
temp26_2050 <- subset(temp26_2050, c(100:1))
plot(temp26_2050, col=colfunc(100))
temp26_2050 <- raster::brick(temp26_2050)

landscapes_list <- list()
for (i in 1:nlayers(temp26_2050)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp26_2050[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_26_2050", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)


#####################
# RCP 4.5 landscapes
#####################

# 2030 deforestation peak
temp45_2030 <- mask(temp45, lc2030, inverse=FALSE, updatevalue=NA)
temp45_2030 <- subset(temp45_2030, c(100:1))
plot(temp45_2030, col=colfunc(100))
temp45_2030 <- raster::brick(temp45_2030)

landscapes_list <- list()
for (i in 1:nlayers(temp45_2030)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp45_2030[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_45_2030", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)

# 2050 deforestation peak
temp45_2050 <- mask(temp45, lc2050, inverse=FALSE, updatevalue=NA)
temp45_2050 <- subset(temp45_2050, c(100:1))
plot(temp45_2050, col=colfunc(100))
temp45_2050 <- raster::brick(temp45_2050)

landscapes_list <- list()
for (i in 1:nlayers(temp45_2050)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp45_2050[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_45_2050", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)


#####################
# RCP 8.5 landscapes
#####################

# 2030 deforestation peak
temp85_2030 <- mask(temp85, lc2030, inverse=FALSE, updatevalue=NA)
temp85_2030 <- subset(temp85_2030, c(100:1))
plot(temp85_2030, col=colfunc(100))
temp85_2030 <- raster::brick(temp85_2030)

landscapes_list <- list()
for (i in 1:nlayers(temp85_2030)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp85_2030[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_85_2030", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)

# 2050 deforestation peak
temp85_2050 <- mask(temp85, lc2050, inverse=FALSE, updatevalue=NA)
temp85_2050 <- subset(temp85_2050, c(100:1))
plot(temp85_2050, col=colfunc(100))
temp85_2050 <- raster::brick(temp85_2050)

landscapes_list <- list()
for (i in 1:nlayers(temp85_2050)) {
  landscapes_list$temp <- c(landscapes_list$temp, temp85_2050[[i]])
}

cost_function_null <- function(source, habitable_src, dest, habitable_dest) {
  return(1/1000)
}

create_input_landscape(landscapes = landscapes_list, cost_function = cost_function_null,
                       directions = 8, output_directory = "landscape_85_2050", 
                       timesteps = paste0(seq(1,100, by = 1), "Year"), 
                       crs = "+proj=longlat +datum=WGS84 +no_defs",
                       calculate_full_distance_matrices = TRUE)


