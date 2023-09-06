library (terra)
library (raster)
library (gen3sis)

setwd("set your own working directory")
sim4 <- run_simulation(config = "config/config85_2050.R",
                      landscape = "landscape_85_2050", output_directory = "85_2050_ldle_1.1", call_observer = 20,
                      verbose = 3)


