# data <- read.csv("data/raw/cestes/comm.csv")
#
# # library(dplyr)
# #
# #
# # sum_spp = colSums(data[,2:57])
# # sort_spp_abd = sort(sum_spp, decreasing = T)
# #
# # colSums(comm) %>% dplyr::sort(decreasing=T)
#
#
# index_spp = 1:56 # indice de especies do exercicio, no caso sao 56
# result = c() # vetor vazio pra entrar no loop
#
# for (i in 2:57){ # soma a coluna de cada spp
#   s = sum(data[,i])
#   result = append(result, s)
# }
#
#
#
# sp_sum = data.frame(index_spp, result) # cria um df com o valor da soma e o numero da spp
#
# # agora como ordenar em funcao de result?
# sp_sum_ordered = order(sp_sum$result,decreasing = T)
#
# sort.list(sp_sum$result, decreasing = T)
#
#
#

sort(colSums(data[,2:57]), decreasing = T)
order(colSums(data[,2:57]), decreasing = T)
rowSums(data)



