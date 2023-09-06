library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")
sim4 <- run_simulation(config = "config/config85_2030_evo.R",
                      landscape = "landscape_85_2030", output_directory = "85_2030_ldhe_0.10", call_observer = 20,
                      verbose = 3)
