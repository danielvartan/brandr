#' Brand color palettes
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `color_brand_*` functions are wrappers of
#' [`interpolate_colors()`][interpolate_colors] for sequential, diverging,
#' and qualitative brand color palettes. They serve as facilitators for
#' getting the colors being used in each brand scale.
#'
#' @return A [`character`][base::character] vector with
#'   [hexadecimal](https://en.wikipedia.org/wiki/Web_colors) color codes.
#'
#' @template param_n
#' @template param_alpha
#' @template param_direction
#' @template details_options_a
#' @family color functions
#' @export
#'
#' @examples
#' color_brand_sequential(5)
#' #> [1] "#390963" "#892B4F" "#DA4E3C" "#EA7220" "#FB9706" # Expected
#'
#' color_brand_diverging(5)
#' #> [1] "#390963" "#9C84B1" "#FFFFFF" "#FDCB82" "#FB9706" # Expected
#'
#' color_brand_qualitative(5)
#' #> [1] "#DA4E3C" "#390963" "#FB9706" "#DA4E3C" "#390963" # Expected
#'
#' color_brand_qualitative(3, alpha = 0.5)
#' #> [1] "#DA4E3C80" "#39096380" "#FB970680" # Expected
color_brand_sequential <- function(n, alpha = NULL, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_SEQUENTIAL"),
    type = "seq",
    alpha = alpha,
    direction = direction
  )
}

#' @rdname color_brand_sequential
#' @export
color_brand_diverging <- function(n, alpha = NULL, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_DIVERGING"),
    type = "div",
    alpha = alpha,
    direction = direction
  )
}

#' @rdname color_brand_sequential
#' @export
color_brand_qualitative <- function(n, alpha = NULL, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_QUALITATIVE"),
    type = "qual",
    alpha = alpha,
    direction = direction
  )
}
