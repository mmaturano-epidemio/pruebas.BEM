#Cargo bases y librer�as####
library(epiDisplay);library(epicalc)
epicalc::zap()#esto borra lo que hay en environment incluyendo ocultos
ls()#corroboro que no queda nada
Base <- read.csv2("NEUQUEN_NOMINAL.csv",sep=";",as.is = TRUE)
use(Base)#carga la base a la memoria de R, agilizando el trabajo, es similar a attach 
search()#chequeo que ".data" est� en la memoria
length(IDEVENTOCASO);length(unique(IDEVENTOCASO))#Hay duplis...
#View(table(names(Base)))#para ver qu� hay para armar el filtro
#table(ID_SNVS_EVENTO)
#table(EVENTO)

#Filtro la base####
Mon�xido_filtrada <- subset(Base,Base$EVENTO=="Intoxicaci\xf3n/Exposici\xf3n por Mon\xf3xido de Carbono",
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
length(Mon�xido_filtrada[,1]);length(unique(Mon�xido_filtrada[,1]))#hay duplis
Mon�xido_filtrada <- Mon�xido_filtrada[!duplicated(Mon�xido_filtrada[,1]),]#filtro duplis
use(Mon�xido_filtrada)#reemplazo la base que est� en la memoria. Esto sirve por ejemplo para poder operar con las columnas sin tener que aneponer "BASE$" al nombre
#Exploro la base####
epiDisplay::summ(Mon�xido_filtrada)
epiDisplay::codebook(Mon�xido_filtrada)
epiDisplay::summ(SEPI_APERTURA)
epiDisplay::summ(as.factor(SEXO))
#Voy a hacer dos histogramas yuxtapuestos para casos por a�o####
par(mfrow = c(1, 2))#Para que quepan dos histogramas
# 2023
hist((filter(Mon�xido_filtrada,Mon�xido_filtrada$ANIO_EPI_APERTURA==2023))$SEPI_APERTURA,
     breaks = seq(0, 52, by = 1), 
     main = "Casos 2023", 
     xlab = "SE", 
     ylab = "Casos", 
     col = "pink", 
     border = "black", 
     xlim = c(1, 52), 
     ylim = c(0, max(table(Mon�xido_filtrada$SEPI_APERTURA)) + 1)  #L�mite eje Y
)

# 2024
hist((filter(Mon�xido_filtrada,Mon�xido_filtrada$ANIO_EPI_APERTURA==2024))$SEPI_APERTURA, 
     breaks = seq(0, 52, by = 1), 
     main = "Casos 2024", 
     xlab = "SE", 
     ylab = "Casos", 
     col = "violet", 
     border = "black", 
     xlim = c(1, 52), 
     ylim = c(0, max(table(Mon�xido_filtrada$SEPI_APERTURA)) + 1)  
)

#Hago un barplot de sexo####
par(mfrow = c(1, 1))#Para que quepa un solo gr�fico
barplot((table(SEXO)), 
        main = "Casos seg�n sexo",  
        xlab = "Sexo legal",             
        ylab = "Casos",
        col = c("pink", "lightgreen","blue"),  
        border = "black",         
        ylim = c(0, (max(table(SEXO)))+10)
)

#A ver qu� se puede hacer con grupo etario####
table(GRUPO_ETARIO)
par(mfrow = c(1, 1))#Para que quepa un solo gr�fico

barplot((table(GRUPO_ETARIO)), 
        main = "Casos seg�n GE",  
        xlab = "GE",             
        ylab = "Casos",
        #col = c("red", "lightyellow","lightgreen"),  
        border = "black",         
        ylim = c(0, (max(table(GRUPO_ETARIO)))+1),
        #xlim = c(0,10),
        #horiz = TRUE,
        #las=2,
        #cex.names = 0.2
)
#Las columnas salen sin r�tulo porque los nombres son muy largos
#acorto los nombres
table(GRUPO_ETARIO)
Mon�xido_filtrada$GRUPO_ETARIO <- gsub("De (\\d+) a (\\d+) a\xf1os", "\\1-\\2", Mon�xido_filtrada$GRUPO_ETARIO)# Grupos etarios est�ndar
Mon�xido_filtrada$GRUPO_ETARIO <- gsub("Posneonato (29 hasta 365 d\xcdas)", "Posneonato", Mon�xido_filtrada$GRUPO_ETARIO)  # Posneonato
Mon�xido_filtrada$GRUPO_ETARIO  <- gsub("Mayores de 65 a\xf1os", "65+", Mon�xido_filtrada$GRUPO_ETARIO)  # Mayores de 65 a�os
Mon�xido_filtrada$GRUPO_ETARIO  <- gsub("De (\\d+) a (\\d+) meses", "\\1-\\2m", Mon�xido_filtrada$GRUPO_ETARIO)  # De 13 a 24 meses
table(Mon�xido_filtrada$GRUPO_ETARIO)#no se arregl� posneonato
Mon�xido_filtrada$GRUPO_ETARIO <- gsub("Posneonato \\(29 hasta 365 d\xcdas\\)", "Posneonato", Mon�xido_filtrada$GRUPO_ETARIO, fixed = TRUE)
table(Mon�xido_filtrada$GRUPO_ETARIO)
#no puedo resolver la sintaxis de "Posneonato", voy a crear mi propia columna de grupo etario####
Mon�xido_filtrada$GRUPO_DE_EDAD <- cut(Mon�xido_filtrada$EDAD_DIAGNOSTICO,breaks = c(seq(from=-1,to=100, by= 10)))
levels(Mon�xido_filtrada$GRUPO_DE_EDAD) <- c("0-9","10-19","20-29","30-39","49-49","50-59","60-69","70-79","79-89","90+")
table(Mon�xido_filtrada$GRUPO_DE_EDAD)                                       
#ahora s� grafico grupo etario####
barplot((table(Mon�xido_filtrada$GRUPO_DE_EDAD)), 
        main = "Casos seg�n grupo etario",  
        xlab = "Grupo etario (a�os)",             
        ylab = "Casos",
        col = c("orange", "red","yellow","lightgreen","lightblue","violet","purple","pink","green","blue"),  
        border = "black",         
        ylim = c(0, (max(table(Mon�xido_filtrada$GRUPO_DE_EDAD)))+1),
        #xlim = c(0,10),
        #horiz = TRUE,
        las=1,
        cex.names = .9
)

#A ver qu� m�s hay ####
names(Mon�xido_filtrada)
table(FALLECIDO)#hubo 5 fallecidos
Mon�xido_filtrada[(Mon�xido_filtrada$FALLECIDO=="SI"),8]#edad de los fallecidos: 4, 39, 22, 54 y 7 a�os
table(CLASIFICACION_MANUAL)#49 casos sospechosos, 460 confirmados
table(Mon�xido_filtrada[Mon�xido_filtrada$ANIO_EPI_APERTURA==2024,7]);table(Mon�xido_filtrada[Mon�xido_filtrada$ANIO_EPI_APERTURA==2023,7])
#En 2024, 33 sospechosos y 245 confirmados; en 2023, 15 sospechosos y 210 confirmados
#�Descartar sospechosos?
