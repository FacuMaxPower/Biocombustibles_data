# datos biocombustibles

library(tidyverse)
library(lubridate) 
library(tseries)
library(forecast)

setwd("C:\\Users\\Facu\\Documents\\Energía\\Hidrocarburos\\Biocombustibles")

biodiesel <- read.csv(file = "biodiesel.csv")
nom.col <- colnames(biodiesel)
nom.col[1] <- "fecha"
colnames(biodiesel) <- nom.col
biodiesel$fecha <- as.Date(biodiesel$fecha, format = "%m/%d/%Y")

ts_biodiesel <- biodiesel %>% 
  group_by(fecha) %>% 
  summarise(produccion = sum(produccion_ton, na.rm = T))

ts_biodiesel <- ts(ts_biodiesel$produccion, frequency = 12, start = c(2010, 1))

plot.ts(ts_biodiesel)

desc <- decompose(ts_biodiesel)
plot(desc)
