#Cargo bases y librerías####
library(epiDisplay);library(epicalc);library(dplyr)
zap();ls()
Base <- read.csv2("NEUQUEN_CLI.csv",sep=";",as.is = TRUE)
use(Base)#carga la base a la memoria de R, agilizando el trabajo
search()#chequeo que ".data" esté
#Exploro un poco la base####
names(Base)#
table(Base$NOMBREGRPEVENTOAGRP) #O directamente:
table(NOMBREGRPEVENTOAGRP) #Esto funciona por "use"
epiDisplay::codebook(subset(Base,NOMBREGRPEVENTOAGRP=="Respiratorias",select = c(ANIO,SEMANA,NOMBREEVENTOAGRP)))
summary(subset(Base,NOMBREGRPEVENTOAGRP=="Respiratorias",select = c(ANIO,SEMANA,NOMBREEVENTOAGRP)))
Base$NOMBREEVENTOAGRP <- as.factor(Base$NOMBREEVENTOAGRP)
codebook(subset(Base,NOMBREGRPEVENTOAGRP=="Respiratorias",select = c(ANIO,SEMANA,NOMBREEVENTOAGRP)))
summary(subset(Base,NOMBREGRPEVENTOAGRP=="Respiratorias",select = c(ANIO,SEMANA,NOMBREEVENTOAGRP)))
View(table((subset(Base,NOMBREGRPEVENTOAGRP=="Respiratorias",select = c(ANIO,SEMANA,NOMBREEVENTOAGRP)))
))
Base$ANIO_SE <- paste(Base$ANIO+Base$SEMANA)
Base$SE_ANIO <- Base$ANIO+Base$SEMANA

#Algunos gráficos####
#Histograma de Neuquén, inmunoprevenibles 2023
hist(subset(Base,Base$LOCALIDAD=="NEUQUEN"&Base$ANIO==2023&Base$NOMBREGRPEVENTOAGRP=="Inmunoprevenibles")$SEMANA,density=100,angle=(140),main = "Inmunoprevenibles - 2023",xlab="SE",ylab = "Casos totales",breaks=52)
epiDisplay::codebook(Base)
data("Familydata")
epiDisplay::codebook(Familydata)
epiDisplay::codebook(subset(Familydata,select=c("sex","age","wt")))
detach("package:epicalc")