###############################################
###########  chapter 8  #######################
###############################################
######    S3: un sistema de clases que ayudan al manejo de objetos

getwd()
setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')
deck <- read.table('deck.csv', sep = ",", header = T)

###################################################################
###################################################################
#recicliando del capítulo anterior:

get_symbols <- function() {
  wheel <- c("DD","7","BBB","BB","B","C","0")
  sample(wheel, size=3, replace = T,
         prob = c(0.03,0.03,0.06,0.1,0.25,0.01,0.52))
}

premios <- function(s) {  
  
  if (all(s == s[1])){
    pays <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0) #diccionario de premios
    premio <- unname(pays[s[1]])
  }
  else if (all(s %in% c("B","BB","BBB"))){
    premio <- 5
  }
  else {
    cherries<-sum(s == "C")
    premio <- c(0,2,5)[cherries + 1]
  }
  
  diamantes<-sum(s == "DD")
  premio * 2 ^ diamantes
}

play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  print(simbolos) #2.-imprimes los simbolos que sacaste
  premios(simbolos)
}

play()
###################################################################
###################################################################

### Hay 3 componentes principales de S3: atributos, funciones genéricas, y métodos

#1.- Atributos: las variables pueden tener atributos, que son información extra que puede ser de ayuda, como sus "metadatos".
attributes(deck)

#Tu puedes crear atributos para los objetos con la función 'attr':
one_play <- play()
one_play
attributes(one_play)
attr(one_play, 'symbols') <- c("B","0","B")
attributes(one_play) #ahora la variable one_play ya tiene un atributo llamado 'symbols'
attr(one_play, 'symbols') #aca entras directamente al valor de un atributo 'x'

## Ahora, en lugar de usar un print para mostrar los simbolos de la maquina, puedes usar el atributo anterior para mostrar estos simbolos
play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  premio <- premios(simbolos)
  attr(premio, 'simbolos') <- simbolos
  premio
}
two_play<-play()
two_play

#Ahora usando la función structure():
?structure
play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  premio <- premios(simbolos)
  structure(premios(simbolos), symbols = simbolos)
  
}
third_play<-play()
third_play
attributes(third_play)

#Ahora pueds utilizar este atributo para exponer los resultados de manera más estética o parecida a una verdadera slot-machine

slot_display <- function(a_play) {
  
  symbols <- attr(a_play, 'symbols') #extraes los distintos valores del atributo 'symbols'
  symbols <- paste(symbols, collapse = " ") #crear 1 string con estos valores separados por un espacio
  string <- paste(symbols, a_play, sep = "\n$") #por último unes el string symbols con el valor de tu parámetro (a_play) que es el valor de play(), el dinero que ganaste
  cat(string)
  
}

slot_display(play())

############### Funciones genéricas y métodos ###########################

# print() es una función genérica que tiene varios métodos internos para analizar los objetos con sus clases que le son dados, e imprimirlos de manera correcta

num <- 1000
print(num)
class(num) <- c("POSIXct", "POSIXt")
print(num)

#Cuando tu llamas a print, print usa una función especial llamada UseMethod que pasa todos los argumentos que le pasaste a una función diseñada para 
#analizar e imprimir la información en formato correcto
methods(print)
#Todo este sistema de funciones genéricas y métodos es el S3, la tercera versión de el lenguaje S que se convirtio en S-PLUS y R.

#Gracias a este sistema puedes imprimir 'deck' como un data.frame, ya que esta es su clase. Seguro si le cambias su clase, va imprimir esta info de otra manera.

### UseMethod es el sistema que permite buscar entre las clases de un objeto y elegir la más adecuada para ejectuar la función genérica.
x<-1000
class(x) <- 'numas'
args(print)

print.numas <- function(x, ...){
  cat("Estoy usando el método print.numas")
}
x

#Algunos objetos tienen múltiples clases. ¿Cómo se selecciona la clase más adecuada?
#UseMethod buscará el método que coincida con la primera clase del objeto, si no, toma la 2da clase y busca método de nuevo.
#Si no hay ningun método que coincida con las clases, UseMethod usa el método default print.default (para el caso de print())

#Ahora, vamos a definir un método para imprimir los resultados de la máquina de manera automática, en lugar de pasarle la función slot_display a los plays

#Pero primero, hay que hacer que play() defina la clase que luego tomara nuestro método, para imprimir bonito los resultados de la maquina
play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  premio <- premios(simbolos)
  structure(premios(simbolos), symbols = simbolos, class = 'slots')
  
}

print.slots <- function(x, ...) {
  slot_display(x)
}

play()

####################### Classes ###############################
methods(class = 'factor')

