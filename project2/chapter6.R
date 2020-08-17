#########################################
########     Chapter 6       ############
#########################################
#       Creando el blackjack

getwd()
setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')
deck <- read.table('deck.csv', sep = ",", header = T)

##### Hay 3 ambientes en tu arbol de ambientes que tienen su propia función para acceder a ellas:
globalenv() #este es el ambiente de hasta abajo, y es donde se guardan tus variables
baseenv()
emptyenv()

ls(globalenv()) #donde se guardan tus variables
ls(baseenv()) #donde estan las funciones default de R
ls(emptyenv()) #Naada...

#### Se puede usar la función "assign" para guardar una variable en algun ambiente en específico.
#Esto podría ser útil ya que puedes acceder a las variables de cualquier ambiente
globalenv()$deck
#assign("nombre de tu variable nueva", x, envir ="ambiente destino")

### El ambiente "activo": aquel donde van a ocurrir las operaciones que hagas
environment() #por lo general es el globalenv
#Ahora, qué pasa si llamas a una variable y resulta que no esta en tu directorio global? pues hay reglas para ir a buscar esta variable a los demás ambientes
#R va ir parent tras parent hasta encontarlo...


### Ya ves que cuando creas una variable puedes sobreesribirla después? ¿qué pasa con las variables que defines dentro de una función, que tienen la misma definición que una variable global?
# Para evitar sobreescribir estas variables globales con tus variables dentro de una función, al momento de ejecutar una función, R crea un ambiente temporal donde ahí se ejecuta la función, y solo
# regresa los resultados en el ambiente global
show_env <- function() {
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment())
       )
}
show_env()

### Ahora, regresando con el juego... vamos a eliminar la carta que se toma de hasta arriba
head(deck)
deal <- function() {
  deck[1,]
}
deal()

DECK <- deck

deal_s <- function() {
  random <- sample(1:length(deck$face), size = length(deck$face))
  assign("deck", deck[random,], envir = globalenv())
  card <- deck[1,]
  assign("deck", deck[-1,], envir = globalenv())
  card
}
length(deck$face)
deal_s()

#sample(1:length(deck$face), size = length(deck$face)) 

deal_s_2 <- function() {
  random <- sample(1:length(deck$face), size = length(deck$face))
  deck <- deck[random,]
  card <- deck[1,]
  deck <- deck[-1,]
  card
}
deal_s_2() # en efecto se tiene que usar el assign si no no encuentra el ambiente origen donde esta definido "deck"

############ Ahora creando el blackjacj de la manera qUe la hizo este man del libro...
#Por qué lo hace de esta manera? para que deck pu

setup <- function(deck) {
  DECK <- deck #crea una copia de deck dentro de la función, pa que exista en el ambiente temporal de corrida
  
  DEAL <- function() {
    card <- deck[1,]
    assign("deck", deck[-1,], envir = parent.env(environment()))
    card
  }
  
  SHUFFLE <- function() {
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random,], envir = parent.env(environment()))
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}
setup
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

environment(deal)
environment(shuffle)

rm(deck)

shuffle()
deal()
deal()

#Aca hay un detalle y es que cada vez que corras "shuffle" se va a tomar un deck nuevo, aun cuando ya hayas sacado unas cartas.
#Shuffle lo que hara es simular que el dealer toma una baraja nueva...
#Por esto, en el suffle pondría el random = 1:length(deck) para que tome el deck actual.
