# first Git Hub code

# install raster package
install.packages("raster")

library(raster)

# Set working directory
#setwd("~/lab/") # Linux
# setwd("/Users/emma/desktop/lab") #mac
setwd("C:/lab/") # windows

# import
l2011 <- brick("p224r63_2011_masked.grd")
l2011

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

# plot differentcolours
cl1 <- colorRampPalette(c("cyan4", "brown2", "darkgreen")) (100)
plot(l2011, col=cl1)

# de.off() # it closes graphs

# export graph, pdf function
pdf(file = "myfirstgraph.pdf")
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
