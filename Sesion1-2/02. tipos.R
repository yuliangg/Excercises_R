# Tipos de estructuras de datos en R
# 1º Vector
titanic$Survived

# Como saber el tipo.
class(titanic$Survived)
str(titanic$Survived)
str(titanic)

# Como crear un vector desde 0
edadDeMisAlumnos <- c(18, 20, 21, 18, 24, 35, 45)
nombreDeMisAlumnos <- c("Carlos", "Maria", "Marisa")

# Crear un vector vacio PREALLOCATED o pre-reservado
# Es la manera recomendada cuando se itera un vector
# en un bucle for o similar
integer(100)
numeric(10)
character(10)


# c tambien sirve para concatenar vectores
c(edadDeMisAlumnos, 1, 3, 4)

# Cuando dos tipos no encajan...
c(edadDeMisAlumnos, nombreDeMisAlumnos)
# Mira lo que pasa

# 2º LISTAS
# Son las estructuras de datos más flexibles.
# Por ejemplo cuando se trabaj con documentos JSON se suelen
# usar listas.
misAlumnos <- list(18, "Carlos", 24, "Maria")
misAlumnos

lista2 <- list(1:10, "Carlos",
               c("Carlos", "Maria"))

lista3 <- list(sabor="Chocolate", tamanio=3)

lista2[3]
str(lista2[3])

lista2[[3]]
str(lista2[[3]])

lista3$tamanio

# Diferencia entre [ y [[
# El corchete simple devuelve una lista de tamaño 1
# con el elemento en cuestión. Pero  ES una lista 
# "pequeñita". Si quieres acceder al propio elemento
# sin lista que lo rodee usa el doble corchete

# NOTA: Es muy importante esta diferencia, en ocasiones
# os falla muchos comandos de R porque no prestáis atención
# esta distinción
lista3["tamanio"]

str(lista3["tamanio"])

lista3[["tamanio"]]

### 3º Relacion entre un DF y una lista
typeof(titanic)
titanic$Age[3]
titanic["Age",3]
titanic[,"Age"][3]

# Los dataframes son listas de vectores (que son las columnas)
# Estos vectores forzosamente tienen que tener el mismo tamaño
# (porque tienen el mismo número de filas)

# Devuelve un df de una columna, el comando [ tiene parámetros
# como una función cualquiera, el más importante es drop
titanic[,"Age", drop=FALSE]

# IMPORTANTE, usad siempre
str
class

### 4º Factores
str(titanic)
embarked <- titanic$Embarked
str(embarked)

# Se va a romper todo...
c(embarked, "C")

# ¿Por qué? Porque embarked es un factor
# Realmente es un vector numérico aunque tu lo veas como
# una cadena de texto
# Es un vector numérico que tiene una tabla de traducción
# entre números y niveles de la variable.
# p.e: C -> 1, "" -> 3, ...
# entonces cuando intentas concatenar una "C" de verdad
# R lo que hace es convierte todo a numérico (usando los números)
# y luego le añade una "C". Quedando como resultado:
# c("1", "2", "3", "C")


# as.xxxxxx convierte entre tipos de estructuras de datos

# Para obtener los textos
as.character(embarked)
# Perdemos la propiedad  pero a cambio la operación queda
# bien hecha
c(as.character(embarked), "C")

# embarked es un factor
is.factor(embarked)
# y podemos ver los niveles que tiene
levels(embarked)

# Curioso, puedes cambiar el valor de los niveles
levels(embarked)[2] <- "Carlos"

reorder() # reordena los levels
as.factor() # para hacer factores a partir de caracteres


## 5º MATRICES

# Las matrices son vectores
# Con una etiqueta que dice que dimensionalidad tienen
# Por ejemplo vamos a crear una matriz de 1 a 9
matrix(1:9, ncol=3)

# El orden normal de almacenamiento es por columnas, pero
# si quieres ponerlo por filas...
matrix(1:9, ncol=3,byrow = T)

# Vamos a corregir el ejercicio de correlaciones antiguo.
cor(as.matrix(titanic[,c("Age", "Fare")]), use = "complete.obs")


# EXTRA. Carga de librerías y conflicto de nombres
# Ejemplo de conflicto de nombres
library("dplyr")
library("ggplot2")
library("MASS")

## Muchas veces os aparecen mensajes en rojo que se ignoran.
# uno especialmente frecuente es algo similar a esto:
# 
# The following objects are masked from ‘package:stats’:
#   
#   filter, lag
# 
# Este mensaje ocurre cuando has cargado más de un paquete
# Cuando cargas un paquete, se sobreescribe todos sus nombres
# en el espacio de nombres (algo así como tu enviroment)
# Si hay dos paquetes que tienen una variable o función
# con el mismo nombre (p.e: dplyr, stats tienen los dos "filter")
# 
# R te avisa con un warning, pero sobreescribe el nombre
# en base al orden en el que cargues la librería.
# tened mucho cuidado con eso porque no tienes un 100%
# de garantía que una librería añada un nuevo nombre en una
# versión futura y te deje de funcionar el código

# Hay una manera que se puede usar para acceder de forma
# unívoca a una función en concreto:
ggplot2::aes
# Con el doble dos puntos puedes seleccionar el paquete
# al que quieres hacer referencia.

# En general para evitar que haya conflicto con actualizaciones
# futuras de paquetes y poder gestionar el versionado de 
# dependencias existe un paquete llamado "ratr" que se 
# escapa del contenido de la clase pero os recomiendo que lo
# tengáis bajo el radar