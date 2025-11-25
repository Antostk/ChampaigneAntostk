#test radius function


test_that("S function returns correct values", {
  # Test boundary values
  expect_equal(S(0), 0)
  expect_equal(S(1), 1)

  # Test intermediate values
  expect_equal(S(0.5), 0.5)
  expect_true(S(0.25) > 0)
  expect_true(S(0.75) < 1)

  # Test vector input
  expect_length(S(c(0, 0.5, 1)), 3)
})

test_that("r_scalar returns correct radius values for different regions", {
  # Test foot region
  expect_equal(r_scalar(0.5, 1, 2, 8, 12, 3, 0.4, 3.5, 4), 3)

  # Test stem region
  expect_equal(r_scalar(1.5, 1, 2, 8, 12, 3, 0.4, 3.5, 4), 0.4)

  # Test outside boundaries
  expect_equal(r_scalar(-1, 1, 2, 8, 12, 3, 0.4, 3.5, 4), 0)
  expect_equal(r_scalar(15, 1, 2, 8, 12, 3, 0.4, 3.5, 4), 0)
})

test_that("r_scalar returns non-negative values", {
  radius <- r_scalar(5, 1, 2, 8, 12, 3, 0.4, 3.5, 4)
  expect_gte(radius, 0)
})

test_that("r_vec_for_integrate handles vector input correctly", {
  t_values <- c(0.5, 1.5, 5, 10)
  radii <- r_vec_for_integrate(t_values, 1, 2, 8, 12, 3, 0.4, 3.5, 4)

  expect_length(radii, length(t_values))
  expect_true(all(radii >= 0))
  expect_type(radii, "double")
})
