#############################################################
##################### Cahpter 1 #############################
#############################################################

vector <- 1:6
vector
vector * 2 * 2

#R usa element-wise execution y no las reglas de multiplicaci�n de matrices:
#Es decir, si multiplicas tu vector por si mismo, va tomar el primer elemento de los 2 vectores y los va multiplicar:

vector * vector

#�Qu� pasa con operaciones con vectores de distintos tama�os?
#Va tomar el tama�o del vector mayor y al chico, lo va rellenar con sus valores mismos
v1 <- c(2,1,1)
v2 <- 1:5

v1 * v2

#### Rolling the dice
sample(vector, 1)

#OJO: la funci�n sample hace el sampleo SIN REEMPLAZO, es decir, nunca podr�a salirte algun par si tiras dos veces el dado.
sample(vector, 2)
sample(vector, 2, replace = T)

roll <- function(){
  dado <- 1:6
  throw <- sample(vector, 2, replace = T)
  print("N�meros que salieron:")
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
- arg(funcion) te devuelve los argumentos que x funci�n toma
'''