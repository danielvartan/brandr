#' Brand color functions
#'
#' @description
#'
#' `color_brand_*` functions are wrappers of
#' [`interpolate_colors()`][interpolate_colors] for sequential, diverging,
#' and qualitative brand color scales. They serve as facilitators for the
#' visualization of the colors being used in each brand scale.
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_n
#' @template param_direction
#' @template details_options
#' @family color functions.
#' @export
#'
#' @examples
#' color_brand_sequential(5)
#' #> [1] "#DA4E3C" "#B13C45" "#892B4F" "#611A59" "#390963" # Expected
#'
#' color_brand_diverging(5)
#' #> [1] "#DA4E3C" "#ECA69D" "#FFFFFF" "#9C83B1" "#390963" # Expected
#'
#' color_brand_qualitative(5)
#' #> [1] "#DA4E3C" "#390963" "#FB9706" "#DA4E3C" "#390963" # Expected
color_brand_sequential <- function(n, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_SEQUENTIAL"),
    type = "seq",
    direction = direction
  )
}

#' @rdname color_brand_sequential
#' @export
color_brand_diverging <- function(n, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_DIVERGING"),
    type = "div",
    direction = direction
  )
}

#' @rdname color_brand_sequential
#' @export
color_brand_qualitative <- function(n, direction = 1) {
  interpolate_colors(
    n = n,
    colors = getOption("BRANDR_COLOR_QUALITATIVE"),
    type = "qual",
    direction = direction
  )
}
