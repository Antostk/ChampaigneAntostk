#' @title City_Weather_Class
#' @description Stores weather information for a given city.
#'
#' @param city City name
#' @param temperature Temperature in °C
#' @param humidity Humidity in percentage
#' @param pressure Pressure in hPa
#'
#' @return City_Weather object
#' @export
CityWeather <- function(city, temperature, humidity, pressure) {
  structure(
    list(
      city = city,
      temperature = temperature,
      humidity = humidity,
      pressure = pressure
    ),
    class = "City_Weather"
  )
}

#' Print method for CityWeather
#' @export
print.City_Weather <- function(x, ...) {
  if (any(is.null(c(x$temperature, x$humidity, x$pressure)))) {
    cat("Weather data not available for", x$city, "\n")
  } else {
    cat("Weather for", x$city, ":\n")
    cat("  Temperature:", x$temperature, "°C\n")
    cat("  Humidity   :", x$humidity, "%\n")
    cat("  Pressure   :", x$pressure, "hPa\n")
  }
}
