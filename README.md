### 1071206_BCM_MSc_Dissertation
### Seeing beyond the bottleneck: forecasting tropical forest biodiversity futures using mechanistic eco-evolutionary models
### Appendix: code and data


This repository contains code and data for the appendix of the dissertation described above. Instructions for interpreting and using the contents of this repository are below. Further help with using the _gen3sis_ engine can be found here: https://cran.r-project.org/web/packages/gen3sis/index.html

#### Folder 'inputs'

The file 'biodiv.R' takes the input vector species range data (see main text) and outputs the rasterised species ranges used in the simulation. This species range output is used by the configuration scripts (see Folder 'simulations') to initialise the biodiversity in each simulation. 'data-processing.R' intakes raw climate data (see main text) and outputs RCP 2.6, 4.5, and 8.5 climate change scenarios that get packaged into _gen3sis_ landscapes for the simulation. 'data-processing.R' also produces and outputs _gen3sis_ landscape inputs for the 2030 and 2050 habitat loss scenarios. 'landscapes.R' takes these _gen3sis_ landscape inputs (climate and land use change) and packages them into landscapes for use in simulations. The construction of a baseline scenario, if you wish to run one, is included in this script. 


#### Folder 'simulations'

Folders of the name 'config_XX_XXXX' contain the configuration 'ruleset' of biodiversity to pass to _gen3sis_ for simulations. The numbers correspond to the RCP and habitat loss scenario, respectively (e.g. 'config_26_2030' contains configurations for scenarios utilising RCP 2.6 and a 2030 deforestation peak). Files within these folders are the scripts _gen3sis_ uses to simulate biodiversity. Their naming scheme follows the folders, except with possible additional final tag, (e.g. 'config_26_2030_dis.R'). The final tag represents which configuration of biodiversity the file is for: 'config_XX_XXXX_evo.R' represents a high evolution configuration while 'config_XX_XXXX_dis.R' represents a high dispersal configuration. A plain final tag ('config_XX_XXXX.R') represents a no dispersal/no evolution configuration.

Files of the name structure 'run-XX_XXXX.R' contain the commands that call a landscape and a configuration of biodiversity rules and runs a simulation. The file should be edited to call the configuration of your choice. Naming conventions follow those of the config files (e.g. 'run-26_2030.R' is the file for a scenario utilising RCP 2.6 and a 2030 deforestation peak). Simulations were run using a random seed to ensure both randomness and replicability. Seeds are listed in the output csv files.

#### Folder 'outputs'

The file 'sim_results.csv' contains the biodiversity indicator outputs for each simulation, while the file 'summary_statistics.csv' contains the summary statistics of the biodiversity indicator outputs, including the 95% confidence intervals. The file 'statistics.R' contains the code for calculating these summary statistics as well as for generating the figures visualising the summary statistics. The spatial biodiversity visualisations are automatically produced by _gen3sis_ during the course of a run. All spatial biodiversity plots in the main text are for simulations runs with seed 1 and are representative of their configuration. However, the analysis is completely reproducible using random seeds, so plots of all other simulation runs can be constructed as well simply by running the simulations. 

The files 'abundance_sums.R' and 'divergence_sums.R' contain the algorithms for extracting the final total abundances and final total divergence parameters from the _gen3sis_ output.
