library(vegan)

Community.A <- c(10, 6, 4 ,1)
Community.B <-c(17, rep(1,7))


diversity(Community.A, index = "shannon")
diversity(Community.B, index = "shannon")
diversity(Community.A, index = "invsimpson")
diversity(Community.B, index = "invsimpson")

renyi_a <- renyi(Community.A)
renyi_b <- renyi(Community.B)

plot(renyi_a)
plot(renyi_b)

renyi_ab <- cbind(renyi_a, renyi_b)

plot(renyi_ab)

matplot(renyi_ab, type = "l", axes = F) # as they cross each other, depending on the scale of your renyi u can say that the communities are not that different in terms of diversity.
box()
axis(side = 2)
axis(side = 1, labels = c(0, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, "Inf"), at = 1:11)

legend("topright",
        legend = c("Community A", "Community B"),
       lty = c(1,2),
       col = c(1,2))




# A unifying paradigm: Rao's quadratic entropy
dissimilarity between species i and j


