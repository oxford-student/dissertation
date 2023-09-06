### 1071206_BCM_MSc_Dissertation
### Seeing beyond the bottleneck: forecasting tropical forest biodiversity futures using mechanistic eco-evolutionary models
### Appendix: code and data


This repository contains code and data for the appendix of the dissertation described above. Instructions for interpreting and using the contents of this repository are below. Further help with using the _gen3sis_ engine can be found here: https://cran.r-project.org/web/packages/gen3sis/index.html

#### Folder 'inputs'

The file 'biodiv.R' takes the input vector species range data (see main text) and outputs 'biodiv.tif', the rasterised species ranges used in the simulation. 'biodiv.tif' is used by the configuration scripts (see Folder 'simulations') to initialise the biodiversity in each simulation. 'data-processing.R' intakes raw climate data (see main text) and outputs 'temp_26.tif', 'temp_45.tif', and 'temp_85.tif', which are RCP 2.6, 4.5, and 8.5 climate change scenarios respectively that get packaged into _gen3sis_ landscapes for the simulation. 'data-processing.R' also produces and outputs 'lc_2030' and 'lc_2050


#### Folder 'simulations'

Files of the name 'config_XX_XXXX_AAA.R' contain the configuration 'ruleset' of biodiversity to pass to _gen3sis_ for simulations. The numbers correspond to the RCP and habitat loss scenario, respectively (e.g. 'config_26_2030.R' is the configuration for a scenario utilising RCP 2.6 and a 2030 deforestation peak). The final tag represents which configuration of biodiversity the file is for: 'config_XX_XXXX_evo.R' represents a high evolution configuration while 'config_XX_XXXX_dis.R' represents a high dispersal configuration. A plain final tag ('config_XX_XXXX.R') represents a no dispersal/no evolution configuration.

Files of the name structure 'run-XX_XXXX.R' contain the commands that call a landscape and a configuration of biodiversity rules and runs a simulation. The file should be edited to call the configuration of your choice. Naming conventions follow those of the config files (e.g. 'run-26_2030.R' is the file for a scenario utilising RCP 2.6 and a 2030 deforestation peak).

#### Folder 'outputs'

The file 'sim_results.csv' contains the biodiversity indicator outputs for each simulation, while the file 'summary_statistics.csv' contains the summary statistics of the biodiversity indicator outputs. The file 'statistics.R' contains the code for calculating these summary statistics as well as for generating the figures visualising the summary statistics. The spatial biodiversity visualisations are automatically produced by _gen3sis_ during the course of a run.
