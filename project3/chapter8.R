###############################################
###########  chapter 8  #######################
###############################################
######    S3: un sistema de clases que ayudan al manejo de objetos

getwd()
setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')
deck <- read.table('deck.csv', sep = ",", header = T)

###################################################################
###################################################################
#recicliando del cap�tulo anterior:

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

### Hay 3 componentes principales de S3: atributos, funciones gen�ricas, y m�todos

#1.- Atributos: las variables pueden tener atributos, que son informaci�n extra que puede ser de ayuda, como sus "metadatos".
attributes(deck)

#Tu puedes crear atributos para los objetos con la funci�n 'attr':
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

#Ahora usando la funci�n structure():
?structure
play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  premio <- premios(simbolos)
  structure(premios(simbolos), symbols = simbolos)
  
}
third_play<-play()
third_play
attributes(third_play)

#Ahora pueds utilizar este atributo para exponer los resultados de manera m�s est�tica o parecida a una verdadera slot-machine

slot_display <- function(a_play) {
  
  symbols <- attr(a_play, 'symbols') #extraes los distintos valores del atributo 'symbols'
  symbols <- paste(symbols, collapse = " ") #crear 1 string con estos valores separados por un espacio
  string <- paste(symbols, a_play, sep = "\n$") #por �ltimo unes el string symbols con el valor de tu par�metro (a_play) que es el valor de play(), el dinero que ganaste
  cat(string)
  
}

slot_display(play())

############### Funciones gen�ricas y m�todos ###########################

# print() es una funci�n gen�rica que tiene varios m�todos internos para analizar los objetos con sus clases que le son dados, e imprimirlos de manera correcta

num <- 1000
print(num)
class(num) <- c("POSIXct", "POSIXt")
print(num)

#Cuando tu llamas a print, print usa una funci�n especial llamada UseMethod que pasa todos los argumentos que le pasaste a una funci�n dise�ada para 
#analizar e imprimir la informaci�n en formato correcto
methods(print)
#Todo este sistema de funciones gen�ricas y m�todos es el S3, la tercera versi�n de el lenguaje S que se convirtio en S-PLUS y R.

#Gracias a este sistema puedes imprimir 'deck' como un data.frame, ya que esta es su clase. Seguro si le cambias su clase, va imprimir esta info de otra manera.

### UseMethod es el sistema que permite buscar entre las clases de un objeto y elegir la m�s adecuada para ejectuar la funci�n gen�rica.
x<-1000
class(x) <- 'numas'
args(print)

print.numas <- function(x, ...){
  cat("Estoy usando el m�todo print.numas")
}
x

#Algunos objetos tienen m�ltiples clases. �C�mo se selecciona la clase m�s adecuada?
#UseMethod buscar� el m�todo que coincida con la primera clase del objeto, si no, toma la 2da clase y busca m�todo de nuevo.
#Si no hay ningun m�todo que coincida con las clases, UseMethod usa el m�todo default print.default (para el caso de print())

#Ahora, vamos a definir un m�todo para imprimir los resultados de la m�quina de manera autom�tica, en lugar de pasarle la funci�n slot_display a los plays

#Pero primero, hay que hacer que play() defina la clase que luego tomara nuestro m�todo, para imprimir bonito los resultados de la maquina
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

