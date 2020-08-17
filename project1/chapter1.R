#############################################################
##################### Cahpter 1 #############################
#############################################################

vector <- 1:6
vector
vector * 2 * 2

#R usa element-wise execution y no las reglas de multiplicación de matrices:
#Es decir, si multiplicas tu vector por si mismo, va tomar el primer elemento de los 2 vectores y los va multiplicar:

vector * vector

#¿Qué pasa con operaciones con vectores de distintos tamaños?
#Va tomar el tamaño del vector mayor y al chico, lo va rellenar con sus valores mismos
v1 <- c(2,1,1)
v2 <- 1:5

v1 * v2

#### Rolling the dice
sample(vector, 1)

#OJO: la función sample hace el sampleo SIN REEMPLAZO, es decir, nunca podría salirte algun par si tiras dos veces el dado.
sample(vector, 2)
sample(vector, 2, replace = T)

roll <- function(){
  dado <- 1:6
  throw <- sample(vector, 2, replace = T)
  print("Números que salieron:")
  print(throw)
  #print(paste0('Numeros que salieron: ', throw))
  #message(paste('Numeros que salieron: ', throw)) #mensaje de consola
  sum(throw)
}

roll()

### Code > Extract ??
jhgfd <- function() {
  vector <- 1:6
  sample(vector, 2, replace = T)
}


'''
Notas:
- ls() #ver las variables que has creado
- arg(funcion) te devuelve los argumentos que x función toma
'''