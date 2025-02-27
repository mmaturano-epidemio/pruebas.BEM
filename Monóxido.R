#Cargo bases y librerías####
library(epiDisplay);library(epicalc);library(dplyr);library(tidyverse)
epicalc::zap()#esto borra lo que hay en environment incluyendo ocultos
ls()#corroboro que no queda nada
Base <- read.csv2("NEUQUEN_NOMINAL.csv",sep=";",as.is = TRUE)
use(Base)#carga la base a la memoria de R, agilizando el trabajo, es similar a attach 
search()#chequeo que ".data" esté en la memoria
length(IDEVENTOCASO);length(unique(IDEVENTOCASO))#Hay duplis...
View(table(names(Base)))#a ver qué hay para armar el filtro
table(ID_SNVS_EVENTO)
table(EVENTO)

#Filtro la base####
Monóxido_filtrada <- subset(Base,Base$EVENTO=="Intoxicaci\xf3n/Exposici\xf3n por Mon\xf3xido de Carbono",
                            select=(c("IDEVENTOCASO",
                                      "SEXO",
                                      "ANIO_EPI_APERTURA",
                                      "ANIO_EPI_MUESTRA",
                                      "ANIO_EPI_SINTOMA",
                                      "CALLE_DOMICILIO",
                                      "CLASIFICACION_MANUAL",
                                      "EDAD_DIAGNOSTICO",
                                      "ESTABLECIMIENTO_CARGA",
                                      "ESTABLECIMIENTO_DIAG",
                                      "EVENTO","FALLECIDO",
                                      "FECHA_APERTURA",
                                      "FECHA_INICIO_SINTOMA",
                                      "FECHA_NACIMIENTO",
                                      "FIS",
                                      "GRUPO_ETARIO",
                                      "LOCALIDAD_CARGA",
                                      "LOCALIDAD_RESIDENCIA",
                                      "PROVINCIA_RESIDENCIA",
                                      "REGION_SANITARIA_CARGA",
                                      "REGION_SANITARIA_CLINICA",
                                      "SEPI_APERTURA",
                                      "SEPI_CONSULTA",
                                      "SEPI_SINTOMA")))
#chequeo si hay duplis y los filtro####
length(Monóxido_filtrada[,1]);length(unique(Monóxido_filtrada[,1]))#hay duplis
Monóxido_filtrada <- Monóxido_filtrada[!duplicated(Monóxido_filtrada[,1]),]#filtro duplis
use(Monóxido_filtrada)#reemplazo la base que está en la memoria. Esto sirve por ejemplo para poder operar con las columnas sin tener que aneponer "BASE$" al nombre
#Exploro la base####
epiDisplay::summ(Monóxido_filtrada)
epiDisplay::codebook(Monóxido_filtrada)
#Voy a hacer dos histogramas yuxtapuestos para casos por año####
par(mfrow = c(1, 2))#Para que quepan dos histogramas
# 2023
hist((filter(Monóxido_filtrada,Monóxido_filtrada$ANIO_EPI_APERTURA==2023))$SEPI_APERTURA,
     breaks = seq(0, 52, by = 1), 
     main = "Casos 2023", 
     xlab = "SE", 
     ylab = "Casos", 
     col = "lightblue", 
     border = "black", 
     xlim = c(1, 52), 
     ylim = c(0, max(table(Monóxido_filtrada$SEPI_APERTURA)) + 1)  #Límite eje Y
)

# 2024
hist((filter(Monóxido_filtrada,Monóxido_filtrada$ANIO_EPI_APERTURA==2024))$SEPI_APERTURA, 
     breaks = seq(0, 52, by = 1), 
     main = "Casos 2024", 
     xlab = "SE", 
     ylab = "Casos", 
     col = "lightgreen", 
     border = "black", 
     xlim = c(1, 52), 
     ylim = c(0, max(table(Monóxido_filtrada$SEPI_APERTURA)) + 1)  
)



#Hago un barplot de sexo####
par(mfrow = c(1, 1))#Para que quepa un solo gráfico
barplot((table(SEXO)), 
        main = "Casos según sexo",  
        xlab = "Sexo legal",             
        ylab = "Casos",
        col = c("red", "lightyellow","lightgreen"),  
        border = "black",         
        ylim = c(0, 500)  
)