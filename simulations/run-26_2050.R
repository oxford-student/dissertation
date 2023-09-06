library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")
sim8 <- run_simulation(config = "config/config26_2050_evo.R",
                      landscape = "landscape_26_2050", output_directory = "26_2050_ldhe_0.10", call_observer = 20,
                      verbose = 3)
