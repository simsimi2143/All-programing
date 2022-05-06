library(tidyverse) # BASICAMENTE SQL 
library(psych)
library(dplyr)
library(skimr)
library(ggplot2)


# Leyendo el archivo con los datos
car <- read.csv("car.data",sep=",",header = TRUE)
data <- read.csv("car.data",sep=",",header = TRUE)

###################################################
################  Datos Generales  ################  
###################################################

dim(car)
colnames(car)
head(car,3)
str(car) # tipos de datos

##################################################### 
################  Ajuste de Valores  ################ 
##################################################### 

# Cambio de nombre a las columnas
colnames(car) <- c("Buying","Maint","Doors","Person",
                   "Lug_Boot","Safely","ClassValues")

# De chr a num
# Columna Buying
car$Buying[car$Buying == "low"] <- 1
car$Buying[car$Buying == "med"] <- 2
car$Buying[car$Buying == "high"] <- 3
car$Buying[car$Buying == "vhigh"] <- 4
car$Buying <- as.numeric(car$Buying)

# Columna MainM
car$Maint[car$Maint == "low"] <- 1
car$Maint[car$Maint == "med"] <- 2
car$Maint[car$Maint == "high"] <- 3
car$Maint[car$Maint == "vhigh"] <- 4
car$Maint <- as.numeric(car$Maint)


# Columna Door
car$Doors[car$Doors == "2"] <- 1
car$Doors[car$Doors == "3"] <- 2
car$Doors[car$Doors == "4"] <- 3
car$Doors[car$Doors == "5more"] <- 4
car$Doors <- as.numeric(car$Doors)

# Columna Person
car$Person[car$Person == "2"] <- 1
car$Person[car$Person == "4"] <- 2
car$Person[car$Person == "more"] <- 3
car$Person <- as.numeric(car$Person)

# Columna Lug_Boot
car$Lug_Boot[car$Lug_Boot == "small"] <- 1
car$Lug_Boot[car$Lug_Boot == "med"] <- 2
car$Lug_Boot[car$Lug_Boot == "big"] <- 3
car$Lug_Boot <- as.numeric(car$Lug_Boot)

# Columna Safely
car$Safely[car$Safely == "med"] <- 1
car$Safely[car$Safely == "high"] <- 2
car$Safely[car$Safely == "low"] <- 3
car$Safely <- as.numeric(car$Safely)

# Columna ClassValue
car$ClassValues[car$ClassValues == "unacc"] <- 1
car$ClassValues[car$ClassValues == "acc"] <- 2
car$ClassValues[car$ClassValues == "vgood"] <- 3
car$ClassValues[car$ClassValues == "good"] <- 4
car$ClassValues <- as.numeric(car$ClassValues)
car = na.omit(car) 



############################################################
################  Utilización de los Datos  ################ 
############################################################

############################################
#          Entre Doors y Person
############################################
car2 <- car %>% select(Doors,Person) 
carKm <- kmeans(car2,2)
carDP <- data.frame(car2,carKm$cluster)

distDP <- dist(carDP,method = "euclidian")
hcDP <- hclust(distDP,"complete")
plot(hcDP, cex = 0.7, hang = -1)
rect.hclust(hcDP, 2, border = 1:2)


############################################
#       Entre Buying y Person
############################################
car3 <- car %>% select(Buying,Person) 
carKm2 <- kmeans(car3,3)
carBP <- data.frame(car3,carKm2$cluster)

distBP <- dist(carBP,method = "euclidian")
hcBP <- hclust(distBP,"complete")
plot(hcBP, cex = 0.7, hang = -1)
rect.hclust(hcBP, 3, border = 1:2)

############################################
#       Normalización de datos
############################################

CarMin <- parser(data)
CarKmMin <- kmeans(CarMin, 3)
CarKmMin$size


grupos <- CarKmMin$cluster
datos <- data.frame(grupos, CarMin)
indice <- which(datos$grupos==1)
uno <- datos[indice,]
u1 = uno[-1]

indice2 <- which(datos$grupos==2)
dos <- datos[indice2,]
u2 = dos[-1]
s12 = rbind(u1,u2)


############################################
#       Graficos de Histogramas
############################################

multi.hist(x = s12,dcol = c("blue","red"),dlty = c("dotted","solid"),main = "")
multi.hist(x = u1,dcol = c("blue","red"),dlty = c("dotted","solid"),main = "")
multi.hist(x = u2,dcol = c("blue","red"),dlty =  c("dotted","solid"),main = "")

length(CarKmMin$centers)

ejex = 1:9

plot(ejex,CarKmMin$centers,main = "Numero de Centroides", type = "l",col = "blue" , lwd = 2)













