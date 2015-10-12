library(ggplot2)
library(MASS)
data(Pima.tr)
h <- function(x){
  exp(x)/(1+exp(x))
}

log.like <- function(beta){
  val.1 <- ((Pima.tr$glu-120)/31)*beta[2] + beta[1]
  probs <- h(val.1)
  #error de entrenamiento del modelo con los parámetros ingresados,
  # bajo la pérdida de devianza, 
  -(sum(log(probs[Pima.tr$type=='Yes'])) + sum(log(1-probs[Pima.tr$type=='No'])))/length(val.1)
  
}

prom.probs <- function(beta){
  val.1 <- ((Pima.tr$glu-120)/31)*beta[2] + beta[1]
  probs.1 <- rep(NA, length(val.1))
  probs.1[Pima.tr$type=='Yes'] <- h(val.1)[Pima.tr$type=='Yes']
  probs.1[Pima.tr$type=='No'] <- (1-h(val.1))[Pima.tr$type=='No']
  exp(mean(log(probs.1)))
}

#Plot para las curvas de nivel de la log verosimilitud
grid.1 <- expand.grid(beta0=seq(-20,20,0.5), beta1=seq(-3,6,0.5))
grid.1$log.like <- apply(grid.1, 1, log.like)

shinyServer(function(input, output) {
  output$main_plot <- renderPlot({
    ##grid de puntos para la gráfica de glu vs proba estimada (rango de Oima.tr$glu)
    glu.grid <- seq(50,200,5)
    #evaluando la recta con los parámetros deseados, en el grid anterior.
    val.1 <- ((glu.grid-120)/31)*input$beta + input$beta0
    #proba estimada de los puntos verdaderos
    val.2 <- ((Pima.tr$glu-120)/31)*input$beta + input$beta0
    #clasificación, si val.2 > 0 entonces h(val.2) > 0.5
    Pima.tr$class <- factor(val.2 > 0)
    #puntos para la gráfica
    puntos.curva <- data.frame(glu=glu.grid, y=h(val.1))
    set.seed(123)
    #graficando observados vs curva con los parámetros ingresados.
    g <- ggplot(Pima.tr, aes(x=(glu-120)/31, y=as.numeric(type=='Yes'))) + 
      geom_jitter(position=position_jitter(height=0.05)) + xlim(c(-3,3))
    g2 <- g + geom_line(data=puntos.curva, aes(x=(glu-120)/31, y=y), col='red',size=2)
    print(g2)
    })
  
  output$contribucion.devianza <- renderPlot({
      val.1 <- ((Pima.tr$glu-120)/31)*input$beta + input$beta0
      x <- (Pima.tr$glu-120)/31
     dev.1 <- rep(NA, length(val.1))
     #calculando -log de la proba estimada de G=Gi dada X=Xi
    dev.1[Pima.tr$type=='Yes'] <- -log(h(val.1)[Pima.tr$type=='Yes'])
    dev.1[Pima.tr$type=='No'] <- -log((1-h(val.1))[Pima.tr$type=='No'])
    print(qplot(x=x, y=dev.1, colour=Pima.tr$type) + ylim(c(0,10)))
  })
  
  output$rss <- renderPrint({
    #error de entrenamiento del modelo bajo la pérdida de devianza.
    log.like(c(input$beta0, input$beta))
    #prom.probs(c(input$beta0, input$beta))
  })
  
  output$contour <- renderPlot(
  {
    # curvas de nivel de la devianza de entrenamiento.
    g <- ggplot(grid.1, aes(x=beta0,y=beta1, z=log.like)) + 
      stat_contour(binwidth=0.2, aes(colour=..level..))+
      geom_point(size=5, x=input$beta0,y=input$beta, colour = 'red')
  print(g)
  }
    )
  
})