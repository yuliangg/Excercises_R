# Ejercicios. Los dos primeros los veremos en clase
# Los demás quedan a discrección de cada alumno y los podemos
# corregir en el basecamp o por correo:
# avidalmata
# gmail.com
#
# Preferiblemente por basecamp para que todos nos podamos
# beneficiar de las respuestas.


# 1. Cogiendo datos reales del stock de amazon y google (codigo abajo)
# haz una version CON BUCLES de un algoritmo que haga el siguiente proceso:
# Si de un dia para otro (dia A y dia A+1) sube la bolsa en
# Amazon y google. Compra aquel stock que haya subido más
# P.e: del día 1/1/208 ambos suben, Amazon sube +3 y Google +2
# Compramos Amazon.
# Si empatan en subida, compra el que quieras (solo uno)
# Nota: Usa la columna "Open

#install.packages('quantmod')
library(quantmod)

#amzn <- getSymbols('AMZN', from = "2014-01-01", auto.assign = F)
#googl <- getSymbols('GOOGL', from = "2014-01-01", auto.assign = F)
# #bolsa <- cbind(amzn,googl)

puntosDeCompra <- function(precioA, precioB){
  resultado <- numeric(length(precioA))
  for (i in 1:(length(precioA)-1)){
    deltaA <- precioA[(i+1)]- precioA[(i)]
    deltaB <- precioB[(i+1)]- precioB[(i)]
    
    if (deltaA > 0 && deltaB > 0){
      #resultado[i+1] <- TRUE
      resultado[i+1] <- ifelse(deltaA > deltaB, 1, 2)
    }
  }
  resultado
}

#forma vectorizada, para resolverlo:
puntosDeCompra <- function(precioA, precioB){
  resultado <- integer(length(precioA))
  deltaA <- diff(as.numeric(precioA))
  deltaB <- diff(as.numeric(precioB))
  
  #mascaras
  subidaDoble <- deltaA  > 0 & deltaB > 0
  compraA <- 
  
}


backtesting <- function(precioA, precioB, puntosCompra){
  #puntosDeCompra(amzn$AMZN.Open, googl$GOOGL.Open)
  #resul <- puntosDeCompra(precioA, precioB)
  
}


# 2. Implementa el algoritmo con operaciones de vectores

# 3. Del dataset airquality filtra los días impares del mes
# Intenta usar una funcion que implementes tu que devuelva
# TRUE si el dia es impar
library(datasets)
airquality


# 4. Del dataset airquality calcula la media de todas las variables
# por cada mes. Intenta usar el modificador _at o _if o _all (o todos)
# quita los NA para que la media salga bien


# 5. Del dataset de vuelos coge aquellas rutas (par origin-dest)
# que tengan mayor retraso en promedio. Coge el top 5
library(nycflights13)
flights


# 6. Del dataset de vuelos comprueba en que hora (variable hour)
# existen más retrasos totales en promedio (ordena el dataset
# de mayor a menor)

