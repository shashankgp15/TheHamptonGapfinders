library(tidyverse)
library(tidycensus)
foodAccess <- read_xlsx("FoodAccessResearchAtlasData2015.xlsx", sheet = 2)

vaFoodAccess <- FoodAccess %>% filter(State == "Virginia")
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

vaCoFoodAccess <- vaFoodAccess %>% filter(County %in% counties)

#<!----------------------------------------------------------------->
#<!----------------- Getting Hyesoo's Variables--------------------->
#<!----------------------------------------------------------------->

# setwd("TheHamptonGapfinders/CURR_Work/Pulling Data/FoodAtlas")

my.df <- read.csv("countyAtlasData.csv")

string <- "CensusTract
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

string.split <- unlist(strsplit(string, "\n"))

new.df <- my.df %>% select(string.split)

write.csv(x = new.df, "FIN_Atlas_CountyData.csv")


county_fips <- c(550, 620, 650, 700, 710, 735, 740, 800, 810,
                 830, 073, 093, 095, 115, 175, 199)
temp <- get_acs(county = county_fips, state = "VA", 
                geography = "tract",
                variables = "S1901_C01_012", 
                year = 2015, geometry = TRUE,)

