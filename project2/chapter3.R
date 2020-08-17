##############################################################
######################## Chapter 3 ###########################
##############################################################

####  Creando un deck de cartas, osease, una baraja

#En R, los vectores o vectores atómicos son el principal objeto para el manejor de datos

x <- 5
y <- c(1,2,3,45555)

is.vector(x)
is.vector(y)
length(x)
length(y)

#Por default, R guarda como doubles los números en los vectoers
typeof(x)

#Guardando integers
x_2 <- c(1L,2L,42L)
typeof(x_2)

#Probando cosillas
x_3 <- c(1L,2,42L)
typeof(x_3)

#floating-point arithmetic
sqrt(2)^2 - 2 #Esto debería ser 0 no? pues no debido a que hay ciertos decimales que no pueden ser guardados completamente en 64bits, entonces
#la mquina redondea. Sin embargo, es muy difícil que esto represente un error significativo en tus analisis...

#arreglos, matrices y atributo dim
array(c(1,2,3,4,5,6), dim = c(2,3))
matrix(c(1,2,3,4,5,6), nrow=2)
matrix(c(1,2,3,4,5,6), nrow=2, byrow=T)

vector <- c(1,2,3,4,5,6)
dim(vector)
dim(vector) <- c(2,3)
vector

#Creando una matriz para una flor imperial
flor_imperial <- c('as','rey','reina','jota','diez','espadas','espadas','espadas','espadas','espadas')
dim(flor_imperial)
dim(flor_imperial) <- c(5,2)
flor_imperial

#El atributo 'class'
typeof(flor_imperial)
class(flor_imperial) #cuando cambias las dimensiones de un vector se autoescribe automaticamente su atributo de 'clase'

#Date and Times
Sys.time()

#Factors

days <- factor(c('lunes','martes','miercoles','miercoles'))
days
class(days)
typeof(days) #Sabes por qué te marca el vector como tipo integer?
#porque cada factor lo codea (guarda en memoría) como un número, así como un one hot encoding algo asi... vamos a ver
unclass(days) #aca se puede ver que para el lunes asigno un 1, martes un 2, y asi...

#Importando el csv de la baraja desde la UI: arribita de tu enviroment esta la opción de 'Import Dataset'
deck
View(deck)

#importando desde código
getwd()
setwd('D:/Documentos/R Projects/Hands-On Programming with R/project2')
deck2 <- read.table('deck.csv', sep = ",", header = T)
deck2
str(deck)
str(deck2)
deck3 <- read.csv('deck.csv')
str(deck3)
