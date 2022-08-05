require(vegan)
require(gclus)
require(betapart)

source('R/15_coldiss.r')

data("dune") #dados com contagem de plantas em 50 plots
dataset <- dune

#Numero esperado de esp?cies para amostra de tamanho de N ind?viduos
#Note que N deve ser menor do que o menor N observado para todas a comunidades
N=15
rarefy(dataset, N)
#subamostra aleat?ria das comunidades com tamanho N de indiv?duos
rrarefy(dataset,N)
#plotando curvas de rarefa??o
rarecurve(dataset)


# Diversidade em Escalas

#Considerando somente riqueza

data_bin <- dataset
data_bin <- dataset[c(1,20),]
data_bin <- dataset[c(6,7),]

data_bin[data_bin>0] <- 1 #desconsiderando abundancias
data_bin


gamma<-sum(colSums(data_bin)>0)

alpha_m<-mean(apply(data_bin,1,sum))

beta<-gamma/alpha_m

c(gamma=gamma,alpha=alpha_m,beta=beta)

#Considerando abund?ncias
Htotal<-diversity(apply(dataset,2,sum), index="shannon") #aplicando H ? soma das abund?ncias para todas as localidades

gamma<-exp(Htotal) #numero efetivo de especies na regiao

H<-diversity(dataset,index="shannon")

alpha_m<-mean(exp(H)) #Diversidade real em numero efetivo de especies

beta<-gamma/alpha_m

c(gamma=gamma,alpha=alpha_m,beta=beta)



##### Parti??o div Beta #####

#dados bin?rios
data.bin <- as.matrix(dataset)
data.bin[which(data.bin>0)] <- 1
beta.multi(data.bin)

#dados quantitativos
beta.multi.abund(dataset)


#simulando dados
A <- c(1,1,1,0,0,0) #comunidade A com 3 spp
B <- c(0,0,0,1,1,1) #comunidade B com 3 spp
data.1 <- rbind(A,B) #matriz com 2 comunidades e 6 spp
beta.multi(data.1)


A <- c(1,1,1,1,1,1) #comunidade A com 3 spp
B <- c(1,1,1,0,0,0) #comunidade B com 3 spp
data.2 <- rbind(A,B) #matriz com 2 comunidades e 6 spp
beta.multi(data.2)


A <- c(1,1,1,1,1,0) #comunidade A com 3 spp
B <- c(1,1,1,0,0,1) #comunidade B com 3 spp
data.3 <- rbind(A,B) #matriz com 2 comunidades e 6 spp
beta.multi(data.3)




#### Similiaridade e Dissimilaridade ####

J = vegdist(dataset, binary = TRUE, "jaccard")
round(J,2)

dataset[1:2,] #Note que 50% das esp?cies sao compartilhadas entre os sitios 1 e 2

dataset[c(1,14),] #Ja os sitios 1 e 14 nao compartilham nenhuma esp?cie (J = 1)


#indice de Bray-Curtis para o calculo da similaridade
B = vegdist(dataset, "bray")
round(B,2)

#indice de Morisita-Horn para o calculo da similaridade
#transformando em proporcoes
data.norm<-dataset/apply(dataset,1,sum)
M = vegdist(data.norm, "horn")
round(M,2)

coldiss(J, nc = 6)

coldiss(B, nc = 6)

### Agrupamento ###

#Transformacao dos dados brutos
data.norm <- decostand(dataset, "normalize")
#Calculando distancias
euc <- vegdist(data.norm, "euc")

#Gerando agrupamento pelo metodo de UPGMA
#objetos s?o agrupados da menor para maior dist?ncia
clust.ave <- hclust(euc,method="average")
plot(clust.ave)

cor(cophenetic(clust.ave),euc)


#Gerando agrupamento pelo metodo de Ward
#grupos s?o gerados com base na soma das distancias dentro dos grupos
clust.ward <- hclust(euc,method="ward.D")
plot(clust.ward)

cor(cophenetic(clust.ward),euc)


#Visualizando dendrogama e matriz de similaridade
heatmap(as.matrix(euc), symm=TRUE)



#### ORDENA??O ####


#Transformacao dos dados - necess?ria para evitar rela??es n?o lineares
data.norm<-decostand(dataset, "hellinger")
#Gerando PCA
pca<-rda(data.norm)
#Resultados do PCA
summary(pca)

#Biplot
par(mfrow=c(1,2), mar = c(5,5,7,1))
biplot(pca, scaling=1)
biplot(pca, scaling=2)

as.data.frame(pca$CA$u[,1:2])
as.data.frame(pca$CA$v[,1:2])


#Calculando dissimilaridade
data.norm<-dataset/apply(dataset,1,sum)
M = vegdist(data.norm, "horn")
#Computando eixos
data_pcoa<-cmdscale(M,eig = TRUE)
#plotando sites
ordiplot(scores(data_pcoa)[,c(1,2)],type="t", cex=1.2)





#plotando especies
sp.was<-wascores(data_pcoa$points[,1:2],dataset)
text(sp.was,rownames(sp.was),cex=0.7,col="red")
abline(h=0,lty=3)
abline(v=0,lty=3)



#gerando eixos
mds<-metaMDS(data.norm,k=2,distance = "horn")


mds

par(mfrow=c(1,2), mar = c(5,5,7,1))
plot(mds,type="t", cex=1, main="NMDS")
text(3,mds$stress)
stressplot(mds, main="Sheppard plot")


# ex 03D

#10 comunidades com 6 esp?cies
dataset <- rbind(
  c(100,5,2,0,0,0),
  c(20,4,1,0,5,0),
  c(100,6,1,1,0,10),
  c(1,20,1,0,1,30),
  c(0,1,0,0,5,10),
  c(0,1,0,0,2,50),
  c(0,0,0,1,1,10),
  c(0,2,10,2,0,1),
  c(10,0,10,10,2,1),
  c(0,0,0,100,10,20))
row.names(dataset)=1:10
dataset



data.norm<-decostand(dataset, "hellinger")
#Gerando PCA
pca<-rda(data.norm)
#Resultados do PCA
summary(pca)

#Biplot
par(mfrow=c(1,2), mar = c(5,5,7,1))
biplot(pca, scaling=1)
biplot(pca, scaling=2)




# ex 04



#?ndice pluviom?trico para as 10 comunidades amostradas
pluv.data <- c(1000,900,850,500,250,200,200,800,600,400)

#extraindo os valores dos s?tios no PC1
pc1 <- summary(pca)$sites[,1]

#regress?o linear entre PC1 e vari?vel ambiental
summary(lm(pc1~pluv.data))



plot(pc1~pluv.data, xlab = "Pluviometria (mm)",cex.lab=1.4, pch=20, cex=1.3)
abline(lm(pc1~pluv.data), lty=2)
