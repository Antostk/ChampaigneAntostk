##GlassProfile constructor + radius_cone() & volume_between()

#this will contain glass profile, radius cone, volume between

#' @title Profile_Class

#' Stores geometric parameters describing a champagne glass.
#'
#' @export
GlassProfile <- function(a, b, x_1, x_2, x_3, x_4,
                         r_foot, r_stem, r_bowl, r_rim) {
  structure(
    list(
      a = a, b = b,
      x1 = x_1, x2 = x_2, x3 = x_3, x4 = x_4,
      r_foot = r_foot, r_stem = r_stem,
      r_bowl = r_bowl, r_rim = r_rim
    ),
    class = "Glass_Profile"
  )
}

#' Generic radius method
#' @export
radius_cone <- function(x, ...) UseMethod("radius_cone")

#' Radius method for Glass_Profile
#' @export
radius_cone.Glass_Profile <- function(x, t) {
  r_scalar(t,
           x1 = x$x1, x2 = x$x2, x3 = x$x3, x4 = x$x4,
           r_foot = x$r_foot, r_stem = x$r_stem,
           r_bowl = x$r_bowl, r_rim = x$r_rim)
}

#' Generic volume method
#' @export
volume_between <- function(x, ...) UseMethod("volume_between")

#' Volume between heights a and b for a glass
#'
#' @export
volume_between.Glass_Profile <- function(x) {
  integrand <- function(t) {
    radii <- r_vec_for_integrate(
      t,
      x1 = x$x1, x2 = x$x2, x3 = x$x3, x4 = x$x4,
      r_foot = x$r_foot, r_stem = x$r_stem,
      r_bowl = x$r_bowl, r_rim = x$r_rim
    )
    pi * radii^2
  }

  result <- integrate(integrand, lower = x$a, upper = x$b)
  result$value
}


##test

test_that("GlassProfile creates valid object", {
  glass <- GlassProfile(
    a = 2.0, b = 10.0,
    x_1 = 1.0, x_2 = 2.0, x_3 = 8.0, x_4 = 12.0,
    r_foot = 3.0, r_stem = 0.4, r_bowl = 3.5, r_rim = 4.0
  )

  expect_s3_class(glass, "Glass_Profile")
  expect_named(glass, c("a", "b", "x1", "x2", "x3", "x4",
                        "r_foot", "r_stem", "r_bowl", "r_rim"))
})

test_that("radius_cone returns non-negative values", {
  glass <- GlassProfile(
    a = 2.0, b = 10.0,
    x_1 = 1.0, x_2 = 2.0, x_3 = 8.0, x_4 = 12.0,
    r_foot = 3.0, r_stem = 0.4, r_bowl = 3.5, r_rim = 4.0
  )

  radius <- radius_cone(glass, t = 5.0)
  expect_gte(radius, 0)
})

test_that("volume_between returns positive volume", {
  glass <- GlassProfile(
    a = 2.0, b = 10.0,
    x_1 = 1.0, x_2 = 2.0, x_3 = 8.0, x_4 = 12.0,
    r_foot = 3.0, r_stem = 0.4, r_bowl = 3.5, r_rim = 4.0
  )

  volume <- volume_between(glass)
  expect_gt(volume, 0)
})
