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
random_seed = 1111
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
setwd("set your own working directory")
biodiv <- rast("biodiv.tif")
temperature <- rast("tempABC.tif")
biodivR <- raster::brick(biodiv)


initial_abundance = 5
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
get_dispersal_values <- function(n, species, landscape, config) {
  values <- runif(n, min=0, max=0)
  return(values) 
}


# Speciation
divergence_threshold = 2000000
get_divergence_factor <- function(species, cluster_indices, landscape, config) {
  return(1) 
}

# Evolution
# This function should make species evolve a higher temperature optimum at each step
# up to a rate of 0.4 degrees C per year
apply_evolution <- function(species, cluster_indices, landscape, config) {
  
  traits <- species[["traits"]]
  # get reference habitat, meaning, where the species that we are dealing with are...
  ref.habitats <- landscape$environment[rownames(traits[, "temp", drop=F]), "temp"]
  # then we take the current difference for this time step!
  diff <- ref.habitats - traits[, "temp"]
  
  # traits are changed based on a normal distribution centered on the temp diff
  # up to a diff of 0.04 deg C
  change <- vector()
  for (i in 1:length(diff)) {
    if (abs(diff[i])<0.04) {
      change[i] <- rnorm(1, mean=diff[i], sd=0.01)
    }
    if (abs(diff[i])>=0.04) {
      change[i] <- rnorm(1, mean=sign(diff[i])*0.04, sd=0.01)
    }
  }
  
  # update traits
  traits[,"temp"] <- traits[,"temp"]+change
 
  return(traits)
}

# Ecology
apply_ecology <- function(abundance, traits, landscape, config, abundance_scale = 0.5, abundance_threshold = 1) {
  # temperature niche: when a species environment is outside its temperature
  #                    niche, its population decreases. When it is inside its
  #                    temperature niche, the population increases. 
  abundance <- (( (0.5 + traits[, "width"]/2) - abs(traits[, "temp"] - landscape[, "temp"]))*abundance_scale)+abundance
  
  # carrying capacity: each species has a carrying capacity of 5 in each cell
  abundance[abundance>5] <- 5
  
  #abundance threshold: if a species' abundance drops below 1 it is extirpated
  #                    from the cell
  abundance[abundance<abundance_threshold] <- 0
  return(abundance)
}


