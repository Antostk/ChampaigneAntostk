#simulation

#' Simulate champagne consumption for a party
#'
#' @param city_name Name of city
#' @param data Weather data list
#' @param N Number of simulation runs
#' @param seed Random seed
#' @param bottle_L Bottle capacity in liters
#'
#' @return List containing simulation outputs
#' @export
simulate_party <- function(city_name, data,
                           N = 1000, seed = 123L,
                           bottle_L = 0.75) {

  set.seed(seed)

  if (!(city_name %in% names(data))) {
    stop("City '", city_name, "' not found in dataset.")
  }

  city_data <- data[[city_name]]

  city_weather <- CityWeather(
    city = city_name,
    temperature = city_data$temperature,
    humidity = city_data$humidity,
    pressure = city_data$pressure
  )

  lambda <- expected_lambda(city_weather)

  glass <- GlassProfile(
    a = 2.0, b = 10.0,
    x_1 = 1.0, x_2 = 2.0, x_3 = 8.0, x_4 = 12.0,
    r_foot = 3.0, r_stem = 0.4,
    r_bowl = 3.5, r_rim = 4.0
  )

  total_liters <- numeric(N)
  total_bottles <- numeric(N)

  for (i in seq_len(N)) {
    G <- rpois(1, lambda)
    if (G == 0) next

    D <- rpois(G, 1.4)
    total_glasses <- sum(D)
    if (total_glasses == 0) next

    poured <- numeric(total_glasses)

    for (j in seq_len(total_glasses)) {
      fill <- runif(1, 8.0, 11.0)
      tmp <- glass
      tmp$a <- 2.0
      tmp$b <- fill
      poured[j] <- volume_between(tmp)
    }

    total_liters[i] <- sum(poured) / 1000
    total_bottles[i] <- ceiling(total_liters[i] / bottle_L)
  }

  list(
    total_liters = total_liters,
    total_bottles = total_bottles,
    expected_guests = lambda
  )
}
