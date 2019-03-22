## CONTROL DE FUJO

# Cómo hacer un if (flujo condicional)
# No siempre tiene que haber else if y else.
# Puede haber un if unicamente o un if y un else

if (5 > 3) {
  print("Hola")
} else if (2 < 1) {
  print("Adios")
} else {
  print("Cierre")
}

# Bucles for
for (x in 1:10) {
  print(x)
}

# Bucles while
contador <- 5
while (contador > 0) {
  print(contador)
  contador = contador -1
}

## Funciones

miFuncion <- function(a, b) {
  return(a+b)
}

miFuncion <- function(a, b) {
  # .... cosas
  a+b  # es como si estuviesemos devolviendo a+b. No hace falta
  # return si está en la última línea
}

# valores por defecto (como en la ayuda de R)
miFuncion <- function(a, b=5) {
  a+b
}

# ¿Qué es una función impura? Es una función que tiene
# efecto "fuera de su cuerpo.
# Un caso típico es modificar un parámetro de entrada
# como este dataframe: 

# Intentad NUNCA hacer esto
miFuncionImpura <- function(df) {
  df$a = 3
  df
}

##### Forma vectorizada vs bucles
# Cuando se está aprendiendo a programar se tiende
# a realizar muchas tareas en bucles.
# Es la manera que tenemos de pensar y por tanto suele ser
# la manera en la que escribís código.

# Vamos a ver un ejemplo:
# Si compras 1 accion de google cada dia que este supera
# a apple. ¿En que coste total incurres?

# Nos inventamos los datos
aapl <- rnorm(100)
googl <- rnorm(100)

# Esta sería la forma con bucle
importe <- 0
for (i in 1:100) {
  if (aapl[i] < googl[i])
    importe <- importe + googl[i]
}


# Esta sería la forma vectorizada. Mucho más compacta
# y rápida. Muchas veces puedes ganar un x100 de velocidad
sum(googl[googl > aapl])

