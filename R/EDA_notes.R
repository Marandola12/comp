#exploratory data analysis

data(anscombe)

# useful stuff to do:
var()
coef(lm())

# Useful guidelines for you E.D.A.

# where the data is centered
# how it is distributed
# is it bimodal, symmetrical, asymmetrical?
# do we have outliers?
# do we have a normal/gaussian distribution?
# relationships between vars
# do we need var transformation?
# was the sampling effort the same for each observation or variable? was it enough for our question?
# check NAs and 0s
# distribution of each var

mean()
meadian()
sort(table(), decreasing = TRUE)[1] # mode
sd() # standard deviation
quant() # quantile
hist( ,probability =, breaks = seq()) # density plot with prob = TRUE


all_data = read.csv("data/processed/03_Pavoine_full_table.csv")
abd = all_data$Abundance

# a histogram is continuous and a bar plot is for categorical
# revise how the limits of a boxplot are defined (1,5 x o quartil mais proximo)

plot(density(abd))


ab.max = max(abd)
ab.mean = mean(abd)

# histogram with poisson dist to compare
hist(abd, probability = TRUE)
points(dpois(0:ab.max,ab.mean))
lines(dpois(0:ab.max,ab.mean))

# relationships btween vars

all_data$Clay
all_data$Silt

plot(Clay ~ Silt, data = all_data, pch = 19)



cor(all_data[,20:27]) # cut for soil-related data
pairs(all_data[,20:27]) # look on how to do this plot with ggplot i guess (it`s on the slides)


# var response is normal use a linear model if not use a non parametric anaylisis or glm
# hierarchical predictor vars glmm pseudo replication in space or time glmm too


# hierarchical predictor vars are like samples inside a struture which makes them related, like observations inside an OTC.







