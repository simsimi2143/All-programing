library(tidyverse)
library(psych)
library(dplyr)
library(skimr)
library(ggplot2)

ruta_csv <- file.choose()
data <- read.csv(ruta_csv,header = TRUE, sep = ",")

dim(data)
colnames(data)
colnames(data) <- c("buying","maint","doors","person","lug_boot","safely","classValues")
data <- na.omit(data)
descartados <- c(-2,-3,-4,-5)
data <- data[,descartados]

parser <- function(x){
  valores <- log2(x + 1)
}

unique(data$buying)
data$buying[data$buying == "vhigh"] <- 1
data$buying[data$buying == "high"] <- 2
data$buying[data$buying == "med"] <- 3
data$buying[data$buying == "low"] <- 4
data$buying <- as.numeric(data$buying)

unique(data$safely)
data$safely[data$safely == "med"] <- 1
data$safely[data$safely == "high"] <- 2
data$safely[data$safely == "low"] <- 3
data$safely <- as.numeric(data$safely)

unique(data$classValues)
data$classValues[data$classValues == "unacc"] <- 1
data$classValues[data$classValues == "acc"] <- 2
data$classValues[data$classValues == "vgood"] <- 3
data$classValues[data$classValues == "good"] <- 4
data$classValues <- as.numeric(data$classValues)

data_2 <- data %>% select(safely,classValues)
k2 <- kmeans(data_2,3)
datos <- data.frame(data_2,k2$cluster)

distancias <- dist(datos,method = "euclidian")
hc <- hclust(distancias,"complete")
hc_completo <- hclust(distancias, "complete")
plot(hc_completo, cex = 0.7, hang = -1,main = "Safely vs classValues")
rect.hclust(hc_completo, 3, border = 1:4)

data_3 <- data %>% select(buying,safely) 
k2_2 <- kmeans(data_3,3)
datos_2 <- data.frame(data_3,k2_2$cluster)

distancias_2 <- dist(datos_2,method = "euclidian")
hc_2 <- hclust(distancias_2,"complete")
hc_completo_2 <- hclust(distancias_2, "complete")
plot(hc_completo_2, cex = 0.7, hang = -1,main = "Buying vs safely")
rect.hclust(hc_completo_2, 3, border = 1:2)


#Normalización de datos

min_datos <- parser(data)
k2_3 <- kmeans(min_datos, 3)
k2_3$size

grupos <- k2_3$cluster
datos1 <- data.frame(grupos, min_datos)
indice1 <- which(datos1$grupos==1)
uno <- datos1[indice1,]
u1 = uno[-1]

indice2 <- which(datos1$grupos==2)
dos <- datos1[indice2,]
u2 = dos[-1]
s12 = rbind(u1,u2)



multi.hist(x = s12,dcol = c("blue","red"),dlty = c("dotted","solid"),main = "")

multi.hist(x = u1,dcol = c("blue","red"),dlty = c("dotted","solid"),main = "")

multi.hist(x = u2,dcol = c("blue","red"),dlty =  c("dotted","solid"),main = "")
dim(s12)

length(k2_3$centers)

ejex = 1:9

plot(ejex,k2_3$centers,main = "Numero de Centroides", type = "l",col = "blue" , lwd = 2)


