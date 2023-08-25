# R_code_multivariate_analysis.r

library(raster)
library(ggplot2)

# setwd("~/lab/") # Linux
setwd("D:/.../...") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

sen <- brick("sentinel.png")

sen
plot(sen)

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])

plot(sen2)

pairs(sen2)

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained
summary(pca)

# correlation with original bands
pca

# pc map
pci <- predict(sen2, pca, index=c(1:2))

plot(pci[[1]])

# ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()


# speeding up analyses
# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

