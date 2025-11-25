#test expected lambda (attendance)

test_that("expected_lambda returns positive finite values", {
  weather <- CityWeather("Bern", 14.2, 65, 1012)
  lambda <- expected_lambda(weather)

  expect_gt(lambda, 0)
  expect_true(is.finite(lambda))
  expect_type(lambda, "double")
})

test_that("expected_lambda handles missing data", {
  weather_missing <- CityWeather("Test", NULL, 65, 1012)
  lambda <- expected_lambda(weather_missing)

  expect_true(is.na(lambda))
})

test_that("expected_lambda responds to weather changes", {
  # Better weather should give higher lambda
  good_weather <- CityWeather("Test", 25, 50, 1015)  # Warm, dry
  bad_weather <- CityWeather("Test", 10, 90, 1000)   # Cold, humid

  lambda_good <- expected_lambda(good_weather)
  lambda_bad <- expected_lambda(bad_weather)

  expect_gt(lambda_good, lambda_bad)
})

test_that("expected_lambda formula is correct", {
  # Test with known values to verify the formula
  weather <- CityWeather("Test", 20, 50, 1000)
  lambda <- expected_lambda(weather)

  # Manual calculation of the formula
  manual_lambda <- exp(0.5 + 0.5*20 - 3*(50/100) + 0.001*1000)

  expect_equal(lambda, manual_lambda)
})
