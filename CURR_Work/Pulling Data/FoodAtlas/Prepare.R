library(tidyverse)
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


