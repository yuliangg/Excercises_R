library('testthat')
#cargar fichero tuyo.
source('mifichero.R')

sumar <- function(a,b){
  a+b
}

#test, para comparar si una función da el resultado correcto

expect_equal(sumar(2,3),5)
