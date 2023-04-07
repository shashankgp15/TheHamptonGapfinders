## Pulling Income 

## Importing libraries ============

library(dplyr)
library(tidycensus)
library(stringr)
library(sf)
library(ggplot2)
options(scipen=999)

## Setting needed parameters ======================

years <- 2014:2020
state <- "VA"

## Output file names =======================

dataDirectory <- "Pulling Data/Income/data/"

fileOutput <- paste0("va_cttr_2014_2020_income")

county_fips <- c(550, 620, 650, 700, 710, 735, 740, 800, 810,
                 830, 073, 093, 095, 115, 175, 199)

## Exploring what id's to pull ======

variables <- tidycensus::load_variables(year = 2014, dataset = "acs5/subject", cache = TRUE) # loads what variables exist for this year
View(variables) # using this and https://data.census.gov/ I know that I need to pull data from the table S1901

## Pulling the data =================

    ### Median Income ======================
    # S1901_C01_012 --- Households!!Estimate!!Median income (dollars)
income <- NULL
for (year in years) {
  temp <- get_acs(county = county_fips, state = "VA", 
                  geography = "county",
                  variables = "S1901_C01_012", 
                  year = year, geometry = TRUE,) %>% mutate(year = year)
  income <- rbind(income, temp)
}

## Save the data ============================

write.csv(st_drop_geometry(income), file=paste0(dataDirectory, fileOutput, ".csv"))
st_write(obj = income, dsn = paste0(dataDirectory, fileOutput, ".shp"), delete_dsn = TRUE)



my.gp <- ggplot() + 
  geom_sf(data = income[year=="2020",], aes(fill = estimate)) +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5)) + 
  ggtitle("Differences in Income Throughout Hampton Region in 2020") + 
  scale_fill_continuous(name = "Income ($)\n")
print(my.gp)


#ggsave(plot = my.gp, path = "~/desktop", filename = "incomePlot", width = 1280, height = 960, units = "px", device = "png", dpi=300)
png(filename = "incomePlot.png", width = 640, height = 480, res = 300, bg = "transparent")











