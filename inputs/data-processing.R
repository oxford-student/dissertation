library (terra)


setwd("set your own working directory")

# Load ecoregion and temperature data
ecoregion <- vect("Amazon ecoregion.shx")
temp <- rast("BIO01_hadgem2-cc_rcp45_r1i1p1_1950-2100_v1.0.nc")
ecoregion_projected <- project(ecoregion, temp)

#Create RCP 4.5 temperature projection raster for Amazon ecoregion
temp2 <- aggregate(temp, fact=4, fun="mean")
tempA <- crop(temp2, ext(ecoregion_projected), touches=TRUE)
tempAB <- mask(tempA, mask=ecoregion_projected, inverse=F, touches=TRUE)
tempABC <- tempAB-273.15

colfunc<-colorRampPalette(c("royalblue","springgreen", "yellow","red"))
plot(tempABC[[130]], col=(colfunc(50)))
lines(ecoregion_projected)

temp45 <- tempABC[[51:151]]
#writeRaster(temp45, file="temp45.tif", overwrite=TRUE)
writeRaster(temp45[[1:100]], file="temp_45.tif")

# Create RCP 2.6 projection
glob_mean <- read.csv("tas_global_SSP1_2_6.csv")
glob_mean$diff <- glob_mean$Mean - 1.099248
temp126 <- tempABC[[51:151]]

for (i in 16:101) {
  temp126[[i]] <- temp126[[i]] - ( as.numeric((global(temp126[[i]], "mean", na.rm=TRUE) - 24.77864) - glob_mean$diff[i-15]) + rnorm(1, mean=0, sd=0.25) )
}

ts4.5 <- global(tempABC[[51:151]], "mean", na.rm=TRUE)
ts1_2.6 <- global(temp126[[1:101]], "mean", na.rm=TRUE)
  
#writeRaster(temp126, file="temp126.tif", overwrite=TRUE)
writeRaster(temp126[[1:100]], file="temp_26.tif")

# Create RCP 8.5 projection

temp85 <- rast("BIO01_hadgem2-cc_rcp85_r1i1p1_1950-2100_v1.0.nc")
temp85 <- aggregate(temp85, fact=4, fun="mean")
temp85 <- crop(temp85, ext(ecoregion_projected), touches=TRUE)
temp85 <- mask(temp85, mask=ecoregion_projected, inverse=F, touches=TRUE)
temp85 <- temp85-273.15
plot(temp85[[130]], col=(colfunc(50)))
temp85 <- temp85[[51:151]]

ts8.5 <- global(temp85[[1:101]], "mean", na.rm=TRUE)

par(mar= c(5,6,4,2), cex.lab=1.5)
plot(2000:2099,ts8.5$mean[1:100], type="l", col="darkred", lwd=3, ylab="Degrees celsius", xlab="Year",
     main="Mean ecoregion temperature through time",
     cex.main=2, cex.axis=1.5, cex.lab=2)
lines(2000:2099,ts4.5$mean[1:100], type="l", col="orange", lwd=3)
lines(2000:2099,ts1_2.6$mean, type="l", col="lightblue", lwd=3)
legend("topleft", legend=c("RCP 8.5", "RCP 4.5", "RCP 2.6"), col=c("darkred", "orange", "lightblue"), 
       lwd=8, cex=2)

#writeRaster(temp85, file="temp85.tif", overwrite=TRUE)
writeRaster(temp85[[1:100]], file="temp_85.tif")


# Spatial temperature plots
par(mar= c(5,6,4,2), cex.lab=1.5)
plot(temp126[[1]], col=(colfunc(50)), 
     main="Initial Temperature", range=c(5, 35), cex.main=2,
     mar=c(3,3,3,4), pax=list(cex.axis = 2),
     plg=list(cex = 2)
)
plot(temp126[[100]], col=(colfunc(50)),
     main="RCP 2.6 Final Temperature", range=c(5, 35), cex.main=2,
     mar=c(3,3,3,4), pax=list(cex.axis = 2),
     plg=list(cex = 2))
plot(temp45[[100]], col=(colfunc(50)), 
     main="RCP 4.5 Final Temperature", range=c(5, 35), cex.main=2,
     mar=c(3,3,3,4), pax=list(cex.axis = 2),
     plg=list(cex = 2))
plot(temp85[[100]], col=(colfunc(50)), 
     main="RCP 8.5 Final Temperature", range=c(5, 35), cex.main=2,
     mar=c(3,3,3,4), pax=list(cex.axis = 2),
     plg=list(cex = 2))




#Create land cover raster for Amazon ecoregion
land_cover <- mask(tempABC, ecoregion_projected, inverse=T, updatevalue=1)

# 2030 Peak deforestation scenario
deforest_mask <- tempABC
deforest_mask1 <- deforest_mask
deforest_mask2 <- deforest_mask
deforest_mask1[3:10, 4:14] <- NA
deforest_mask2[4:9, 5:13] <- NA

# deforest2030 <- aridity
# deforested <- list()
land_cover2030 <- land_cover
# deforested <- spatSample(deforest_mask1[[1]], size=30, na.rm=TRUE, cells=TRUE)

for (i in 1:30) {
  if (i%%3==0) {
    land_cover2030[[i:60]][deforested2[i/3,1]] <- NA
  }
}
for (i in 31:60){
  if (i%%3==0) {
    land_cover2030[[i:60]][deforested2[(i-30)/3,1]] <- 1
  }
}

plot(land_cover2030[[1:30]], main=2000:2015)
plot(land_cover2030[[17:40]],main=2015:2030)
plot(land_cover2030[[33:60]], main=2031:2046)
plot(land_cover2030[[49:80]], main=2047:2070)

writeRaster(land_cover2030, "lc_2030.tif")


# 2050 Peak deforestation scenario

land_cover2050 <- land_cover

deforested2 <- spatSample(deforest_mask2[[1]], size=50, na.rm=TRUE, cells=TRUE)

for (i in 1:50) {
  if (i%%3==0) {
    land_cover2050[[i:101]][deforested2[(i/3),1]] <- NA
  }
}
for (i in 51:101){
  if (i%%2==0) {
    land_cover2050[[i:101]][deforested2[(i-50)/2,1]] <- 1
  }
}
plot(land_cover2050[[1:30]], main=2000:2015)
plot(land_cover2050[[17:40]],main=2015:2030)
plot(land_cover2050[[33:60]], main=2031:2046)
plot(land_cover2050[[49:80]], main=2047:2062)
plot(land_cover2050[[63:90]], main=2063:2070)
plot(land_cover2050[[71:95]], main=2071:2095)
plot(land_cover2050[[86:101]], main=2086:2101)

writeRaster(land_cover2050, "lc_2050.tif")



# Land use plots

ts2030 <- vector()
for (i in 1:60) {
  ts2030[[i]] <- as.numeric(global(l2030[[i]], fun="sum", na.rm=T))
}
ts2030 <- abs(ts2030 + (-166))
plot(ts2030, type="l")

ts2050 <- vector()
for (i in 1:82) {
  ts2050[[i]] <- as.numeric(global(l2050[[i]], fun="sum", na.rm=T))
}
ts2050 <- abs(ts2050 + (-166))
plot(ts2050, type="l")

par(mar=c(4,5,2,2))
plot(2000:2081, ts2050, type="l", ylab="Cells of habitat loss", xlab="Year", 
     main="Habitat loss scenarios through time", col="tan", lwd=4,
     cex.main=2, cex.axis=1.5, cex.lab=2)
lines(2000:2059, ts2030, col="forestgreen", lwd=4)
legend("topleft", legend=c("2050 Peak", "2030 Peak"), col=c("tan", "forestgreen"),
       lwd=8, cex=2)

plot(l2030[[1]], main="Initial landscape",legend=NA,
     pax=list(cex.axis = 2), cex.main=2,mar=c(3,2,3,4),
     plg=list(cex = 2))
plot(l2030[[30]], main="2030 Peak", legend=NA,
     pax=list(cex.axis = 2), cex.main=2,mar=c(3,2,3,4),
     plg=list(cex = 2))
plot(l2050[[50]], main="2050 Peak", legend=NA,
     pax=list(cex.axis = 2), cex.main=2,mar=c(3,2,3,4),
     plg=list(cex = 2))





