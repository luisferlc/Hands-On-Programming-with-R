#################################################################
#####################    Chapter 2     ##########################
#################################################################

# Ya tenemos nuestra funci�n de tirar dos dados creada, ahora, como el Casino que somos, vamos a ponerle m�s peso a este dadito...

install.packages('ggplot2')
library('ggplot2')

#La funci�n de roll()
roll <- function() {
  dice <- 1:6
  throw <- sample(dice, 2, replace = T)
  sum(throw)
}

roll()

# �C�mo puedes comprobar que al tirar dos dados, hay ciertos n�meros que tienen m�s probabilidad de sumarse?
#La funci�n replicate sirve para repetir un comando n veces.
replicate(10,roll())
rolls <- replicate(1000, roll())
qplot(rolls, binwidth = 1)
#Gracias a este plot podemos ver que nuestra funci�n sigue la distribuci�n esperada en tirar dos dados. Pero nosotros como casino,
#queremos ponerle m�s peso a la distribuci�n ya sea por la izquierda o derecha...

#La funci�n sample tiene un par�metro que te ayuda a ponerle m�s probabilidad de sampleo a cierto(s) valor:

args(sample)
?sample

roll_w <- function() {
  dice <- 1:6
  prob_w <- c(1/8,1/8,1/8,1/8,1/8,3/8)
  throw <- sample(dice, 2, replace = T, prob = prob_w)
  sum(throw)
}

rolls <- replicate(1000, roll_w())
qplot(rolls, binwidth = 1)

#Ahora ves como la distribuci�n se inclino hacia la derecha, que es donde la suma de los valores es mayor
