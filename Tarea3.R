library(ggplot2)
library(tidyverse) # BASICAMENTE SQL CON SUS SELECT LOCOS

ruta_csv_1 <- file.choose()
ruta_csv_2 <- file.choose()

dataR <- read.csv(ruta_csv_1,sep=";",header = TRUE)
dataW <- read.csv(ruta_csv_2,sep=";",header = TRUE)
# Analisis de los Datos
head(dataR)
summary(dataR)
dim(dataR)
apply(X = dataR, MARGIN = 2,FUN  = mean)
apply(X = dataR, MARGIN = 2,FUN  = var)

# Analisis de los Datos
head(dataW)
summary(dataW)
dim(dataW)
apply(X = dataW, MARGIN = 2,FUN  = mean)
apply(X = dataW, MARGIN = 2,FUN  = var)

#-------------------------------------------------------------------------------
#                     ANALISIS DE COMPONENTES PRINCIPALES
#-------------------------------------------------------------------------------
pcaR <- prcomp(dataR, scale = TRUE)
pcaW <- prcomp(dataW, scale = TRUE)

pcaR$center
pcaR$scale
pcaW$center
pcaW$scale

# COmponentes----------
# corresponde el min(n-1, p)
# primer componente es el primer eigenvector
pcaR$rotation
pcaW$rotation

# prcom calcula automaticamente el valores de los
# componente p´rincipales para cada observacion
head(pcaR$x)
head(pcaW$x)

# Varianzas
pcaR$sdev^2
pcaW$sdev^2

# Grafico 
# cex = tamaño de las letras de los nombres
biplot(x=pcaR, scale = 0, cex = 0.7, col= c("blue3", "red"))
x11()
biplot(x=pcaW, scale = 0, cex = 0.7, col= c("blue3", "red"))

#-------------------------------------------------------------------------------
#                             Normalizacion
#-------------------------------------------------------------------------------

# Data con todas las columnas
#datos = data %>%
#select(fixed.acidity, volatile.acidity, citric.acid, residual.sugar,
#chlorides, free.sulfur.dioxide, total.sulfur.dioxide, density, pH,
#sulphates, alcohol, quality)
#summary(datos)

datosR = dataR %>% select(fixed.acidity, citric.acid, residual.sugar, chlorides, 
                          free.sulfur.dioxide, total.sulfur.dioxide, sulphates) 
                          #alcohol, pH, quality, density, volatile.acidity, 
datosW = dataW %>% select(fixed.acidity, citric.acid, residual.sugar, chlorides, 
                          free.sulfur.dioxide, total.sulfur.dioxide, sulphates) 
                          #alcohol, pH, quality, density, volatile.acidity, 

str(datosR)
summary(datosR)

#-------------------------------------------------------------------------------
#                             Regreción Lineal
#-------------------------------------------------------------------------------

RegLog <-function(x){
  valor <- log2(x+1)
}
datosR <- RegLog(datosR)
datosW <- RegLog(datosW)

#-------------------------------------------------------------------------------
#                             Varianza graficada
#-------------------------------------------------------------------------------
pcaR <- prcomp(datos, scale = TRUE)
names(pcaR)
pcaR$center
pcaR$scale

# Componentes----------
pcaR$rotation
head(pcaR$x)
# Proporción respeco al total
# Varianza
pcaR$sdev^2
prop_varianzaR <- pcaR$sdev^2/sum(pcaR$sdev^2)
x11()
ggplot(data = data.frame(prop_varianzaR, pc = 1:4),
       aes(x = pc, y =prop_varianzaR)) +
       geom_col(width = 0.3) + scale_y_continuous(limits = c(0, 1)) +
       theme_bw() + labs(x = "Componente principal", y = "Proporción de varianza
       explicada")


#-------------------------------------------------------------------------------
#                         Jerarquico Aglomerado
#-------------------------------------------------------------------------------

# VINOS ROJOS----------------------------
datosR_F <- datosR %>% select(fixed.acidity,citric.acid)
distanciasR <- dist(datosR_F,method = "euclidian")
hcR <- hclust(distanciasR,"complete")
plot(hcR, cex = 0.7, hang = -1,main = "Fixed acidity vs Citrid acid")
rect.hclust(hcR, 3, border = 1:4)

x11()
datosR_F2 <- datosR %>% select(free.sulfur.dioxide,total.sulfur.dioxide)
distanciasR_F2 <- dist(datosR_F2,method = "euclidian")
hcR_F2 <- hclust(distanciasR_F2,"complete")
plot(hcR_F2, cex = 0.7, hang = -1,main = "chlorides vs free.sulfur.dioxide")
rect.hclust(hcR_F2, 3, border = 1:4)

# VINOS BLANCOS----------------------------
datosW_F <- datosW %>% select(residual.sugar,citric.acid)
distanciasW <- dist(datosW_F,method = "euclidian")
hcW <- hclust(distanciasW,"complete")
plot(hcW, cex = 0.7, hang = -1,main = "Fixed acidity vs Citrid acid")
rect.hclust(hcW, 3, border = 1:4)

x11()
datosW_F2 <- datosW %>% select(free.sulfur.dioxide,total.sulfur.dioxide)
distanciasW_F2 <- dist(datosW_F2,method = "euclidian")
hcW_F2 <- hclust(distanciasW_F2,"complete")
plot(hcW_F2, cex = 0.7, hang = -1,main = "chlorides vs free.sulfur.dioxide")
rect.hclust(hcW_F2, 3, border = 1:4)


