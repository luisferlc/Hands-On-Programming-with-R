###############################################
###########  chapter 9  #######################
###############################################
##### Loops: el arte de repetir un evento en la programación

#En este capítulo se va comprobar la tasa de retorno de las máquinas-traga-monedas, de esta empresa que fue acusada de fraude.
#Se acuso de que las máquinas solo regresaban el 40 centavos de 1 dolar, y la empresa dijo que nel, que se regresaban 92 centavos como ellos lo dijeron desde el principio

###########################################
###########################################
#reciclando
score <- function(s) {  
  
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
###########################################
###########################################

###### Valores esperados
#El valor esperado de un evento random (como lo es este juego de traga-monedas) se obtiene con un promedio ponderado
#El promedio ponderado es la sumatoria de todos los resultados esperados por su probablidad de ocurrencia o manifestación poeh...

#En el libro se muestra el ejemplo de un dado, el cual, si no esta balanceado hacia un número, cada número del dado tendra la misma posibilidad de salir.
    #En este caso (cuando la probabilidad de todos los eventos es igual), el promedio ponderado es igual a un promedio normal

###### Obteniendo el valor esperado de tirar 2 dados que estan sesgados:
die <- c(1,2,3,4,5,6)
die 

rolls <- expand.grid(die,die)
rolls
#Creas una columna nueva donde sumas el resultado del dado1 + dado2
rolls$suma <- rolls$Var1 + rolls$Var2
rolls
#Ahora, tienes que obtener la probabilidad de que cada combinación ocurra: 
    #La probabilidad de que n-eventos independientes ocurran es igual al producto de cada evento independiente que ocurre

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)(
prob
prob[rolls$Var1] #esto esta muy pro
#Creas dos columnas con la probabilidad de eventos independientes
rolls$prob1 <- prob[rolls$Var1]
rolls$prob2 <- prob[rolls$Var2]
#Y luego obtienes el producto de estas dos columnas anteriores, que es la probabilidad de la combinación de eventos-n:
rolls$prob <- rolls$prob1 * rolls$prob2
rolls
#Ahora puedes obtener el valor esperado:
sum(rolls$suma * rolls$prob) #Notita: el valor esperado de tirar 2 dados justos, poeh es 7: mean(rolls$suma)


####### Ahora vamos a calcular el valor esperado de la traga-monedas:
#1.- crear el dataframe de combinaciones posibles

wheel <- c("DD","7","BBB","BB","B","C","0")
combos <- expand.grid(wheel,wheel,wheel, stringsAsFactors = F)
#2.- Armando DF con probabilidades
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06, "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)

#eventos independientes
combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
combos
#producto 
combos$prob <- combos$prob1 *  combos$prob2 *  combos$prob3
combos
sum(combos$prob) #da 1, por lo tanto es correcto
#ahora tienes que crear una columna con los premios de cada combinación
symbols <- c(combos[1,1],combos[1,2],combos[1,3])
score(symbols)
#Creando un loop pa esto...
'''
chars <- vector()
chars
length(chars)

for (i in 1:5) {
  chars[i] <- i
}
'''
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i,1],combos[i,2],combos[i,3])
  combos$prize[i]<-score(symbols)
}
#valor esperado:
sum(combos$prize * combos$prob)
