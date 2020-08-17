#################################################################
#####################    Chapter 2     ##########################
#################################################################

# Ya tenemos nuestra función de tirar dos dados creada, ahora, como el Casino que somos, vamos a ponerle más peso a este dadito...

install.packages('ggplot2')
library('ggplot2')

#La función de roll()
roll <- function() {
  dice <- 1:6
  throw <- sample(dice, 2, replace = T)
  sum(throw)
}

roll()

# ¿Cómo puedes comprobar que al tirar dos dados, hay ciertos números que tienen más probabilidad de sumarse?
#La función replicate sirve para repetir un comando n veces.
replicate(10,roll())
rolls <- replicate(1000, roll())
qplot(rolls, binwidth = 1)
#Gracias a este plot podemos ver que nuestra función sigue la distribución esperada en tirar dos dados. Pero nosotros como casino,
#queremos ponerle más peso a la distribución ya sea por la izquierda o derecha...

#La función sample tiene un parámetro que te ayuda a ponerle más probabilidad de sampleo a cierto(s) valor:

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

#Ahora ves como la distribución se inclino hacia la derecha, que es donde la suma de los valores es mayor
