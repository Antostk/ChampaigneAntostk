#data transformation

library(jsonlite)
library(usethis)

weather_raw <- fromJSON("data-raw/weather_full.json", simplifyVector = FALSE)

# Extract list of cities with main weather parameters
city_weather_list <- list()
for (city_name in names(weather_raw)) {
  cdat <- weather_raw[[city_name]]
  if (!is.null(cdat$main)) {
    city_weather_list[[city_name]] <- list(
      temperature = as.numeric(cdat$main$temp),
      humidity = as.numeric(cdat$main$humidity),
      pressure = as.numeric(cdat$main$pressure)
    )
  }
}

use_data(city_weather_list, overwrite = TRUE)
