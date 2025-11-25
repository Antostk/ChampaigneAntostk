##part containing radius function


#' @title Easing_function_S(z)

#' Smooth transition function used to model glass curvature.
#'
#' @param z Scaled value between 0 and 1
#'
#' @return Numeric value of easing function
#' @export
S <- function(z) {
  0.5 - 0.5 * cos(pi * z)
}

#' Scalar radius evaluation for the glass profile
#'
#' @param t Height at which the radius is evaluated
#' @param x1,x2,x3,x4 Region boundaries
#' @param r_foot,r_stem,r_bowl,r_rim Radii in different parts
#'
#' @return Radius at height \code{t}
#' @export
r_scalar <- function(
    t, x1, x2, x3, x4,
    r_foot, r_stem, r_bowl, r_rim
) {
  if (t < 0) return(0)
  if (t > x4) return(0)

  if (t < x1) return(r_foot)
  if (t < x2) return(r_stem)

  if (t < x3) {
    z <- (t - x2) / (x3 - x2)
    return(r_stem * (1 - S(z)) + r_bowl * S(z))
  }

  if (t <= x4) {
    z <- (t - x3) / (x4 - x3)
    S2_val <- S(z)^2
    return(r_bowl * (1 - S2_val) + r_rim * S2_val)
  }

  0
}

#' Vectorized radius function
#'
#' @export
r_vec_for_integrate <- function(
    t, x1, x2, x3, x4,
    r_foot, r_stem, r_bowl, r_rim
) {
  vapply(t, r_scalar, numeric(1),
         x1 = x1, x2 = x2, x3 = x3, x4 = x4,
         r_foot = r_foot, r_stem = r_stem,
         r_bowl = r_bowl, r_rim = r_rim)


}
