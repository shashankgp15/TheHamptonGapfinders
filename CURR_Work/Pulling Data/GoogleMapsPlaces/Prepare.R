install.packages("googleway")

library(googleway)
library(tidyverse)
library(leaflet)

key <- "AIzaSyBfcu88gynp049lJy6HRQ335-sRc_KsofI"

set_key(key)


something <- google_places(key = key, search_string = 'Food Bank', location=c(36.899761,-76.546286), radius=50000)
results <- something$results


coords1 <- c(37.446883,-76.598472)
coords2 <- c(36.754660,-77.062644)
coords3 <- c(36.807456,-76.126059)
radius <- 50000

results1 <- google_places(key = key, search_string = 'Food Bank', location=coords1, radius=radius)$results
results2 <- google_places(key = key, search_string = 'Food Bank', location=coords2, radius=radius)$results
results3 <- google_places(key = key, search_string = 'Food Bank', location=coords3, radius=radius)$results

r1lat <- results1$geometry$location$lat
r1lng <- results1$geometry$location$lng

r2lat <- results2$geometry$location$lat
r2lng <- results2$geometry$location$lng

r3lat <- results3$geometry$location$lat
r3lng <- results3$geometry$location$lng

r1 <- results1 %>% select(name, place_id, rating, formatted_address)
r1 <- r1 %>% mutate(lat = r1lat, lng = r1lng)

r2 <- results2 %>% select(name, place_id, rating, formatted_address)
r2 <- r2 %>% mutate(lat = r2lat, lng = r2lng)

r3 <- results3 %>% select(name, place_id, rating, formatted_address)
r3 <- r3 %>% mutate(lat = r3lat, lng = r3lng)

results <- distinct(rbind(r1, r2, r3))

write.csv(results, "CURR_Work/Pulling Data/GoogleMapsPlaces/FoodBanks.csv")
