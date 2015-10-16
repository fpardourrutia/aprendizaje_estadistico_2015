library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(randomForest)

datos <- readRDS('datos/datos_completos_cons.rds')
datos_f <- filter(datos, !is.na(consumo))
nrow(datos_f)

datos_f$hora <- hour(datos_f$datetime)
datos_f$dia_sem <- factor(weekdays(datos_f$datetime))
datos_b <- datos_f
table(datos_b$puerta_pir)
datos_b$puerta_m <- 'Activado'
datos_b$puerta_m[!datos_b$puerta_pir] <- 'Desactivado'
datos_b$puerta_m <- factor(datos_b$puerta_m)
table(datos_b$puerta_m)


datos_b$muestra <- 'entrena'
datos_b$muestra[datos_b$ind > 150000] <- 'publico'
datos_b$muestra[datos_b$ind > 175000] <- 'privado'
entrena  <- filter(datos_b, muestra == 'entrena')
publicos <- filter(datos_b, muestra == 'publico')
privados <- filter(datos_b, muestra == 'privado')
table(publicos$puerta_m)
table(privados$puerta_m)

set.seed(391)
datos_1 <- entrena %>% filter(puerta_pir==1)
datos_2 <- entrena %>% filter(puerta_pir==0) %>% sample_n(nrow(datos_1))
datos_t <- bind_rows(datos_1, datos_2)
#datos_t <- datos_b
nrow(datos_t)
prop.table(table(datos_t$puerta_pir))
table(datos_t$puerta_m)

