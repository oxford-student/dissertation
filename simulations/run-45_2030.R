library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")
sim3 <- run_simulation(config = "config/config45_2030_evo.R",
                      landscape = "landscape_45_2030", output_directory = "45_2030_ldhe_0.10", call_observer = 20,
                      verbose = 3)
