# first Git Hub code

# install raster package
install.packages("raster")

library(raster)

# Set working directory
#setwd("~/lab/") # Linux
# setwd("/Users/emma/desktop/lab") #mac
setwd("D:.../.../...") # windows

# import
l2011 <- brick("p224r63_2011_masked.grd")

# plot
plot(l2011)

# https://www.r-graph-gallery.com/42-colors-names.html
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011, col=cl)

# dev.off()

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot one element
#plot(l2011$B1_sre) # trinity
# or
plot(l2011[[4]], col=cl) # plot 4th element
# or
# plot b4, banda NIR
clc <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clc)

# plot B2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
#plot(l2011$B2_sre, col=clg)

# plot differents colours
cl1 <- colorRampPalette(c("cyan4", "brown2", "darkgreen")) (100)
plot(l2011, col=cl1)

# de.off() # it closes graphs

# export graph, pdf function
pdf(file = "myfirstgraph.pdf")
png(file = "myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()

# multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# plotting the first 4 bands
par(mfrow=c(2,2))
# blue
clb <- colorRampPalette(c("blue4", "blue2", "light blue")) (100)
plot(l2011[[1]], col=clb)

plot(l2011[[2]], col=clg)

clr <- colorRampPalette(c("coral3", "coral2", "light coral")) (100)
plot(l2011[[3]], col=clr)

cln <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011[[4]], col=cln)

# plot RGB layers
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# exercise, plot NIR band
plot(l2011[[4]], col=cl)
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# NIR on red
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# NIR on green
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# NIR on blue
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

#import 1988 data
l1988 <- brick("p224r63_1988_masked.grd")

# plot 1988
plot(l1988)

# Excercise: plot in RGB space
plotRGB(l1988, r=3, g=2, b=1, stretch="lin")
plotRGB(l1988, 4, 3, 2, stretch="lin")

# multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="lin")
plotRGB(l2011, 4, 3, 2, stretch="lin")

plotRGB(l1988, r=4, g=3, b=2, stretch="hist")

# multiframe
par(mfrow=c(2,2))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="hist")

# Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Linear vs. Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Exercise: plot the NIR band
plot(l2011[[4]])
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Exercise: import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Lin")

# multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

dev.off()
## null device
## 1
plotRGB(l1988, 4, 3, 2, stretch="Hist")
# multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")


