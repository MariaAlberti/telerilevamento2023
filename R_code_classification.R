library(raster)
# install.packages("RStoolbox")
# library(RStoolbox)

# setwd("~/lab/") # Linux
setwd("D:/.../...") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# data import
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data

# 1. Get all the single values
singlenr <- getValues(so)
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

####

# Grand Canyon


gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

plotRGB(gc, 1, 2, 3, stretch="lin")

# the image is quite big, let's crop it
gcc <- crop(gc, drawExtent())
plotRGB(gcc, 1, 2, 3, stretch="lin")

# 1 Get values
singlenr <- getValues(gcc)

# 2 Classify
kcluster <- kmeans(singlenr, centers = 3)

# 3. Set values
gcclass <- setValues(gcc[[1]], kcluster$cluster) # assign new values to a raster object
gcclass

plot(gcclass)

# class 1: volcanic rocks
# class 2: sandstone
# class 3: conglomerates

frequencies <- freq(gcclass)

total <- ncell(gcclass)

percentages <- frequencies * 100 / total
percentages
