#Funciones:
#Vectores####
#Vectores numéricos####
#c: concatenar, crear un vector
#rep: replicar, repite valores
#seq: crea una secuencia de números; argumentos: from, to y by
#x[i]: devuelve un "subscript" de x: el valor que ocupa la posición i; puede obtenerse un vector, ej: x[c(i,j,k)
  #también se puede aplicar una función, por ejemplo k[r/2 == trunc(r/2)] devuelve sólo valores pares del vector r
#trunc: truncar, remover los decimales
#!=: =/=
#sort: ordena los elementos de un vector
#subset: devuelve un "subscript" de un vector que coincida con una condición lógica
#summary: devuelve estadísticas descriptivas de un vector de números
#sum: suma los valores que componen un vector numérico
#length: cantidad de elementos de un vector
# mean: media de un vector
#sd: DS 
#var: varianza 
#quantile: para determinar cuantiles (x,.n)

#Vectores no-numéricos####
#as.factor: sirve para coercionar un vector numérico a factor (ej: sexo 1 y 2)
#levels: para crear un vector para asignar etiquetas a los niveles de otro vector de factor

#Para crear rangos a partir de los elementos de un vector####
#cut: permite generar un vector tipo factor para establecer rangos, ej x <-cut (y, breaks=c(1,3,6,9). Los valores consignados son incluidos en el intervalo inferior. En el ejemplo, (0,1],(1,3],(3,6], (6,9]; donde el ( excluye y el [ incluye el valor adyacente.
#levels: permite etiquetas a los elementos de un vector de factor (en general a partir de otro vector), LO QUE MODIFICA EL VECTOR.
#table y summary se pueden utilizar para conocer cuántos elementos de cada tipo tiene un vector de ch 
#na.rm: "remueve" los NA. Es un ARGUMENTO interno, se usa dentro de una función -ej: mean(x, na.rm=TRUE)-
#na.omit: omite los NA. Es una función independiente, no se usa dentro de una. Ej: length(na.omit(x))
#ARRAYS####
#dim: sirve para conocer o fijar las dimensiones de un elemento; permite "plegar" un vector para construir un array; un array puede tener más de dos dimensiones
#[]: en un array, se pueden extraer celdas, columnas, filas y sub-arrays. SE DENOMINA 1RO LA FILA Y LUEGO LA COLUMNA.
#ej: [,2] todas las filas de la 2da columna; [3,2:4] segunda a cuarta columna de la 3ra fila
#colbind: vincula columnas para formar un array
#rbind: para vincular filas. IMPORTANTE: si construyo array por filas, NOMBRO LAS COLUMNAS, y visceversa.  Row.fruit <- rbind(fruits, fruits2); colnames(Col.fruit) <- c("orange","banana","durian","mango");Row.fruit
#t: transponer en un array filas y columnas 
#Tablas####
#table crea una tabla tipo 2xn. 
#tapply crea una tabla pero opera como una matriz, y se le puede indicar que aplique determinada función
#ej: tapply(visits, list(Sex=sex, Age=age), FUN=sum), tras sex <- c(1,2,2,1,2,2) ;age <- c(1,1,1,2,2,1) ;visits <- c(1,2,3,4,5,6)
#summary para un array tipo table produce una prueba chi cuadrado de indepencia
#para un array tipo no table, produce estadísticas descriptivas de cada columna
#fisher.test: produce una prueba exacta de Fisher
#listas####
#list: w <-  list(a=x, b=y, c=z). 
#rm: remover, remueve o elimina objetos; requiere de una lista, ej: rm(list=c("x", "y")), aunque se puede usar sin ella, ej: rm(x);rm(y)
#ls: muestra una lista de objetos del ambiente global o espacio de trabajo
#rm(list=ls()) limpia el ambiente global
#qqnorm: hace un plot con cuantiles de una muestra
#DataFrames####
#read.csv permite importar texto como data.frame. ej: x <- read.csv("x.csv",as.is=TRUE); donde "as.is" indica que los caracteres se importan como están; caso contrario, se los coerciona a factores
#data.entry también permite incoporar datos, lo mismo read.dta (Stata), read.epiiinfo, etc.
#data() muestra los datasets preexistentes con fines didácticos
#names: nombres de las variables, en orden, de un dataframe
#str: muestra la estructura de un objeto
#summ: epicalc y epiDisplay, análoga a summary
#extraer un subset de un dataframe: [f,c], ej: [,5] para seleccionar toda la quinta columna
#subset: permite extraer un subconjunto, similar a [] en resultado. Ej:subset(Familydata,sex=="M"&age<58&ht>170,select = c(ht,wt)) 
#transform: permite añadir columnas a un dataframe. Ej: Familydata <- transform(Familydata, log10money=log10(money))
#otra opción es añadir la columna directamente:  Familydata$log10money <- log10(Familydata$money) 
#NULL: se puede usar para eliminar una columna de un dataframe, ej:Familydata$log10money <- NULL
#zap: función de epicalc, borra todo el ambiente global, ej: zap(). 'zap()' is a combination of 'detachAllData()' and removal of non-function objects in the R workspace. At the commencement of a new session, 'zap()' can be quite useful to clean the objects left over from previous R sessions and detach from any unwanted data frames.
#attach: carga un objeto en la búsqueda global, cosa que se puede constatar usando luego la función search(). Ej: attach(Familydata). Vuelve accesibles las variables que están en el objeto sin tener que buscarlas anteponiendo $ . Es similar a cargar un paquete con la función library ()
#detach: anula attach y library. Ej: detach("package:epicalc"), detach(Familydata)
#use: carga un objeto en la búsqueda global de manera que no se duplique; es una función de epicalc; el objeto aparece como ".data" en la búsqueda global. The advantage of use() is not only that it saves time by making attach and detach unnecessary, but .data is placed in the search path as well as being made the default data frame. Thus des() is the same as des(.data), summ() is equivalent to summ(.data). All other data frames will be detached, unless the argument 'clear=FALSE' is specified in the use function.
#ls: muestra los objetos del ambiente global, pero no los objetos ocultos; para ello, ls(all=TRUE)
#codebook: es una función tipo summary pero más informativa para factors
#[::]: Permite emplear una función enmascarada por otra de otro paquete. Ej: epiDisplay::codebook() permite usar la función codebook de epiDisplay aún si está cargado epicalc que la enmascara
#tab1: es otra función tipo summary, buena para recuentos (objetos tipo factor)