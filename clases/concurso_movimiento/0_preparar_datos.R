library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(stringi)
library(lubridate)

## leer sensores pir
pir <- read_csv('datos/pir_act_tot.csv',
                col_names = c('ts','xbee_id','lugar','pir','tipo','sensor_num','estado'), 
                col_types='cccccii')
pir <- filter(pir, tipo=='binary' & !is.na(sensor_num))
pir$datetime <- as.POSIXct(pir$ts, format = '%Y-%m-%d %H:%M:%S')

## leer estado movimiento
file_name = 'datos/movimiento.csv'
lineas <- list()
file_mov  <- file(file_name)
lineas <- readLines(file_mov)


## procesar movimiento
procesar_mov <- function(linea){
    linea_split_1 <- stri_split(linea, regex = ',\\"')[[1]]
    inicial <- stri_split(linea_split_1[1], fixed=',')[[1]]
    final <- stri_sub(linea_split_1[2], from=21, to=-4) %>% stri_split(fixed=",")%>% .[[1]] %>%
              stri_replace_all(replacement = '', regex="\\'") %>%  map(stri_trim_both) %>% flatten
    final_2 <- stri_split(final, fixed = ":") %>% zip_n %>% map(flatten)
    final_3 <- data_frame(lugar = final_2[[1]], estado = as.numeric(final_2[[2]]))
    #c(inicial[2], final_2)
    final_3$datetime <- inicial[2]
    final_3 %>% spread(lugar, estado)
}

set.seed(12943)
pred_vars <- lineas[sample(1:length(lineas), 300000)] %>% map(procesar_mov) 
x <- bind_rows(pred_vars)
#pred_vars <- NULL
x$casa <- NULL
x$patio <- NULL
x$datetime <- as.POSIXct(x$datetime, format = '%Y-%m-%d %H:%M:%S')
x <- arrange(x, datetime)


## Datos de consumo de energía
consumo <- read_csv('datos/consumo.csv', col_names = F)
consumo$datetime <- as.POSIXct(consumo$X1, format = '%m-%d-%Y %H:%M:%S')
consumo$X1 <- NULL
head(consumo)

## Pegar datos
y <- filter(x, datetime > min(consumo$datetime)-30)
pir_f <- filter(pir, datetime > min(consumo$datetime)-30)
tiempos_estado <- y$datetime
tiempos_pir <- pir_f$datetime
consumo <- arrange(consumo, datetime)
tiempos_consumo <- consumo$datetime

consumo_v <- consumo$X2
ind_pir <- 1
ind_consumo <- 1
lista_out <- list()

lugares <- pir_f$lugar
lugares_nom <- names(y)[-1]

for(i in 1:length(pred_vars)){
  mom <- tiempos_estado[i]
  mom_post <- mom + 10 
  mom_pre <- mom - 30
  while(tiempos_consumo[ind_consumo] < mom_pre){
    ind_consumo <- ind_consumo + 1
  }
  consumos <- c()
  consumo_medio <- NA
  
  while(tiempos_consumo[ind_consumo]<= mom){
    consumos <- c(consumos, consumo_v[ind_consumo] )
    ind_consumo <- ind_consumo + 1
  }
  consumo_medio <- mean(consumos)
  
  while(tiempos_pir[ind_pir] < mom){
    ind_pir <- ind_pir + 1
    if((ind_pir %% 10000) == 0){
        print(c(i,ind_pir))
    }
  }
  eventos <- c()
  while(tiempos_pir[ind_pir] <= mom_post ){
    eventos <- c(eventos, ind_pir)
    ind_pir <- ind_pir + 1
  }
  lista_out[[i]] <- data_frame(ind=i,consumo = consumo_medio,datetime = mom, lugar = lugares_nom, estado = lugares_nom %in% lugares[eventos])
}


length(lista_out)
pir_x <- bind_rows(lista_out) %>%
  mutate(lugar = paste(lugar, 'pir', sep='_' )) %>%
  spread(lugar, estado)
y$ind <- 1:nrow(y)
datos <- left_join(y, pir_x) %>% filter(!is.na(vestidor_pir))
nrow(datos)
#saveRDS(datos, file='datos/datos_completos_cons.rds')
nrow(datos)

