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

