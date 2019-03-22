# Read csv es la función por defecto para leer un csv
# Tienes que darle la ruta del fichero, pero ten cuidado
# que tienes que estar en la carpeta del proyecto de 
# RStudio para ello.
titanic <- read.csv("train.csv")
head(titanic)
# Un dataframe es una estructura tabular para guardar datos
# de distintos tipos. Resumiento, una tabla.

# Así se lee una columna de un dataframe
titanic$Age
titanic[,"Age"]

# Primer ejercicio. Cuál es la edad del sujeto numero 7
titanic[7, "Age"]

# Obtener el sujeto #7
titanic[7,]

# Segundo ejercicio. Que edad tiene la persona más joven
min(titanic$Age, na.rm=T)

# Ejercicio. Calcula la media y maximo de la edad
mean(titanic$Age, na.rm=T)

max(titanic$Age, na.rm=T)

## Summary es una función que te muestra los típicos
# estadísticos de una o más variables.
summary(titanic$Age)

# Se pueden hacer operaciones sobre vectores enteros
# simplemente utilizando con ellos un operador
# matemático o cualquier función como ya hemos hecho
# (min, max...), aquí vamos a realizar una comparación 
# (menor que) para localizar a los menores del desastre
# del titanic.
titanic$Age < 18

## Ejercicio, selecciona las filas de menores de edad y
# guardalo en un nuevo dataframe llamado menores
menores <- titanic[titanic$Age < 18,]
menores
# Como podéis observar el vector que hemos generado antes
# comparando la edad con el número 18 se puede utilizar como
# selector de filas (o incluso columnas) en un dataframe

## View es para ver dentro de RStudio (sólo funciona en este)
# con RStudio la tabla en un formato más visual
# Esta es de las pocas funciones que empiezan con mayúscula
View(menores)


## Ejercicio mejorado. Vamos a quitar los NA que aparecen en menores
# Para ello lo vamos hacer por pasos

# Mascara es un concepto bastante amplio que en este contexto
# significa un vector booleano (de TRUE y FALSE) que "enmascara"
# a las personas que son mayores de edad dejando visibles 
# únicamente a los menores. Esto ya lo hemos realizado anteriormente
mascaraDeMenores <- titanic$Age < 18
mascaraDeMenores
# El problema de esta máscara es que la operación <
# como la mayoría de operaciones en R devuelven un NA (valor perdido)
# cuando en el vector original hay un NA.
# Este comportamiento aunque incómodo es el más deseable
# desde el punto de vista matemático.
# Dicho de otra manera, si no sabes la edad de alguien,
# no puedes saber si es menor o mayor de 18. Por eso la edad
# se "arrastra"

# Primero vamos a hacerlo de una forma un tanto ortopédica
# pero que nos servirá docentemente para repasar conceptos
# is.na es una función que permite

mascaraDeMenores[is.na(mascaraDeMenores)] <- F

menores <- titanic[mascaraDeMenores,]
menores
# Ejercicio version 3. Vamos a volver a resolverlo, pero mejor
# En vez de crearnos una máscara y sustituir los NA
# por FALSE, vamos a usar el operador and (&) para
# hacer todo el cáclulo que hemos hecho anteriormente
menores <- titanic[!is.na(titanic$Age) & titanic$Age < 18,]

# Nota: Vamos instalando estos paquetes en la pausa
#install.packages(c("dplyr", "readr", "plotly"))

# Para comprobar si se ha instalado bien, intentamos cargarlo
# Cargar dplyr
#dplyr is a grammar of data manipulation, providing a consistent set of verbs that 
#help you solve the most common data manipulation challenges
library("dplyr")

# Vamos a hacer varias selecciones de datos dentro del dataframe
# Seleccionar multiples filas
titanic[c(3,5),]

# Seleccionar multiples filas
titanic[c(3,5),c("Age", "Sex")]
titanic[c(3,5),c(2,5)]

# Podemos combinar sintáxsis. Aquí estamos primero cogiendo
# la columna de nombres y posteriormente las filas 1 y 2
# Esta no es la manera típica de hacerlo, pero es posible.
titanic$Name[c(1,2)]
# De forma equivalente...
titanic[c(1,2),"Name"]

# Se puede seleccionar y asignar a la vez
titanic[c(1,2),"Age"] <- 20

# Funciones utiles de data frames
colnames(titanic) # Muestra los nombres de columnas
rownames(titanic)# de filas 
nrow(titanic) # Numero de filas
ncol(titanic) # Numero de columnas

cbind() # "concatenar columnas"
rbind() # "concatenar filas"


####### Ejercicios
# Filtra aquellas mujeres de primera clase y extrae
# las columnas Fare y Survived
mujeresPrimera <- titanic[titanic$Sex == "female" & titanic$Pclass == 1, c("Survived", "Fare")]

# Porcentaje de supervivencia en este grupo.
sum(mujeresPrimera$Survived)/nrow(mujeresPrimera)
mean(mujeresPrimera$Survived)

tapply(titanic$Survived, titanic$Pclass, mean)
tapply(titanic$Survived, titanic$Sex, mean, na.rm=T)

table(titanic$Pclass)
table(titanic$Sex)

by(titanic, titanic$Sex, summary)

aggregate(Survived ~ Pclass, titanic, mean)

aggregate(cbind(Survived,Age) ~ Pclass + Sex, titanic, mean)

cor(titanic[,c("Age", "Fare")])

cor(titanic$Age, titanic$Fare, use="complete.obs")

### Ejercicios
## 1. Media de edad de hombres que sobrevivieron
mean(titanic[titanic$Sex=="male" & titanic$Survived,"Age"], na.rm=T)

## 2. Cuantas personas sobrevivieron
sum(titanic$Survived)
## 3. Cuantas personas fallecieron
nrow(titanic) - sum(titanic$Survived)
sum(!titanic$Survived)

# Respuesta alternativa:
table(titanic$Survived)

## 4. Cuantas personas viajaron en el titanic
nrow(titanic) # Menos preciso, porque hay gente que no 
# embarcó en el Titanic.

sum(titanic$Embarked != "")
# Ojo al factor Embarked, tiene un nivel "" que ya veremos más
# adelante

## 5. Ratio Entre personas de primera clase y tercera
sum(titanic$Pclass == 1) / sum(titanic$Pclass == 3)

## 6. Seleccionar columna Age y Sex para personas de primera clase
titanic[titanic$Pclass == 1, c("Age", "Sex")]

## 7. Calcula la máscara para seleccionar los supervivientes
##   de tercera clase o los hombres de primera que fallecieron

(titanic$Pclass == 3 & # personas de tercera clase
  titanic$Survived) # que sobrevivieron
                  | # O
(titanic$Pclass == 1 & # primera clsse
  titanic$Sex == "male" & # hombres
  !titanic$Survived) # que falleció

(titanic$Pclass == 3 & titanic$Survived) |
  (titanic$Pclass == 1 & titanic$Sex == "male" & !titanic$Survived)

## 8. Correlación entre edad y fare para cada sexo
# PARA CASA :)

