#########################################
########     Chapter 5       ############
#########################################
#Modificando valores de un dataset

#importando desde código
#getwd()
#setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')

deck <- read.table('deck.csv', sep = ",", header = T)
str(deck)

#deal_s <- function(d) {
#  random <- sample(1:52, size = 52) #realmente lo que haces aca es crear un vector con números random del 1 al 52, que después te van a servir para usarlos como index en el subset
#  d <- d[random,]
#  d[1,]
#}

vec <- c(0,0,0,0,0,0,0,0,0,0,0)
vec[1] <- 44
vec
vec[2:3] <- c(33,33)
vec
vec[c(4,5)] <- c(55,55)
vec
length(vec)
vec[12] <- 99
vec

deck$new <- 1:length(deck$face)
deck
deck$new <- NULL
deck

#asignado un nuevo valor a los as's
deck[c(13,26,39,52),3]
deck$value[c(13,26,39,52)]

deck[c(13,26,39,52),3] <- 14
deck

#Pero que pasa si la baraja se revuelve? sería tedioso encontrar los índices de los as's (ahora imaginate en un dateset grande)
shuffle <- function(d) {
  random <- sample(1:52, size = 52) #realmente lo que haces aca es crear un vector con números random del 1 al 52, que después te van a servir para usarlos como index en el subset
  d <- d[random,]
}
deck_s <- shuffle(deck)
deck_s[c(13,26,39,52),3] #ahora no son todos as's verdad?
#Aca es donde puedes usar 'subseteado logico', test logicos para subsetear poeh
deck_s$value[deck_s$value == 14]
deck_s$value[deck_s$face == 'ace'] #traeme todos los valores de la columan value donde haya as's


########### EL JUEGO DE CORAZONES ################
#asignas valor 0 a todas las cartas menos a los corazones, que estos valdrán 1
deck_cocoro <- deck
deck_cocoro$value[deck_cocoro$suit != 'hearts'] <- 0
deck_cocoro$value[deck_cocoro$suit == 'hearts'] <- 1
deck_cocoro

### Localizando a la reina de espadas
deck_s[(deck_s$suit == 'spades') & (deck_s$face == 'queen'),]

###### OTRO PEQUEÑO EJERCICIO ########
w <- c(-1,0,1)
x <- c(5,15)
y <- c('Febrero')
z<- c('Lunes','Martes','Viernes')

#1.-¿Es w positivo?
is.positive(w) #que chingados por qué no funciona?
w > 0

#2.-¿Es x mayor a 10 y menor a 20?
x > 10 & x < 20

#3.-¿Esta escrito 'Febrero' en y?
y=='Febrero'

#4.-¿Son todos los valores de z un día de la semana?
all(z %in% c('Lunes','Martes','Miercoles','Jueves','Viernes'))


