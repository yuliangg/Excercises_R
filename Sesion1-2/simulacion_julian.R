#n tamaño demi tablero

generarTablero <- function(n=4, probA, probB){
  
  
  sujetos <- c(rep(1,n**2*probA),rep(2,n**2*probB))
  sujetos <- c(sujetos,rep(0,n**2-length(sujetos)))
  sujetos <- sample(sujetos)
  
  tablero <- matrix(sujetos,ncol=n, nrow=n)
  tablero
  
  logicTablero <- matrix(tablero)
  
  for (i in length(tablero[1,])){
    for (j in length(tablero)){
      if (tablero[i,j]==1){
        logicTablero[i,j] <- T
      }
      else{
        logicTablero[i,j] <- F
      }
    }
  }#cierro for
  
}

