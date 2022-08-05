library(cluster)
library(vegan)

data(dune)
data(dune.env)
table(dune.env$Management)

bray_dist <- vegdist(dune)

chord_dist <- dist(decostand(dune, "norm"))



library(cluster)
b_cluster <- hclust(bray_dist, method = "average")
c_cluster <- hclust(chord_dist, method = "average")



par(mfrow = c(1, 2))
plot(b_cluster)
plot(c_cluster)



par(mfrow = c(1, 1))

par(mfrow = c(1, 2))
plot(b_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
plot(c_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)



par(mfrow = c(1, 1))


is(chord_dist)
norm <- decostand(dune, "norm")
pca <- rda(norm)

plot(pca)
names(dune.env)
apply(dune.env, 2, class)

dune.env$A1 <- as.numeric(dune.env$A1)
dune.env$Moisture <- as.numeric(dune.env$Moisture)
dune.env$Manure <- as.numeric(dune.env$Manure)

pca_env <- rda(dune.env[, c("A1","Moisture", "Manure")])


plot(pca_env)

cor(dune.env)






