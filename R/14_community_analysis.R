
files_path <- list.files(path = "data/raw/cestes",
                         pattern = ".csv",
                         full.names = TRUE)

file_names <- gsub(".csv", "", basename(files_path), fixed = TRUE)
for (i in 1:length(files_path)) {
  data <- read.csv(files_path[[i]])
  assign(file_names[i], data)
}

# checking data
head(comm[1:6])

# tidying data
rownames(comm) <- paste0("Site", comm[,1])
comm <- comm[,-1]
head(comm)[,1:6]

# richness and diversity
library(vegan)

sp_richness <- specnumber(comm)

shannon_div <- diversity(comm, index = 'shannon')
simpson_div <- diversity(comm, index = 'simpson')

# Functional Diversity
  # Gower distance is a common distance metric used in trait-based ecology

library(cluster)
library(FD)

# tidying data:
rownames(traits) <- traits$Sp
traits <- traits[,-1]

div_gower <- cluster::daisy(traits[,-1], metric = 'gower')
div_gower_2 <- FD::gowdis(traits[,-1])

identical(div_gower, div_gower_2) # why different?

class(div_gower)
class(div_gower_2)

plot(div_gower, div_gower_2, asp = 1)

library(SYNCSA)

div_taxon <- rao.diversity(comm)
div_func <- rao.diversity(comm, traits = traits)

plot(div_func$Simpson,div_func$FunRao, pch = 19, asp = 1)
abline(a = 0, b = 1)


# Func DIveristy with FD

div_FD <- dbFD(x = div_gower, a = comm, messages = F)
names(div_FD)

# We can also do the calculation using the traits matrix directly
div_FD_mtrx <- dbFD(x = traits, a = comm, messages = F)









# getting the family of each species



library(taxize)
classification_data <- classification(splist$TaxonName, db = 'ncbi')
lenght(classification_data)

classification_data$'Arisarum vulgare'
head(classification_data)


library(dplyr)
tible_ex <- classification_data[1] %>%
  filter(rank == 'family') %>%
  select(name) # returns a data.frame. use pull to vector

extract_family <-function(x){
  if (!is.null(dim(x)))  {
  y <- x %>%
    filter(rank == 'family') %>%
    pull(name)
  return(y)
  }
}

extract_family(classification_data[[1]])
extract_family(classification_data[[4]])


families <- vector()

for (i in 1:length(classification_data)) {
  f <- extract_family(classification_data[[i]])
  if (length(f) > 0) families[i] <- f
}
families

