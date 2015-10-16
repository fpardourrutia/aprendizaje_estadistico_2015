
#library(arm)
#library(splines)
#mod_1 <- bayesglm(puerta_pir ~ ns(puerta, df=5)+ns(entrada,df=5)+ns(escalera, df=5) +
#                    ns(entrada, df=4):ns(escalera,df=4)+ns(entrada, df=4):ns(puerta, df=4)+
#                    ns(puerta, df=4)+ns(escalera, df=4), 
#                  data=datos_f, family='binomial', prior.df=Inf, prior.scale=2)
#display(mod_1)
#dd <- seq(0,1,0.05)

#new_dat <- expand.grid(list(entrada=dd, escalera=dd, puerta=dd))
#new_dat$p <- predict(mod_1, newdata = new_dat, type='response')
#ggplot(new_dat, aes(x=puerta, y=p, group=escalera, colour=escalera)) + geom_line() +
#  facet_wrap(~entrada)

#qplot(predict(mod_1, type='response'))
#table(predict(mod_1, type='response')>0.5, datos_f$vestidor_pir)

library(randomForest)
datos_f$hora <- hours(datos_f$datetime)
datos_f$dia_sem <- factor(weekdays(datos_f$datetime))
datos_b <- filter(datos_f, puerta < 0.99)
table(datos_b$puerta_pir)
datos_1 <- datos_b %>% filter(puerta_pir==1)
datos_2 <- datos_b %>% filter(puerta_pir==0) %>% sample_n(nrow(datos_1))
datos_t <- bind_rows(datos_1, datos_2)
nrow(datos_t)
rf <- randomForest(factor(puerta_pir) ~ 
                     entrada+puerta+sala+escalera+cuarto+consumo+hora+dia_sem+cocina+estudiof+estudiot, 
                   data=datos_t, 
                   ntree=500)
rf
plot(rf)
importance(rf)




preds <- predict(rf, type='prob')[,2] > 0.5
tab_1 <- table(preds, datos_t$puerta_pir, cut(datos_t$puerta, seq(0,1,0.25)))
tab_1

partialPlot(rf, datos_t %>% data.frame, consumo)
dat_pp <- partialPlot(rf, datos_t %>% data.frame, escalera)
dat_pp
