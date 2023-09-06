library (terra)
library (gen3sis)
library (raster)

# Version: 1.0
# Author:
# Date:
# Landscape:
# Publications:
# Description:


# Settings
random_seed = 1
start_time = NA
end_time = NA
max_number_of_species = 2000
max_number_of_coexisting_species = 1000
trait_names = c("temp", "width")
environmental_ranges = list()


# Observer
end_of_timestep_observer <- function(data, vars, config) {
  save_species()
  save_richness()
  save_divergence()
  save_abundance()
  save_landscape()
  save_traits()
  plot_richness(data$all_species, data$landscape)
}


# Initialization
# I am still working on setting a relative filepath. I have only used them in 
# the context of Rprojects before
setwd("set your own working directory")
biodiv <- rast("biodiv.tif")
temperature <- rast("tempABC.tif")
biodivR <- raster::brick(biodiv)


initial_abundance = 5
# this initializes species with a niche breadth 'width' based on the range of temperatures
# they occupy at the start of the simulation, with the midpoint of this range
# deemed the niche optimum 'temp' trait
create_ancestor_species <- function (landscape, config) {
  new_species <- list()
  for (i in 1:nlayers(biodivR)) {
    new_species[[i]] <- create_species(as.character(Which(biodivR[[i]], cells=TRUE, na.rm=TRUE)), config)
    new_species[[i]]$traits[ ,"width"] <- as.numeric(global(mask(temperature[[1]], biodiv[[i]]), "max", na.rm=TRUE)) - as.numeric(global(mask(temperature[[1]], biodiv[[i]]), "min", na.rm=TRUE))
    new_species[[i]]$traits[ ,"temp"] <- as.numeric(global(mask(temperature[[1]], biodiv[[i]]), "min", na.rm=TRUE)) + (new_species[[i]]$traits[ ,"width"])/2
  }
  
  return(new_species)
}

# Dispersal
# no dispersal
get_dispersal_values <- function(n, species, landscape, config) {
  values <- runif(n, min=0, max=0)
  return(values) 
}


# Speciation
# no speciation
divergence_threshold = 2000000
get_divergence_factor <- function(species, cluster_indices, landscape, config) {
  return(1) 
}

# Evolution
# no evolution
apply_evolution <- function(species, cluster_indices, landscape, config) {
  traits <- species[["traits"]]
  return(traits)
}

# Ecology
# when a species is inside its temperature niche, its population increases up to
# a carrying capacity of 5. If it is outside it decreases until it is less than 1,
# when it would go extinct. 
apply_ecology <- function(abundance, traits, landscape, config, abundance_scale = 0.5, abundance_threshold = 1) {
  # temperature niche: when a species environment is outside its temperature
  #                    niche, its population decreases. When it is inside its
  #                    temperature niche, the population increases. The amount
  #                    of change is proportional to the distance from the temp
  #                    optimum
  abundance <- (( (0.5 + traits[, "width"]/2) - abs(traits[, "temp"] - landscape[, "temp"]))*abundance_scale)+abundance
  
  # carrying capacity: each species has a carrying capacity of 5 in each cell
  abundance[abundance>5] <- 5
  
  #abundance threshold: if a species' abundance drops below 1 it is extirpated
  #                    from the cell
  abundance[abundance<abundance_threshold] <- 0
  return(abundance)
}


