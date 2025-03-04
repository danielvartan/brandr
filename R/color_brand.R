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
#' if (interactive()) {
#'   color_brand_sequential(5)
#'   color_brand_diverging(5)
#'   color_brand_qualitative(5)
#' }
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
