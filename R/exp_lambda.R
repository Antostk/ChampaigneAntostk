#expected lambda
#' @title Expected_attendance

#' @param city_weather A CityWeather object
#' @return Expected Poisson rate λ
#'
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

