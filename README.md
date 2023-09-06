### 1071206_BCM_MSc_Dissertation
### Seeing beyond the bottleneck: forecasting tropical forest biodiversity futures using mechanistic eco-evolutionary models
### Appendix: code and data


This repository contains code and data for the appendix of the dissertation described above. Instructions for interpreting and using the contents of this repository are below.

#### Folder 'inputs

#### Folder 'simulations'

Files of the name 'config_XX_XXXX_AAA.R' contain the configuration 'ruleset' of biodiversity to pass to gen3sis for simulations. The numbers correspond to the RCP and habitat loss scenario, respectively (e.g. 'config_26_2030.R' is the configuration for a scenario utilising RCP 2.6 and a 2030 deforestation peak). The final tag represents which configuration of biodiversity the file is for: 'config_XX_XXXX_evo.R' represents a high evolution configuration while 'config_XX_XXXX_dis.R' represents a high dispersal configuration. A plain final tag ('config_XX_XXXX.R') represents a no dispersal/no evolution configuration.

Files of the name structure 'run-XX_XXXX.R' contain the commands that call a landscape and a configuration of biodiversity rules and runs a simulation. The file should be edited to call the configuration of your choice. Naming conventions follow those of the config files (e.g. 'run-26_2030.R' is the file for a scenario utilising RCP 2.6 and a 2030 deforestation peak).

#### Folder 'outputs'

The file 'sim_results.csv' contains the biodiversity indicator outputs for each simulation, while the file 'summary_statistics.csv' contains the summary statistics of the biodiversity indicator outputs. The file 'statistics.R' contains the code for calculating these summary statistics as well as for generating the figures visualising the summary statistics. The spatial biodiversity visualisations are automatically produced by gen3sis during the course of a run.
