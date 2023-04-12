library(tidyverse)
library(readxl)
setwd("CURR_Work/Pulling Data/FoodAtlas/")
rm(list = ls())

#<!----------------------------------------------------->
#<- This block of code is just for the Prepare.R 
#<- but the rest of the file will be merging it
#<!----------------------------------------------------->

foodAccess15 <- read_xlsx("Original/FoodAccessResearchAtlasData2015.xlsx", sheet = 3) %>% mutate(year = 2015)
foodAccess19 <- read_xlsx("Original/FoodAccessResearchAtlasData2019.xlsx", sheet = 3) %>% mutate(year = 2019)

foodAccess15 <- foodAccess15 %>% rename(Pop2010 = POP2010)

masterFoodAccess <- rbind(foodAccess15, foodAccess19)

#<!----------------------------------------------------->
#<!----------------------------------------------------->


foodAccess_Va <- masterFoodAccess %>% filter(State == "Virginia")
counties <- c("Chesapeake", "Chesapeake city", 
              "Franklin city", "Franklin City", 
              "Hampton", "Hampton city",
              "Newport News", "Newport News city",
              "Norfolk", "Norfolk city",
              "Poquoson", "Poquoson city", 
              "Portsmouth", "Portsmouth city",
              "Suffolk", "Suffolk city",
              "Virginia Beach", "Virginia Beach city",
              "Williamsburg", "Williamsburg city",
              "Gloucester", "Gloucester County",
              "Isle of Wight", "Isle of Wight County",
              "James City", "James City County",
              "Mathews", "Mathews County",
              "Southampton", "Southampton County",
              "York", "York County")

foodAccess_VaTr <- foodAccess_Va %>% filter(County %in% counties)

#<!----------------------------------------------------------------->
#<!----------------- Getting Hyesoo's Variables--------------------->
#<!----------------------------------------------------------------->

desiredColumns <- "CensusTract
State
County
Urban
year
OHU2010
PCTGQTRS
LILATracts_1And10
LILATracts_halfAnd10
LILATracts_1And20
LILATracts_Vehicle
LowIncomeTracts
PovertyRate
LA1and10
LAhalfand10
LA1and20
LATracts_half
LATracts1
LATracts10
LATracts20
LATractsVehicle_20
LAPOP1_10
LAPOP05_10
LAPOP1_20
LALOWI1_10
LALOWI05_10
LALOWI1_20
lapophalf
lalowihalf
laseniorshalf
laseniorshalfshare
lablackhalf
lablackhalfshare
laasianhalfshare
lahunvhalf
lahunvhalfshare
lasnaphalf
lasnaphalfshare
lapop1
lapop1share
lalowi1
lalowi1share
laseniors1
laseniors1share
lablack1
lablack1share
lahunv1
lahunv1share
lasnap1
lasnap1share
lalowi10
lalowi10share
laseniors10
laseniors10share
lablack10
lablack10share
lahunv10
lahunv10share
lasnap10
lasnap10share
lapop20
lapop20share
lalowi20
lalowi20share
lablack20
lablack20share
lahunv20
lahunv20share
lasnap20
lasnap20share
TractLOWI
TractSeniors
TractBlack
TractHUNV"

desiredColumns <- unlist(strsplit(desiredColumns, "\n")) 

vatr_foodAccess_FIN <- foodAccess_VaTr %>% select(desiredColumns)


# write.csv(x = vatr_foodAccess_FIN, "Working/vatr_foodAccess.csv", row.names = FALSE)
# Commented out because not needed after first is saved


#<!---------------------------------------------------------------->
#< Trying to figure out how to get polygon / shape into file
#<!---------------------------------------------------------------->

rm(list = ls())
setwd("CURR_Work/Pulling Data/FoodAtlas")
library(tidyverse)
library(tidycensus)
library(sf)
library(sp)


foodAccess <- read.csv("Working/vatr_foodAccess.csv")

hamptonGeoid <- unique(substr(foodAccess$CensusTract, 1, 5))

countyOutlines <- county_laea %>% filter(GEOID %in% hamptonGeoid)

acsGeoBase <- get_acs(geography = "tract", variables = "B19013_001",
                state = "VA", geometry = TRUE, year = 2019)

useable <- acsGeoBase %>% select(GEOID, NAME, geometry)
useableHampton <- useable %>% filter(substr(GEOID, 1, 5) %in% hamptonGeoid)

geometry <- NULL
for(i in 1:nrow(foodAccess)){
  geometry <- rbind(geometry, st_as_sf(data.frame(useableHampton[useableHampton$GEOID == foodAccess$CensusTract[i], "geometry"])))
}


#<!---------------------------------------------------------------->
#< we have geometry in order, and food Access, we need to merge
#< so that foodAccess is an sf and contians MULTIPOLYGON data
#<!---------------------------------------------------------------->
foodAccess.sf <- NULL
for(i in 1:nrow(foodAccess)){
  foodAccess.sf <- rbind(foodAccess.sf, st_as_sf(merge(foodAccess[i,], geometry[i,])))
}


#<!---------------------------------------------------------------->
#<!-                      Example case                        ----->
#<!---------------------------------------------------------------->


example <- foodAccess.sf %>% select(lapophalf)
example$lapophalf <- as.double(example$lapophalf)
plot(example)



