#########
# 1. Haz un merge con toda la tabla de airports, toda la tabla de 
#    flights y toda la tabla de airlines (todas de nycflights13).
# 
#    Teniendo en cuenta que:
#    1. No quiero perder ningún registro de flights
#    2. Se debe cruzar tanto origen como destino respecto a airports
#    3. Se debe cruzar con airlines para ver el nombre de la 
#       aerolíneas
#    4. Se quiere crear una nueva variable que sea la diferencia en
#       altitud del aeropuerto de origen frente al de destino
#    5. Se quiere crear otra variable que es la diferencia horaria
#       entre ambas zonas (la de origen y la de destino)
#
#   Una vez tengas este cruce:
#    a) Calcula el retraso total promedio agrupado por diferencia
#       horaria entre origen y destino

#####
# 2. Crea una función que haga el backtesting como la que hemos hecho
#    pero que acepte estrategias con 3 stocks en vez de sólo dos

####
# 3. Crea una función con expresiones
#    regulares que cumpla con los siguientes test
#
library("testthat")
test_that("recogerNumeroTelefono funciona", {
  expect_equal(recogerNumeroTelefono("123-456-789"), 123456789)
  expect_equal(recogerNumeroTelefono("(123) 456-789"), 123456789)
  expect_equal(recogerNumeroTelefono("   (123) 456 (789)"), 123456789)
  expect_equal(recogerNumeroTelefono(""), NULL)
  expect_equal(recogerNumeroTelefono(NA), NULL)
})


####
# 4. Modifica los test anteriores para que prueben una version mejorada
#    de esta funcion que extrae más de un número de la misma cadena
#    de texto.
#    Sólo es necesario hacer el test, no hace falta que hagas la función


####
# 5. Crea una funciones que dada una url web extraiga todos los elementos ol
# 5a. Dividela en otras funciones y justifica porque lo has hecho así
# 5b. Crea un test para esta función con la web de wikiquotes
#     de groucho marx https://es.wikiquote.org/wiki/Groucho_Marx
#     No compruebes todos los elementos del vector, sólo el primero
#     y la longitud del vector.


####
# 6. Crea varios tests para comprobar que backtesting funciona correctamente
#    en condiciones normales
# 6a.Crea un test de un caso extremo en el que backtesting falle
# 6b.Mejora backtesting para que funcione el test que acabas de crear

####
# 7. Utilizando las funciones que hicimos en backtesting y modificandolas
#    ligeramente para que acepten como parámetro dos nombres de stock
#    p.e: GOOGL, AAPL, BABA.
#    y aplique la estrategia que hemos programado y devuelva el
#    beneficio final obtenido.
#    Es decir miFuncion("GOOGLE", "AAPL") devuelve el resultado final


####
# 8. (Opcional) Acaba la simulación de Parable of Polygons
#    http://ncase.me/polygons/
#    Faltaría hacer una función que mueva a los sujetos incómodos
#    a posiciones vacías y otra función que ejecute la simulación
#    varias veces para ver el resultado final
#    Nota: pon un máximo de repeticiones porque a veces
#    las simulaciones nunca acabana. Así que tienes que limitar el bucle
#    para que no sean infinitas.
