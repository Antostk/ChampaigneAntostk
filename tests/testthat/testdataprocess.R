#test for data processing

test_that("processed_data exists and has correct structure", {
  # Load the data
  data("processed_data")

  expect_s3_class(processed_data, "data.frame")
  expect_named(processed_data, c("city", "temperature", "humidity", "pressure"))
  expect_true(nrow(processed_data) > 0)
})

test_that("processed_data has valid values", {
  data("processed_data")

  # Check data types
  expect_type(processed_data$city, "character")
  expect_type(processed_data$temperature, "double")
  expect_type(processed_data$humidity, "double")
  expect_type(processed_data$pressure, "double")

  # Check value ranges (typical weather values)
  expect_true(all(processed_data$temperature >= -50 & processed_data$temperature <= 50))
  expect_true(all(processed_data$humidity >= 0 & processed_data$humidity <= 100))
  expect_true(all(processed_data$pressure >= 800 & processed_data$pressure <= 1100))
})

test_that("processed_data has no missing values", {
  data("processed_data")

  expect_true(all(complete.cases(processed_data)))
})
