library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(randomForest)

rf <- randomForest(puerta_m ~ bano_cuarto+bano_escalera+cocina+
                     cuarto+entrada+escalera+estudiof+estudiot+puerta+sala+tv+vestidor+
                     consumo + hora + dia_sem, 
                   data=datos_t, 
                   ntree=500, importance = T)
rf
plot(rf)
importance(rf, scale= F)

publicos <- filter(datos_b, muestra=='publico')
table(pp <- predict(rf, publicos))
table(pp, publicos$puerta_m)
prop.table(table(pp, publicos$puerta_m),2)

privados <- filter(datos_b, muestra=='privado')
table(pp <- predict(rf, privados))
table(pp, privados$puerta_m)
prop.table(table(pp, privados$puerta_m),2)



partialPlot(rf, datos_t %>% data.frame, consumo)
