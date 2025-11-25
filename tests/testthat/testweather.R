#test for weather function

test_that("CityWeather creates valid object", {
  weather <- CityWeather("Paris", 15.5, 68, 1015)

  expect_s3_class(weather, "City_Weather")
  expect_equal(weather$city, "Paris")
  expect_equal(weather$temperature, 15.5)
  expect_equal(weather$humidity, 68)
  expect_equal(weather$pressure, 1015)
})

test_that("CityWeather handles different data types", {
  weather <- CityWeather("London", 12L, 75L, 1008L)

  expect_s3_class(weather, "City_Weather")
  expect_type(weather$temperature, "double")
  expect_type(weather$humidity, "double")
  expect_type(weather$pressure, "double")
})

test_that("print.City_Weather works correctly", {
  weather <- CityWeather("Berlin", 13.8, 70, 1010)

  # Test that print doesn't throw an error
  expect_error(print(weather), NA)

  # Test with missing data
  weather_bad <- CityWeather("Test", NULL, NULL, NULL)
  expect_error(print(weather_bad), NA)
})
