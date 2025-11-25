#test for glass volume function

test_that("GlassProfile creates valid object", {
  glass <- GlassProfile(2, 10, 1, 2, 8, 12, 3, 0.4, 3.5, 4)

  expect_s3_class(glass, "Glass_Profile")
  expect_named(glass, c("a", "b", "x1", "x2", "x3", "x4",
                        "r_foot", "r_stem", "r_bowl", "r_rim"))
  expect_type(glass$a, "double")
  expect_type(glass$r_foot, "double")
})

test_that("radius_cone returns appropriate values", {
  glass <- GlassProfile(2, 10, 1, 2, 8, 12, 3, 0.4, 3.5, 4)

  radius <- radius_cone(glass, 5)
  expect_gte(radius, 0)
  expect_true(is.finite(radius))
})

test_that("volume_between returns positive volume", {
  glass <- GlassProfile(2, 10, 1, 2, 8, 12, 3, 0.4, 3.5, 4)

  volume <- volume_between(glass)
  expect_gt(volume, 0)
  expect_true(is.finite(volume))
})

test_that("volume_between handles different height intervals", {
  glass_low <- GlassProfile(2, 5, 1, 2, 8, 12, 3, 0.4, 3.5, 4)
  glass_high <- GlassProfile(8, 11, 1, 2, 8, 12, 3, 0.4, 3.5, 4)

  volume_low <- volume_between(glass_low)
  volume_high <- volume_between(glass_high)

  expect_gt(volume_high, volume_low)  # Higher region should have more volume
})
