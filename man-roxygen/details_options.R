#' @details
#'
#' ## Path to `_brand.yml`
#'
#' `brandr` will always look for the `_brand.yml` file in the root directory of
#' your project. If the file is not found, an error message will be displayed.
#' You can also set the path to the file manually using the
#' [`options()`][base::options] function:
#'
#' ```r
#' options(BRANDR_BRAND_YML = [PATH TO _brand.yml])
#' ```
#'
#' ## Brand color scales
#'
#' To control the colors for each brand color scale, assign the desired
#' hexadecimal color codes in a [`character`][base::character] vector to the
#' following options:
#'
#' - `BRANDR_COLOR_SEQUENTIAL`: For sequential color scales
#' - `BRANDR_COLOR_DIVERGING`:  For diverging color scales
#' - `BRANDR_COLOR_QUALITATIVE`: For qualitative color scales
#'
#' Use [`get_brand_color()`][get_brand_color] to get the hexadecimal
#' color codes from the `_brand.yml` file.
#'
#' Example:
#'
#' ```r
#' options(
#'   BRANDR_BRAND_YML = here::here("_brand.yml"),
#'   BRANDR_COLOR_SEQUENTIAL =
#'     get_brand_color(c("primary", "secondary")),
#'   BRANDR_COLOR_DIVERGING =
#'     get_brand_color(c("primary", "white", "secondary")),
#'   BRANDR_COLOR_QUALITATIVE =
#'     get_brand_color(c("primary", "secondary", "tertiary"))
#' )
#' ```
