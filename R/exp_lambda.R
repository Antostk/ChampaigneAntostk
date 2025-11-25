#' Expected attendance based on weather conditions
#'
#' @param city_weather A CityWeather object containing temperature, humidity and pressure
#' @return Expected Poisson rate λ for number of guests
#'
#' @examples
#' \dontrun{
#' weather <- CityWeather("Bern", 14.2, 65, 1012)
#' expected_lambda(weather)
#' }
#' @export
expected_lambda <- function(city_weather) {
  if (any(is.null(c(city_weather$temperature,
                    city_weather$humidity,
                    city_weather$pressure)))) {
    return(NA)
  }

  T_val <- city_weather$temperature
  H_val <- city_weather$humidity
  P_val <- city_weather$pressure

  lambda <- exp(
    0.5 +
      0.5 * T_val -
      3 * (H_val / 100) +
      0.001 * P_val
  )

  lambda
}

##test

test_that("expected_lambda returns positive value for reasonable inputs", {
  weather <- CityWeather("Test", 20, 50, 1013)
  lambda <- expected_lambda(weather)

  expect_gt(lambda, 0)
  expect_true(is.finite(lambda))
})

test_that("expected_lambda increases with temperature", {
  weather_cold <- CityWeather("Test", 10, 50, 1013)
  weather_warm <- CityWeather("Test", 25, 50, 1013)

  lambda_cold <- expected_lambda(weather_cold)
  lambda_warm <- expected_lambda(weather_warm)

  expect_gt(lambda_warm, lambda_cold)
})
