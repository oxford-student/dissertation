library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")
sim2 <- run_simulation(config = "config/config26_2030_evo.R",
                      landscape = "landscape_26_2030", output_directory = "26_2030_ldhe_2.10", call_observer = 20,
                      verbose = 3)

