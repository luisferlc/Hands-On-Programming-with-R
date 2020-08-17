###########################################################
################### Chapter 4 #############################
###########################################################

#importando desde código
getwd()
setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')
deck <- read.table('deck.csv', sep = ",", header = T)
str(deck)

#subseteando con integrales positivos
head(deck)
deck[1,] # el index empieza en 1, a diferencia de Python que empieza en 0, También, aca el espacio en blanco es igual al ':' en Python, para incluir todos los valores
class(deck[1:3,1]) #vector
class(deck[1:3,1, drop = F]) #se queda como data.frame con el drop

#subseteando con integrales negativos. La logica aca es 'traeme todo menos... lo que indiques de manera negativa'
deck[-(1:20),] #te trae todos los registros a partir del 21. Es decir omite los rows del 1 al 20 poeh

#subseteando con logical values
deck[1:5, c(T, F, T)] #esta es buena pa cuando quieres seleccionar solo unas variables
#también lo podrías hacer con los nombres de las variables como es en pandas
deck[1:5, c('face','value')]

##### TRAEME LA PRIMERA CARTA DEL DECK, PERROOO #########
deal <- function(d) {
  d[1,]
}
deal(deck)

#ahora revolviendo las cartas antes de hacer el deal
sample(1:52, size = 12) #traeme 12 muestras sin reemplazo, que esta por default
?sample
#sample(1:52, size = 50, replace = T)

deal_s <- function(d) {
  random <- sample(1:52, size = 52) #realmente lo que haces aca es crear un vector con números random del 1 al 52, que después te van a servir para usarlos como index en el subset
  d <- d[random,]
  d[1,]
}

deal_s(deck)

#el signo de dolar, que sirve para acceder a un elemento de una lista o dataframe:
str(deck)
deck$face
mean(deck$value)

lst <- list(numbers = c(1,2), logical = T, strings = c('a','b','c'))
lst
lst[1]
sum(lst[1]) #error
sum(lst$numbers) #o tambien puedes hacer esto:
sum(lst[[1]])
#lst[[1]]


