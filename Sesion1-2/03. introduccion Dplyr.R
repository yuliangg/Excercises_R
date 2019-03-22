library(dplyr)
library(ggplot2)
library(nycflights13)
# install.packages("nycflights13")

# Vemos la cabecera y la cola de flights
head(flights)
tail(flights)

# Vamos a coger aquellas columnas que acaban en "_delay".
flights[,grepl("_delay", colnames(flights))]
flights[,grep("_delay", colnames(flights))]
# Si os fijáis es un poco "raro" de escribir para ser una
# operación tan sencilla ¿no?

# Si queréis podéis descomponerlo en dos pasos:
mascara <- grepl("_delay", colnames(flights))
flights[,mascara]

# Ejercicio 2: selecciona una muestra aleatoria de 10
## Como generar azar:
runif
rnorn
# Abrir ayuda (F1) para ver otras formas de generar azar
sample(1:10, 5)
sample(c("Carlos", "Maria", "Alejandro"), 2)
sample.int(100, 2)

### Resultado del ejericio
flights[sample.int(nrow(flights), 10),
        grep("_delay", colnames(flights))]

# Ejercicio 3. De los vuelos de UA vuelve a hacer la misma
# operación que antes
flightsUA <- flights[flights$carrier == "UA",]
flightsUA[sample.int(nrow(flightsUA), 10),
        grep("_delay", colnames(flightsUA))]
# Queda muy enreversado, verdad? Veremos como hacerlo mejor
# en unos minutos

## Por cierto, pequeño aparte, es muy útil para seleccionar
# datos usar el operador %in% que es comprobar si algo está
# dentro de un conjunto
c(1, 3, 18) %in% c(1,2,3,4,5,6,7,8,9)
# devuelve: TRUE, TRUE, FALSE

#### DPLYR
# Dplyr es una maravilla. Simplemente :)
# Es la manera primordial de manipular datos a día de hoy
# De hecho entre los programadores que conocen dplyr las otras
# formas de operar han caido en desuso.

# Os las enseñamos porque algunos programadores aún las utilizan
# pero en ese caso os recomiendo que enseñéis
# dplyr al resto del equipo que es muy sencillo y facilita
# todo muchísimo

# Dplyr funciona con verbos. que no son más que funciones para
# procesar datos. 

# El verbo para seleccionar columnas se llama "select"
# Por ejemplo para seleccionar del dataset de vuelos las columnas
# carrier y arr_delay:
select(flights, carrier, arr_delay)

# Hay operadores para hacer esto más fácil.
# Por ejemplo, para elegir todas las columnas que contengan
# la cadena "_delay" como hemos hecho antes se hace con 
# "contains"
select(flights, contains("_delay"), carrier)
# Veis que es muchísimo más claro que antes?

# Otros operadores útiles para las columnas son:
# ends_with
# starts_with
# contains
# matches, este compara cada columna con una expresión
# regular

# Submuestreos, se hacen con sample_n y sample_frac

# Ejercicio, repitamos la selección anterior pero con dplyr
# es decir, una muestra aleatoria de tamanio 10 y con _delay
sample_n(
   select(flights, contains("_delay")),
   10)
# Si os fijáis hay que anidar (poner uno dentro de otro)
# las funciones para hacer dos operaciones.
# Esto es bastante incómodo y proclive a errores. Por ello
# se creó un operador de tubería:

select(flights, contains("_delay")) %>%
  sample_n(10)

# Hace "que fluya" los datos de izquierda a derecha
# o de arriba a abajo si pones fin de línea:

flights %>%
  select(contains("_delay")) %>%
  sample_n(10)

# Puedes guardarlo en variables...
flightsUA <- flights %>%
  filter(carrier == "UA") %>%
  select(contains("_delay")) %>%
  sample_n(10)

flightsUA %>%
  sample_n(1)

flights %>%
  sample_frac(0.02)

flightsUA %>%
  select(arr_delay)



## Filtros con el operador filter

# Más de un filtro simultáneo:
flights %>%
  filter(carrier=="UA", arr_delay>1)

# O en dos fases
flights %>%
  filter(carrier=="UA") %>%
  filter(arr_delay>1)

# O usando el operador and (no recomendable con dplyr)
flights %>%
  filter(carrier == "UA" & arr_delay > 1)

# Se ordena con "arrange"
flights %>%
  arrange(year)

# Descendentemente con el modificador desc
flights %>%
  arrange(desc(year))

# En el caso de que sea un número puedes usar su negativo
# (es mejor usar desc)
flights %>%
  arrange(-year)


#### Modificacion de datos
# Para crear nuevas variables se mutate y transmutate
# Son exactamente iguales pero mutate conserva el resto
# de las variables y transmutate elimina todas las variables
# antiguas

# Puedes usar cualquier expresión de R, por muy compleja que sea
# y hacer varias varibales a la vez:
flights %>%
  mutate(totalDelay = arr_delay + dep_delay,
         cost=totalDelay*385,
         arr_delay=arr_delay+1,
         carrier2=paste0(carrier, "Hola"),
         arr_delay_norm=
           (arr_delay-min(arr_delay))/(max(arr_delay)-min(arr_delay))
         )

####  Operaciones agrupadas  (estilo GROUP BY)
# Para hacer una operación agrupada siempre necesitas
# hacer primero un group_by que NO hace nada, simplemente
# añade una etiqueta que sirve para que los cálculos
# que se hagan a partir de ahora
flights %>%
  group_by(carrier)

# Para hacer un calculo usamos summarise
flights %>%
  group_by(carrier) %>%
  summarise(medDelay=mean(arr_delay, na.rm=T))

# Podemos agrupar por dos variables
flights %>%
  group_by(carrier,origin) %>%
  summarise(medDelay=mean(arr_delay, na.rm=T))

## EJERCICIOS
# 1. Filtrar todas las columnas de retraso, origen destino y carrier
#    y distancia
flights %>% select(ends_with("delay"), origin, dest, carrier, distance)

# 1a. Guarda este dataframe
flightsReducido <- flights %>% select(ends_with("delay"), origin, dest, carrier, distance)

# 2. Calcula la media de la distancia para cada par 
#    origen-destino
flights %>%
  group_by(origin,dest) %>%
  summarise(medDistancia=mean(distance, na.rm=T))


# 3. Calcula la correlación entre la distancia y el total
#    del retraso

fligthsAmpliado <- flights %>%
  mutate(totalDelay = arr_delay + dep_delay)
cor(fligthsAmpliado$totalDelay, fligthsAmpliado$distance,
    use="complete.obs")


matrizFligths <- fligthsAmpliado %>% 
  select(distance, totalDelay) %>% 
  as.matrix

cor(matrizFligths, use="complete.obs")


matrizCorrelaciones <- fligthsAmpliado %>% 
  select(distance, totalDelay) %>% 
  as.matrix %>%
  cor(use="complete.obs")

matrizCorrelaciones[1,2]

# Voy a aprovechar para explicar el operando "." (punto)
# %>% si te fijas bien por defecto lo que hace es coger 
# lo que está a su izquierda y lo incrusta como primer
# parámetro de la funciónque está a su derecha.
# pero ¿Qué ocurre si no es una función como [
# para coger el elemento 1,2 de la matriz resultante?
# o que pasa si quieres que no sea el primer parámetro o el
# segundo.

# Para eso se usa el operador punto
# Que es una "marca" para decir a la tubería dónde
# tiene que colocar el resultado de la izquierda.
# Por ejemplo para coger el elemento [1,2]:

fligthsAmpliado %>% 
  select(distance, totalDelay) %>% 
  as.matrix %>%
  cor(use="complete.obs") %>%
  .[1,2]

# 4. Cual es el  top 10 de aeropuertos de origen con más
#    media de retraso total

flights %>%
  group_by(origin) %>%
  summarise(medRetraso=mean(arr_delay+dep_delay, na.rm=T)) %>%
  top_n(10)


flights %>%
  mutate(totalRetraso=arr_delay+dep_delay) %>%
  group_by(origin) %>%
  summarise(medRetraso=mean(totalRetraso, na.rm=T)) %>%
  top_n(10)


# 5. Filtra todos aquellos vuelos que superen la media de 
#    arr_delay

flights %>%
  filter(arr_delay > mean(arr_delay, na.rm=T))

# 6. Filtra aquellas rutas que superen la media de las medias
#    del retraso total de las rutas

flights %>%
  group_by(origin, dest) %>%
  summarise(mediaRetraso=mean(arr_delay + dep_delay, na.rm=T)) %>%
  filter(mediaRetraso > mean(mediaRetraso))

threshold <- mean(flights$arr_delay + flights$dep_delay)
flights %>%
  group_by(origin, dest) %>%
  summarise(mediaRetraso=mean(arr_delay + dep_delay, na.rm=T)) %>%
  filter(mediaRetraso > threshold)

### Modificadores de verbos
# Son ligeros cambios que tienen los verbos para cambiar su
# significado. Serían como "adverbios"
# El primero es un guion bajo simplemente
# Sirve para hacer lo mismo que el verbo orgiinal pero en vez
# de escribir la variable en el código puedes usar una cadena
# de texto. Esto en determinadas ocasiones es muy útil.

variablesFavoritas <- "arr_delay"
flights %>%
  select_(variablesFavoritas)

# Sirve para otros verbos, por ejemplo mutate:
variablesFavorita <- "arr_delay+1"
flights %>%
  mutate_(arr_delay2=variablesFavorita)


# Hay otros modificadores, los más importantes son:
# _at _all _if

# Imaginemos que quieres hacer la media de varias variables
# dividido por el origen.
flights %>%
  group_by(origin) %>%
  summarise(medArrDelay=mean(arr_delay, na.rm=T),
            medDepDelay=mean(dep_delay, na.rm=T))

# Si te fijas es un poco repetitivo, ahora suponte que tienes
# que hacerlo con 80 variables.

# Para eso se puede usar _at. que no es más que un modificador
# que repite la misma operación en varias columnas:
# Por ejemplo, para repetir en las dos columnas que hemos hecho:
flights %>%
  group_by(origin) %>%
  summarise_at(c("arr_delay", "dep_delay"), mean, na.rm=T)


# También puedes hacerlo con "vars" y no tener que darle
# un vector
flights %>%
  group_by(origin) %>%
  summarise_at(vars(arr_delay, dep_delay), mean, na.rm=T)

# Lo interesante de vars, que puedes usar el dos puntos
# para definir un rango de variables, poniendo solo la primera
# y la segunda.
# MUY util
flights %>%
  group_by(origin) %>%
  summarise_at(vars(arr_delay:dep_delay), mean, na.rm=T)

# _if hace lo mismo, pero en vez de tener que enumerar
# todas las columnas, puedes ponerle un criterio.
# En este ejemplo voy a usar is.numeric, es decir,
# Voy a calcular la media para todas la variables que
# sean numéricas
flights %>%
  group_by(origin) %>%
  summarise_if(is.numeric, mean, na.rm= T)


# _all hace la misma operación con TODAS las columnas
flights %>%
  group_by(origin) %>%
  mutate_all(sum)

