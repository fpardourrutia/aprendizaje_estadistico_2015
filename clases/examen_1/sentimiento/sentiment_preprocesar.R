library(dplyr)
library(Matrix)
library(tidyr)

leer <- function(tipo){
  lista.archivos <- list.files(path=paste0('datos/',tipo), 
                               pattern=".txt", full.names = T)
  lista.textos <- lapply(lista.archivos[1:1000], function(archivo){
    con <- file(archivo, "r", blocking = FALSE)
    lineas <- readLines(con = con)
    close(con)
    lineas
  })
  lapply(lista.textos, function(x){
    y <- paste(x, collapse=' ')  
    y
  } )
  #lista.textos
}

textos.pos <- Reduce('c', leer('pos'))
textos.neg <- Reduce('c', leer('neg'))



length(textos.pos)
textos.pos[30]
length(textos.neg)
textos.neg[40]


total.textos <- c(textos.pos, textos.neg)
# usamos el paquete tm - textmining. 
library(tm)
corpus.frases <- Corpus(VectorSource(total.textos))
dtm <- DocumentTermMatrix(corpus.frases, 
                          control=list(wordLengths=c(2, Inf),
                                       bounds = list(global = c(10,Inf))))
dtm


terminos <- dtm$dimnames$Terms
docs <- dtm$dimnames$Docs
valor <- dtm$v


## Convertimos a data frame

mat_doc_term <- data_frame(id_doc = dtm$i, 
                           id_termino = dtm$j, 
                           frec = dtm$v) %>%
                left_join(
                  data_frame(termino = terminos, id_termino=1:length(terminos))) 
doc_term <- mat_doc_term %>% filter(frec > 2)
documentos <- data_frame(id_doc = 1:length(total.textos), 
                         polaridad =  c(rep("positiva",1000), rep("negativa",1000)),
                         texto=total.textos)

saveRDS(doc_term, file='datos/documentos_terminos.rds')
saveRDS(documentos, file='datos/documentos.rds')
