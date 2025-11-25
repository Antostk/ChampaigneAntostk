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


##test


test_that("CityWeather creates valid object", {
  weather <- CityWeather("Bern", 14.2, 65, 1012)

  expect_s3_class(weather, "City_Weather")
  expect_equal(weather$city, "Bern")
  expect_equal(weather$temperature, 14.2)
  expect_equal(weather$humidity, 65)
  expect_equal(weather$pressure, 1012)
})

test_that("expected_lambda returns finite value", {
  weather <- CityWeather("Bern", 14.2, 65, 1012)
  lambda <- expected_lambda(weather)

  expect_true(is.finite(lambda))
  expect_gt(lambda, 0)
})

test_that("expected_lambda handles missing data", {
  weather <- CityWeather("Test", NULL, 65, 1012)
  lambda <- expected_lambda(weather)

  expect_true(is.na(lambda))
})
