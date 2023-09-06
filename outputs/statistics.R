setwd("set your own working directory")

results <- read.csv("sim_results.csv", header=TRUE)
results$rel_div_f <- results$div_f/results$rich_f

results_stats <- data.frame(18,1)

barplot(results[which(results$disp==0 & results$evo==0),]$abun_f, names.arg=c("2030/2.6", "2050/2.6", "2030/4.5", "2050/4.5", "2030/8.5", "2050/8.5"))
barplot(results[which(results$disp==0 & results$evo==0),]$rich_f, names.arg=c("2030/2.6", "2050/2.6", "2030/4.5", "2050/4.5", "2030/8.5", "2050/8.5"))

mean_abun <- aggregate(abun_f ~ habitat+rcp+disp+evo, data=results, FUN=mean)
sd_abun <- aggregate(abun_f ~ habitat+rcp+disp+evo, data=results, FUN=sd)
sd_abun$se <- sd_abun$abun_f/sqrt(10)

mean_rich <- aggregate(rich_f ~ habitat+rcp+disp+evo, data=results, FUN=mean)
sd_rich <- aggregate(rich_f ~ habitat+rcp+disp+evo, data=results, FUN=sd)
sd_rich$se <- sd_rich$rich_f/sqrt(10)

mean_div <- aggregate(div_f ~ habitat+rcp+disp+evo, data=results, FUN=mean)
sd_div <- aggregate(div_f ~ habitat+rcp+disp+evo, data=results, FUN=sd)
sd_div$se <- sd_div$div_f/sqrt(10)

mean_reldiv <- aggregate(rel_div_f ~ habitat+rcp+disp+evo, data=results, FUN=mean)
sd_reldiv <- aggregate(rel_div_f ~ habitat+rcp+disp+evo, data=results, FUN=sd)
sd_reldiv$se <- sd_reldiv$rel_div_f/sqrt(10)

par(mar= c(5,6,4,2), cex.lab=1.5)
barplot(mean_abun$abun_f, main="Abundance", 
         
        col=c("lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred"),
        las=2, cex.main=2, space=c(2,0.1,0.1,0.1,0.1,0.1))
mtext("Total number of individuals", line=4.5, side=2, cex=1.5)
abline(h=171843)
legend("topright", legend=c("RCP 8.5", "RCP 4.5", "RCP 2.6"), col=c("darkred", "orange", "lightblue"), lwd=12)


barplot(mean_rich$rich_f, main="Richness",  
        las=2, cex.main=2, ylim=c(0,1000), ylab="Total number of species",
        space=c(2,0.1,0.1,0.1,0.1,0.1),
        col=c("lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred"))
abline(h=964)


barplot(mean_reldiv$rel_div_f, main="Divergence",
        ylab="Per species years of population isolation", cex.main=2,space=c(2,0.1,0.1,0.1,0.1,0.1),
        col=c("lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred","lightblue", "lightblue", "orange", "orange", "darkred", "darkred"))

stats_data <- mean_rich
stats_data$SE_rich <- sd_rich$se
stats_data$abun_f <- mean_abun$abun_f
stats_data$SE_abun <- sd_abun$se
stats_data$reldiv <- mean_reldiv$rel_div_f
stats_data$SE_reldiv <- sd_reldiv$se
stats_data[c(1:6, 13:18), 9:10] <- NA
write.csv(stats_data, file="summary_statistics.csv")
