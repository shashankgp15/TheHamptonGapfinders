#!<------------------------------------------------>
#!<--------- Packages & Data Imports -------------->
#!<------------------------------------------------>
library(sf)
library(ggplot2)
library(leaflet)
library(tidyverse)
library(tidycensus)
library(htmltools)

data <- read_sf(dsn = "Distribution/masterData.shp")
countyOutline <- read_sf(dsn = "Distribution/countyOutlines.shp")
data15 <- data %>% filter(year == 2015)
data19 <- data %>% filter(year == 2019)
foodBanks <- read_csv("../GoogleMapsPlaces/FoodBanks.csv", skip_empty_rows = TRUE)


#!<------------------------------------------------>
#!<------------ HTML testings --------------------->
#!<------------------------------------------------>





#!<------------------------------------------------>
#!<-------------- Playground ---------------------->
#!<------------------------------------------------>


map <- leaflet(data=foodBanks) %>% addTiles() %>%
  addMarkers(~lng, ~lat, popup=~name) %>%
  addPolylines(data = countyOutline, color = "black", weight = 1.2, smoothFactor = .5,
               fillOpacity = 0, fillColor = "transparent")














pal1 <- colorNumeric(palette = "magma", 
                    domain = as.double(data19$lsnphlfs), reverse = TRUE)

map1 <- leaflet(data19) %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(color = ~pal1(as.double(lsnphlfs)), weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.9,
              highlightOptions = highlightOptions(color = "black", weight = 2,
                                                  bringToFront = TRUE, sendToBack = TRUE),
              label = round(as.double(data19$lsnphlfs), 2)) %>%
  addPolylines(data = countyOutline, color = "black", weight = 1.2, smoothFactor = .5,
              fillOpacity = 0, fillColor = "transparent") %>%
  addLegend(position = "topright", pal = pal1, values = as.double(data19$lsnphlfs), opacity = .9, title = "Population")
  
map1


x <- as.double(data19$lblck1s)
y <- as.double(data19$TrctBlc)

plot(x, y)




pal1 <- colorNumeric(palette = "magma", 
                     domain = as.double(data19$lblckhlfs), reverse = TRUE)

map1 <- leaflet(data19) %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(color = ~pal1(as.double(lblckhlfs)), weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.9,
              highlightOptions = highlightOptions(color = "black", weight = 2,
                                                  bringToFront = TRUE, sendToBack = TRUE),
              label = round(as.double(data19$lblckhlfs), 2)) %>%
  addPolylines(data = countyOutline, color = "black", weight = 1.2, smoothFactor = .5,
               fillOpacity = 0, fillColor = "transparent") %>%
  addLegend(position = "topright", pal = pal1, values = as.double(data19$lblckhlfs), opacity = .9, title = "Population")

map1





variable2 <- "LILAT_V"
pal2 <- colorNumeric(palette = "magma", 
                    domain = st_drop_geometry(data15[,variable2]), reverse = TRUE)

map2 <- leaflet(data15) %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(fillColor = ~pal2(LILAT_V), weight = 1, smoothFactor = 0.5, stroke = TRUE,
              opacity = 1.0, fillOpacity = 0.9,
              label = round(data15$LILAT_V, 2)) %>%


map2





















#leafletPlot.func(data15, "PvrtyRt")

































#!<------------------------------------------------>
#!<--------------- Functions ---------------------->
#!<------------------------------------------------>

leafletPlot.func <- function(sourceData, var){
  data <- st_drop_geometry(sourceData[,var])
  pal <- colorNumeric(palette = "Blues", 
                      domain = data)
  
  map <- leaflet(sourceData) %>% 
    addProviderTiles("CartoDB.Positron") %>% 
    addPolygons(color = ~pal(data), weight = 1, smoothFactor = 0.5,
                opacity = 1.0, fillOpacity = 0.5,
                highlightOptions = highlightOptions(color = "white", weight = 2,
                                                    bringToFront = TRUE))
  map
}
  
  
  
  
  
  
  
  
  
  
  















