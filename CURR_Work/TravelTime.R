install.packages("traveltimeR")

library(traveltimeR)

Sys.setenv(TRAVELTIME_ID = "acfb52eb")
Sys.setenv(TRAVELTIME_KEY = "eb02516c05b7d10f8e03477312b537fa")

dateTime <- strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ")

library(traveltimeR)

Sys.setenv(TRAVELTIME_ID = "YOUR_APP_ID")
Sys.setenv(TRAVELTIME_KEY = "YOUR_APP_KEY")

locations <- c(
  make_location(
    id = 'London center',
    coords = list(lat = 51.508930, lng = -0.131387)),
  make_location(
    id = 'Hyde Park',
    coords = list(lat = 51.508824, lng = -0.167093)),
  make_location(
    id = 'ZSL London Zoo',
    coords = list(lat = 51.536067, lng = -0.153596))
)

departure_search <-
  make_search(id = "departure search example",
              departure_location_id = "London center",
              arrival_location_ids = list("Hyde Park", "ZSL London Zoo"),
              departure_time = strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ"),
              properties = list("travel_time", "distance", "route"),
              transportation = list(type = "driving"))

arrival_search <-
  make_search(id = "arrival  search example",
              arrival_location_id = "London center",
              departure_location_ids = list("Hyde Park", "ZSL London Zoo"),
              arrival_time = strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ"),
              properties = list('travel_time', "distance", "route", "fares"),
              transportation = list(type = "public_transport"),
              range = list(enabled = T, width = 1800, max_results = 1))

result <-
  routes(
    departure_searches = departure_search,
    arrival_searches = arrival_search,
    locations = locations
  )

print(result)
