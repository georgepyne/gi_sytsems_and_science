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
install.packages("shinyjs")

library(shinyjs)
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

shp_link <- "/Users/GeorgePyne/Documents/CASA/GI Systems and Science/assignment_1/neighbourhoods_planning_areas_wgs84/Toronto_Equity.shp"

#EW <- geojson_read("http://geoportal.statistics.gov.uk/datasets/8edafbe3276d4b56aec60991cbddda50_2.geojson", what = "sp")
#LondonMap <- EW[grep("^E09",EW@data$lad15cd),]
#plot it using the base plot function
#qtm(LondonMap)

BoroughMapSF <-read_shape(shp_link, as.sf = TRUE)
#qtm(BoroughMapSF, fill = "AvPTAI2015")



london_osm <- read_osm(BoroughMapSF, type = "esri", zoom = NULL)
qtm(london_osm) + 
  tm_shape(BoroughMapSF) + 
  tm_polygons("Equity Sco", 
              style="jenks",
              palette="YlOrBr",
              midpoint=NA,
              title="Equity Score",
              alpha = 0.5) + 
  tm_compass(position = c("left", "bottom"),type = "arrow") + 
  tm_scale_bar(position = c("left", "bottom")) +
  tm_layout(title = "Equity Score", legend.position = c("right", "bottom"))




#INTERACTIVE MAPS

library(shinyjs)
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

BoroughMapSF <-read_shape(shp_link, as.sf = TRUE)

#it's possible to explicitly tell R which package to get the function from with the :: operator...
#tmaptools::palette_explorer()
tmap_mode("view")

tm_shape(BoroughMapSF) +
  tm_polygons("Equity Sco",
              style="jenks",
              palette="cividis",
              midpoint=NA,
              title="PTAL Levels")

# LEAFLET MAPS

install.packages("leaflet")
install.packages("maptools")
install.packages("RJSONIO")
install.packages("httr")
install.packages("OpenStreetMap")
install.packages("shinyjs")
install.packages("plotly")
install.packages("tmaptools")

library(leaflet)
library(shinyjs)
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

BoroughMapSF <-read_shape(shp_link, as.sf = TRUE)

BoroughDataMapSP <- BoroughMapSF %>%
  st_transform(crs = 4326) %>%
  as("Spatial")

#create a colour palette using colorBin colour mapping
pal <- colorBin(palette = "cividis", 
                domain = BoroughDataMapSP$Claimant.AvPTAI2015.,
                #create bins using the breaks object from earlier
                bins = breaks)
# now, add some polygons colour them using your colour palette, #overlay the, on top of a nice backdrop and add a legend. Note the #use of the magrittr pipe operator (%>%) – check the documentation #to understand how this is working…
leaflet(BoroughDataMapSP) %>%
  addPolygons(stroke = FALSE, 
              fillOpacity = 0.5, 
              smoothFactor = 0.5,
              color = ~pal(Claimant.Rate.of.Housing.Benefit..2015.),
              popup = ~name
  ) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addLegend("bottomright", 
            pal= pal, 
            values = ~Claimant.Rate.of.Housing.Benefit..2015., 
            title = "PTAL", 
            labFormat = labelFormat(prefix = "Per 1,000 people "),
            opacity = 1
  )

install.packages("sp")
install.packages("units", type='binary')
install.packages("shinyjs")
install.packages("plotly")
install.packages("maptools")
install.packages("RColorBrewer")
install.packages("classInt")
install.packages("OpenStreetMap")
install.packages("sp")
install.packages("rgeos")
install.packages("tmap")
install.packages("tmaptools")
install.packages("sf")
install.packages("rgdal")
install.packages("geojsonio")
install.packages("methods")
install.packages("OpenStreetMap")

library(tmap)
