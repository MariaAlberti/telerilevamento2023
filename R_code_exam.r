#Hi! this is the script for my R project
#this code is focused on the loss of snow of the Villarrica volcano between year 2018 and 2022

#Images from: https://earthobservatory.nasa.gov/images/149463/chilean-volcano-low-on-snow
#Project key points:
# 1.principal components analysis calculation (pca) 
# 2.loss of snow between the two years
# 3.Semiquantitative calculation of the snow coverage loss using unsupervised classification


###### Set the working directory

setwd("D:/Mary/lab/Esame/chilean_volcano")

###### Import and install all the packaged needed for the project

library(raster)    #analyzing and modeling of spatial data
library (rasterVis)
library(RStoolbox) #toolbox for remote sensing image processing 
library(ggplot2)   #for creating graphics
library(patchwork) #combine separate ggplots into the same graphic
library(viridis)   #color scales
library(RColorBrewer)
library(ggpubr)

###### Import the images of the chilean volcano, year 2018 and 2022, and assign a name to the images

# 2018
v18 <- brick("villarrica_oli_2018013_lrg.jpg")

# available informations
v18

# class      : RasterBrick 
# dimensions : 4606, 4647, 21404082, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 4647, 0, 4606  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : villarrica_oli_2018013_lrg.jpg 
# names      : villarrica_oli_2018013_lrg_1, villarrica_oli_2018013_lrg_2, villarrica_oli_2018013_lrg_3 

# 2022
v22 <- brick("villarrica_oli_2022008_lrg.jpg")

# avaiable informations
v22

# class      : RasterBrick 
# dimensions : 4606, 4647, 21404082, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 4647, 0, 4606  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : villarrica_oli_2022008_lrg.jpg 
# names      : villarrica_oli_2022008_lrg_1, villarrica_oli_2022008_lrg_2, villarrica_oli_2022008_lrg_3 

###### plots to see the 3 bands, RED GREEN BLUE
plot(v18)
plot(v22)
dev.off()

###### plots on natural color
g18 <- ggRGB (v18, r =1, g = 2, b = 3, stretch = "lin") +  
        theme(axis.title=element_blank())
g22 <- ggRGB (v22, r =1, g = 2, b = 3, stretch = "lin")+  
        theme(axis.title=element_blank())

# save the image 2018 vs 2022
jpeg("g18+g22_all.jpg", 800, 400)
plot(g18+g22, main="RGB")
dev.off()

###### define the extent and then crop the image to focus on the volcano
ext <- c(400, 1000, 1450, 2150) # define the extention
c18 <- crop(v18,ext)
c22 <- crop(v22,ext)

###### change names of the layers
# 2018
names(c18)<- c("b1_red","b2_green","b3_blue")
# 2022
names(c22)<- c("b1_red","b2_green","b3_blue")

###### plotting the images with a color palette to have a first look
# 2018
cl <- colorRampPalette(brewer.pal(11, 'Spectral'))(100)
plot(c18, col=cl)+
  title("chilean volcano 2018", line = 10)

#  2022
plot(c22, col=cl)+
  title("chilean volcano 2022", line = 10)

###### plots on natural color
# 2018
ggRGB (c18, r =1, g = 2, b = 3, stretch = "lin") +  
  theme(axis.title=element_blank())

# save
jpeg("c18RGB.jpg", 771, 899)
plotRGB (c18, 1, 2, 3, stretch = "lin") 
dev.off()

# 2022
ggRGB (c22, r =1, g = 2, b = 3, stretch = "lin")+  
  theme(axis.title=element_blank())
# save
jpeg("c22RGB.jpg", 771, 899)
plotRGB (c22, 1, 2, 3, stretch = "lin")
dev.off()

###### combine the two image and plot it
i18<- ggRGB (c18, r =1, g = 2, b = 3, stretch = "lin") +  
     theme(axis.title=element_blank()) +
     ggtitle("2018")
i22<- ggRGB (c22, r =1, g = 2, b = 3, stretch = "lin") +  
      theme(axis.title=element_blank()) +
      ggtitle("2022")

t<-ggarrange(i18, i22, ncol=2, nrow=1)

plot18_vs_22 <- annotate_figure(t, top = text_grob("Villarrica Volcano", 
                                      color = "red", face = "bold", size = 14))

###### save plots
ggsave(filename="plot18_vs_22.png", plot = plot18_vs_22)


##################### ------------ ####################### -------------

###### 1. PCA CALCULATION
# to calcolate the pca use function "rasterPCA" of "RStoolbox" package
# the programm will analyse the raster's pca and return some values
#2018
pca2018 <- rasterPCA(c18)
plot(pca2018$map) # pca graphic visual
dev.off()

summary (pca2018$model)
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     114.9789197 18.81872486 8.959462878
# Proportion of Variance   0.9681853  0.02593596 0.005878763
# Cumulative Proportion    0.9681853  0.99412124 1.000000000

pca2022 <- rasterPCA(c22)
plot(pca2022$map) 
dev.off()

summary (pca2022$model)
# Importance of components:
#                          Comp.1      Comp.2      Comp.3
# Standard deviation     86.2739965 17.28565618 8.043159590
# Proportion of Variance  0.9534391  0.03827409 0.008286793
# Cumulative Proportion   0.9534391  0.99171321 1.000000000


#plot of the PCA components 

g1_18 <- ggplot() + 
  geom_raster(pca2018$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC1")


g2_18 <- ggplot() + 
  geom_raster(pca2018$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC2")

g3_18 <- ggplot() + 
  geom_raster(pca2018$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC3")


g1_22 <- ggplot() + 
  geom_raster(pca2022$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC1")


g2_22 <- ggplot() + 
  geom_raster(pca2022$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC2")

g3_22 <- ggplot() + 
  geom_raster(pca2022$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako")+  
  theme(axis.title=element_blank()) +
  ggtitle("PC3")

#save plot 2018
jpeg("PCA_2018.jpg", 900, 300)
plot(g1_18+g2_18+g3_18, col=cl, main="Principal component analysis 2018")
dev.off()

#save plot 2022
jpeg("PCA_2022.jpg", 900, 300)
plot(g1_22+g2_22+g3_22, col=cl, main="Principal component analysis 2022")
dev.off()


####### calculate the difference between the first components #######
diff_pc1 <- pca2018$map$PC1 - pca2022$map$PC1

#assign a color palette 
cl <- colorRampPalette(c("purple", "yellow","orange","red")) (100)
#plot the difference between the first and the second component
plot(diff_pc1, col=cl, main = "Snow variation")
dev.off()


#save plot
jpeg("difference_snow_pc1.jpg", 900, 900)
plot(diff_pc1, col=cl, main="PCA 1 difference")
dev.off()

##################### ------------ ####################### -------------

###### Difference between bands
# red
diff_red <- c18$b1_red - c22$b1_red
# green
diff_green <- c18$b2_green - c22$b2_green
# blue
diff_blue <- c18$b3_blue - c22$b3_blue

# plot
extent_img <- extent(diff_red)
jpeg("difference_RGB.jpg", 900, 900)
par(mfrow=c(1,3))
plot(diff_red, col=cl) + title("2018 vs 2022, red band")
# plot(diff_red, col=cl, axes = FALSE) + title("2018 vs 2022, red band")
# axis(1, at = seq(extent_img@xmin, extent_img@xmax, by = 100)) # Asse x
# axis(2, at = seq(extent_img@ymin, extent_img@ymax, by = 100)) 
plot(diff_green, col=cl) + title("2018 vs 2022, green band")
plot(diff_blue, col=cl) + title("2018 vs 2022, blue band")
dev.off()

jpeg("diff_red.jpg", 900, 900)
plot(diff_red, col=cl, axes = FALSE) + title("Difference on red band")
axis(1, at = seq(extent_img@xmin, extent_img@xmax, by = 100)) # Asse x
axis(2, at = seq(extent_img@ymin, extent_img@ymax, by = 100)) 
dev.off()

##################### ------------ ####################### -------------

#classify with kmeans
#extract pixel value of RGB
c18RGB <- brick("c18RGB.jpg")
rgb_values18 <- getValues(c18RGB)

# clustering K-means and assign pixels to the three classes
num_cluster <- 3
kmeans_result18 <- kmeans(rgb_values18, centers = num_cluster)

## Create a class assignment matrix based on the clustering results:
class18 <- setValues(c18RGB[[1]], kmeans_result18$cluster)

clc <- colorRampPalette(brewer.pal(3, 'BrBG'))(100)
plot(class18, col = clc) # Sovrapponi le classi sul raster RGB

# same for 2022

c22RGB <- brick("c22RGB.jpg")
rgb_values22 <- getValues(c22RGB)

num_cluster <- 3
kmeans_result22 <- kmeans(rgb_values22, centers = num_cluster)

class22 <- setValues(c22RGB[[1]], kmeans_result22$cluster)

clc <- colorRampPalette(brewer.pal(3, 'BrBG')) (3)
plot(class22, col = clc) # Sovrapponi le classi sul raster RGB


# Multiframe 
par(mfrow=c(1,2))
plot(class18, col=clc, main="2018")
plot(class22, col=clc, main="2022") 

# Saving multiframe 
jpeg("class22_ok.jpg", 771, 870)
#par(mfrow=c(1,2))
plot(class18, col=clc, main="2018")
plot(class22, col=clc, main="2022") 
dev.off()

###### calculate number of pixel associated at each class
# Extract the cluster label for each pixel
cluster18 <- kmeans_result18$cluster
cluster22 <- kmeans_result22$cluster

## Calculate the number of pixel for each class
pixel_class18 <- table(cluster18)
pixel_class22 <- table(cluster22)

# indicate which class do you want to plot
class2018 <- 3
class2022 <- 2

# Creates a new raster based on the original raster image with all values initialized to zero
cluster18_raster <- raster(c18RGB)
cluster22_raster <- raster(c22RGB)

# Set all pixels that are not part of the desired class to zero
cluster18_raster[cluster18 != class2018] <- 0
cluster22_raster[cluster22 != class2022] <- 0

# Plot the second class whitch correspond to snow
pal <- colorRampPalette(c("white","black"))
jpeg("class_18vs22.jpg", 1400, 850)
par(mfrow=c(1,2))
plot(cluster18_raster, col = pal(2), legend = FALSE, main = paste("2018 Class", class2018))
plot(cluster22_raster, col = pal(2), legend = FALSE, main = paste("2022 Class", class2022))
dev.off()


##### calculate the difference area
diff_pixel_snow_perc <- ((pixel_class18[3]-pixel_class22[2])/pixel_class18[3])*100 # % difference from 2018 to 2022
area <- (pixel_class18[3]-pixel_class22[2])*(30*30) # the pixel has a dimension of 30*30 m

