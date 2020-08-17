#####################################
##### Slot Machine - Chapter 7 ######
#####################################

get_symbols <- function() {
  wheel <- c("DD","7","BBB","BB","B","C","0")
  sample(wheel, size=3, replace = T,
         prob = c(0.03,0.03,0.06,0.1,0.25,0.01,0.52))
}
get_symbols()

######################   Armando play  ###############################

#1.- Checar si todos los elementos del vector son iguales:
x <- c("7","7","7")
all(x == x[1])
?all
#2.- checar precio del vector anterior donde todos los simbolos son iguales
pays <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0) #esta es la manera de crear un diccionario asi como en Python
xx<-unname(pays[x[1]])
xx
################################
################################
#3.- checar si todos son barras
x <- c("B","B","BBB")
all(x %in% c("B","BB","BBB"))
#4.- asignar el premio de 5 dolares
pays <- 5
################################
################################
#5.- contar el número de cherries
x <- c("B","C","C")
cherries=sum(x == "C")
#6.-calcular el precio de los cherries
pays <- c(0,2,5)[cherries + 1] #+1 para moverse al índice correcto del vector.
################################
################################
#7.- contar diamantes
x <- c("DD","BB","C")
diamantes=sum(x == "DD")
diamantes
#8.- dobletear premio si es necesario
pays * 2 ^ diamantes

######## Uniendo el código
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


########### CREANDO PLAY ####################
play <- function() {
  
  simbolos <- get_symbols() #1.-generas tu jugada, 3 simbolos aparecen en pantalla
  print(simbolos) #2.-imprimes los simbolos que sacaste
  premios(simbolos)
}

play()
