#' Get brand colors
#'
#' @description
#'
#' `get_brand_color()` retrieves hexadecimal color codes from the `_brand.yml`
#' file.
#'
#' @param color A [`character`][base::character] vector indicating the name of
#'   colors present in the `color` section of the `_brand.yml` file.
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_brand_yml
#' @family utility functions.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   get_brand_color("primary")
#'   get_brand_color("secondary")
#'   get_brand_color("tertiary")
#'
#'   get_brand_color(c("primary", "secondary"))
#'   get_brand_color(c("red", "green", "blue"))
#' }
get_brand_color <- function(color, brand_yml = here::here("_brand.yml")) {
  checkmate::assert_character(color, null.ok = FALSE, any.missing = FALSE)
  checkmate::assert_string(basename(brand_yml), pattern = "_brand.yml")
  checkmate::assert_file_exists(brand_yml)

  brands_list <- yaml::read_yaml(brand_yml)
  palette_names <- brands_list$color$palette |> names()
  color_names <- brands_list$color |> names()

  if ("palette" %in% color_names) {
    color_names <- color_names |> setdiff("palette")
  }

  palette_colors <- NULL

  for (i in color) {
    if (i %in% color_names) {
      palette_colors <- c(palette_colors, brands_list$color[[i]])
    } else if (i %in% palette_names) {
      palette_colors <- c(palette_colors, i)
    } else {
      cli::cli_alert_warning(
        paste0(
          "The color {.strong {i}} was not found ",
          "in the `_brand.yml` file."
        ),
        wrap = TRUE
      )

      palette_colors <- c(palette_colors, i)
    }
  }

  out <- NULL

  for (i in palette_colors) {
    j <- brands_list$color$palette[[i]]

    if (!is.null(j)) {
      out <- c(out, j)
    } else {
      out <- c(out, NA)
    }
  }

  out
}

#' Get brand fonts/typefaces
#'
#' @description
#'
#' `get_brand_font()` retrieves the names of fonts/typefaces in the
#' `_brand.yml` file.
#'
#' @param font A [`character`][base::character] vector indicating the name of
#'   fonts/typefaces categories present in the `typography` section of the
#' `_brand.yml` file.
#'
#' @return A [`character`][base::character] vector with fonts/typeface names.
#'
#' @template param_brand_yml
#' @family utility functions.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   get_brand_font("base")
#'   get_brand_font("headings")
#'   get_brand_font("monospace")
#'   get_brand_font("monospace-inline")
#'   get_brand_font("monospace-block")
#'
#'   get_brand_font(c("base", "headings"))
#' }
get_brand_font <- function( #nolint
    font, #nolint
    brand_yml = here::here("_brand.yml")
  ) {
  checkmate::assert_character(font, null.ok = FALSE, any.missing = FALSE)
  checkmate::assert_string(brand_yml, pattern = "\\_brand\\.yml$")
  checkmate::assert_file_exists(brand_yml)

  brands_list <- yaml::read_yaml(brand_yml)
  typography_names <- brands_list$typography |> names()

  valid_values <- c(
    "base", "headings", "monospace", "monospace-inline", "monospace-block"
  )

  out <- NULL

  for (i in font) {
    if (!i %in% valid_values) {
      cli::cli_alert_warning(
        paste0(
          "{.strong {cli::col_red(i)}} is not a valid font/typeface ",
          "category."
        ),
        wrap = TRUE
      )

      out <- c(out, NA)
      next()
    } else if (!i %in% typography_names) {
      cli::cli_alert_warning(
        paste0(
          "The font/typeface {.strong {cli::col_red(i)}} is not defined ",
          "in the `_brand.yml` file."
        ),
        wrap = TRUE
      )

      out <- c(out, NA)
      next()
    }

    j <- brands_list$typography[[i]]

    if (!is.null(j)) {
      if (is.list(j) && "family" %in% names(j)) {
        out <- c(out, j$family)
      } else if (is.character(j) && length(j) == 1) {
        out <- c(out, j)
      } else {
        out <- c(out, NA)
      }
    } else {
      out <- c(out, NA)
    }
  }

  out
}

#' Get tints of brand colors
#'
#' @description
#'
#' `get_brand_color_tint()` generates a range of tints (color variations) for a
#' specific brand color, from black (position 0) through the brand color
#' (position 500) to white (position 1000), and returns the hexadecimal color
#' code at the specified position.
#'
#' @param color A [`character`][base::character] string indicating the name
#'   of a color present in the `color` section of the `_brand.yml`
#'   file (Default: `"primary"`).
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_position
#' @template param_brand_yml
#' @family utility functions.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   seq(0, 1000, 250)
#'   #> [1] 0  250  500  750 1000 # Expected
#'
#'   get_brand_color_tint(seq(0, 1000, 250), color = "primary")
#'   #> [1] "#000000" "#6D271E" "#DA4E3C" "#ECA69D" "#FFFFFF" # Expected
#' }
get_brand_color_tint <- function(
    position = 500, #nolint
    color = "primary",
    brand_yml = here::here("_brand.yml")
  ) {
  checkmate::assert_integerish(position, lower = 0, upper = 1000)
  checkmate::assert_string(brand_yml, pattern = "\\_brand\\.yml$")
  checkmate::assert_file_exists(brand_yml)

  color <- get_brand_color(color)

  prettycheck::assert_color(color)

  color_fun <- grDevices::colorRampPalette(c("black", color, "white"))
  color_values <- color_fun(1001)

  color_values[position + 1] # R is 1-indexed
}

#' Get a mix of brand colors
#'
#' @description
#'
#' `get_brand_color_mix()` mixes two specific brand colors.
#'
#' @param color_1,color_2 A [`character`][base::character] string indicating
#'   the name of a color present in the `color` section of the `_brand.yml`
#'   file.
#' @param alpha A number between 0 and 1 indicating the alpha transparency of
#'   the color mix (Default: `0.5`).
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_position
#' @template param_brand_yml
#' @family utility functions.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   get_brand_color_mix(
#'     position = 500,
#'     color_1 = "primary",
#'     color_2 = "secondary",
#'     alpha = 0.5
#'   )
#' }
get_brand_color_mix <- function(
    position = 500, #nolint
    color_1 = "primary",
    color_2 = "secondary",
    alpha = 0.5,
    brand_yml = here::here("_brand.yml")
  ) {
  checkmate::assert_integerish(position, lower = 0, upper = 1000)
  checkmate::assert_number(alpha, lower = 0, upper = 1)
  checkmate::assert_string(brand_yml, pattern = "\\_brand\\.yml$")
  checkmate::assert_file_exists(brand_yml)

  # scales::rescale(0.9, to = c(0, 1000), from = c(-1, 1))

  colorspace::mixcolor(
    alpha,
    get_brand_color_tint(position, color_1) |> colorspace::hex2RGB(),
    get_brand_color_tint(position, color_2) |> colorspace::hex2RGB()
  ) |>
    colorspace::hex()
}
