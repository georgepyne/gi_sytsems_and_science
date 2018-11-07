library(tidyverse) # 
LondonData <- read_csv("https://files.datapress.com/london/dataset/ward-profiles-and-atlas/2015-09-24T14:21:24/ward-profiles-excel-version.csv", na = "n/a")
class(LondonData)
datatypelist <- data.frame(cbind(lapply(LondonData,class)))
# datatypelist # Shows column value tyoes e.g. numeric
LondonData <- edit(LondonData)
#LondonData
names(LondonData) # Coluumn headers
LondonBoroughs<-LondonData[626:658,] #Create a subset
#LondonBoroughs

# Advanced subsetting by regular expression

LondonData <- data.frame(LondonData)
LondonBoroughs <- LondonData[grep("^E09",LondonData[,3]),]
#head(LondonBoroughs)


names(LondonBoroughs)[1] <- c("Borough Name") #rename the column 1 in LondonBoroughs
library(plotly)


install.packages("maptools")
install.packages("RJSONIO")
install.packages("httr")
install.packages("OpenStreetMap")

library(plotly)
library(maptools)
library(RColorBrewer)
library(classInt)
library(OpenStreetMap)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
library(methods)
library(OpenStreetMap)

tmap_mode("plot")


#EW <- geojson_read("http://geoportal.statistics.gov.uk/datasets/8edafbe3276d4b56aec60991cbddda50_2.geojson", what = "sp")
#LondonMap <- EW[grep("^E09",EW@data$lad15cd),]
#plot it using the base plot function
#qtm(LondonMap)

BoroughMapSF <-read_shape("/Users/GeorgePyne/Documents/CASA/GI Systems and Science/england_lad_2011Polygon.shp", as.sf = TRUE)
#qtm(BoroughMapSF, fill = "AvPTAI2015")



london_osm <- read_osm(BoroughMapSF, type = "esri", zoom = NULL)
qtm(london_osm) + 
  tm_shape(BoroughMapSF) + 
  tm_polygons("AvPTAI2015", 
              style="jenks",
              palette="YlOrBr",
              midpoint=NA,
              title="Average PTAL Rate",
              alpha = 0.5) + 
  tm_compass(position = c("left", "bottom"),type = "arrow") + 
  tm_scale_bar(position = c("left", "bottom")) +
  tm_layout(title = "PTAL Levels", legend.position = c("right", "bottom"))



