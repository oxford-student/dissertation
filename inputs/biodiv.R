library(terra)

setwd("set your own working directory")

# carnivora test
# carnivora <- vect("HMW_Carnivora.gpkg")
# carnivoraR <- rast(nlyrs=length(carnivora), crs=crs(temp2), resolution=c(2,2))
# carnivoraR <- rasterize(carnivora, carnivoraR, by="sciname", 
#                         touches=TRUE, fun=min)
# richness <- app(carnivoraR, fun=sum, na.rm=TRUE, cores=3)

# Load mammal range data
mclass <- list.files()

# Crop first batch
mammalia_list <- list()
for (i in 1:2){
  mammalia_list[[i]] <- vect(mclass[i])
}

for (i in 1:length(mammalia_list)) {
  mammalia_list[[i]] <- crop(mammalia_list[[i]], ext(ecoregion_projected))
}
# Crop second batch
mammalia_list2 <- list()
for (i in 1:2){
  mammalia_list2[[i]] <- vect(mclass[i+2])
}

for (i in 1:length(mammalia_list2)) {
  mammalia_list2[[i]] <- crop(mammalia_list2[[i]], ext(ecoregion_projected))
}
# Crop third batch
mammalia_list3 <- list()
for (i in 1:23){
  mammalia_list3[[i]] <- vect(mclass[i+4])
}

for (i in 1:length(mammalia_list3)) {
  mammalia_list3[[i]] <- crop(mammalia_list3[[i]], ext(ecoregion_projected))
}

mammalia_list_complete <- c(mammalia_list, mammalia_list2, mammalia_list3)
mammalia <- vect(mammalia_list_complete)

writeVector(mammalia, "mammalia.gpkg")


# Rasterize mammal range data
mammaliaR <- rast(nlyrs=length(mammalia), crs=crs(temp2), resolution=c(2,2))
mammaliaR <- rasterize(mammalia, mammaliaR, by="sciname",
                       touches=TRUE, fun=min)
mammaliaR <- crop(mammaliaR, ext(ecoregion_projected))
mammaliaRA<- mask(mammaliaR, mask=ecoregion_projected, inverse=F)

setwd("set your own working directory")
writeRaster(mammaliaRA, "biodiv.tif")

richness <- app(mammaliaRA, fun=sum, na.rm=TRUE, cores=3)




