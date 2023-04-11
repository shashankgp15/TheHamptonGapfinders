library(tidyverse)
library(tidycensus)
library(readxl)
setwd("CURR_Work/Pulling Data/FoodAtlas/")

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
counties <- c("Chesapeake City", "Franklin City", "Hampton City", 
              "Newport News City", "Norfolk City", "Poquoson City",
              "Portsmouth City", "Suffolk City", "Virginia Beach City",
              "Williamsburg City", "Gloucester County", "Isle of Wight County",
              "James City County", "Mathews County", "Southampton County", "York County",
              "Chesapeake", "Franklin", "Hampton", 
              "Newport News", "Norfolk", "Poquoson",
              "Portsmouth", "Suffolk", "Virginia Beach",
              "Williamsburg", "Gloucester", "Isle of Wight",
              "James", "Mathews", "Southampton", "York")

foodAccess_VaTr <- foodAccess_Va %>% filter(County %in% counties)

#<!----------------------------------------------------------------->
#<!----------------- Getting Hyesoo's Variables--------------------->
#<!----------------------------------------------------------------->

desiredColumns <- "CensusTract
State
County
Urban
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
# strsplit searching for new line character int he string above

vatr_foodAccess_FIN <- foodAccess_VaTr %>% select(desiredColumns, -"")


# write.csv(x = vatr_foodAccess_FIN, "Working/vatr_foodAccess.csv")
# Commented out because not needed after first is saved
