#test simulation function

test_that("simulate_party returns correct structure", {
  # Create test data
  test_data <- data.frame(
    city = c("TestCity", "OtherCity"),
    temperature = c(20, 15),
    humidity = c(50, 70),
    pressure = c(1013, 1008),
    stringsAsFactors = FALSE
  )

  results <- simulate_party("TestCity", test_data, N = 10)

  expect_named(results, c("total_liters", "total_bottles", "guest_counts",
                          "expected_guests", "city"))
  expect_length(results$total_liters, 10)
  expect_length(results$total_bottles, 10)
  expect_length(results$guest_counts, 10)
  expect_equal(results$city, "TestCity")
})

test_that("simulate_party handles edge cases", {
  test_data <- data.frame(
    city = "TestCity",
    temperature = 20,
    humidity = 50,
    pressure = 1013,
    stringsAsFactors = FALSE
  )

  # Test with very small N
  results <- simulate_party("TestCity", test_data, N = 1)
  expect_length(results$total_liters, 1)

  # Test with different bottle size
  results_custom <- simulate_party("TestCity", test_data, N = 5, bottle_L = 1.0)
  expect_true(all(results_custom$total_bottles >= 0))
})

test_that("simulate_party validates inputs", {
  test_data <- data.frame(
    city = "TestCity",
    temperature = 20,
    humidity = 50,
    pressure = 1013,
    stringsAsFactors = FALSE
  )

  # Test missing city
  expect_error(simulate_party("NonExistentCity", test_data))

  # Test invalid N
  expect_error(simulate_party("TestCity", test_data, N = 0))
  expect_error(simulate_party("TestCity", test_data, N = -1))
})

test_that("simulate_party produces reasonable values", {
  test_data <- data.frame(
    city = "TestCity",
    temperature = 20,
    humidity = 50,
    pressure = 1013,
    stringsAsFactors = FALSE
  )

  results <- simulate_party("TestCity", test_data, N = 100)

  # Check that values are reasonable
  expect_true(all(results$total_liters >= 0))
  expect_true(all(results$total_bottles >= 0))
  expect_true(all(results$guest_counts >= 0))
  expect_gt(results$expected_guests, 0)
})
