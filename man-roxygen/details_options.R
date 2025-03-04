#' @details
#'
#' To control the colors for each brand color scale, assign the desired
#' hexadecimal color codes in a [`character`][base::character] vector to the
#' following options:
#'
#' - `BRANDR_COLOR_SEQUENTIAL` for sequential color scales
#' - `BRANDR_COLOR_DIVERGING` for diverging color scales
#' - `BRANDR_COLOR_QUALITATIVE` for qualitative color scales
#'
#' Use [`get_brand_color()`][get_brand_color] to get the hexadecimal
#' color codes from the `_brand.yml` file.
#'
#' Example:
#'
#' ```r
#' options(
#'   BRANDR_COLOR_SEQUENTIAL =
#'     get_brand_color(c("primary", "secondary")),
#'   BRANDR_COLOR_DIVERGING =
#'     get_brand_color(c("primary", "white", "secondary")),
#'   BRANDR_COLOR_QUALITATIVE =
#'     get_brand_color(c("primary", "secondary", "tertiary"))
#' )
#' ```
