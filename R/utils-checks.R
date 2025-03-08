assert_brand_yml <- function() {
  path <- getOption("BRANDR_BRAND_YML")

  if (is.null(path) || !test_file_exists(path)) { # mockr
    if (!is_interactive()) { # mockr
      path <- system.file("extdata", "_brand.yml", package = "brandr")
    } else if (!test_file_exists(here::here("_brand.yml"))) { # mockr
      cli_abort( # mockr
        paste0(
          "The {.strong {cli::col_red('_brand.yml')}} file was not found. ",
          "Please make sure the file is in the root directory of your project. ",
          "You can also set the path to the file using ",
          "{.strong {cli::col_blue('options(BRANDR_BRAND_YML = [PATH])')}}."
        )
      )
    } else {
      path <- here::here("_brand.yml")
    }
  }

  path
}

# See https://danielvartan.github.io/prettycheck/reference/assert_color.html
assert_color <- function(
    color, #nolint
    any_missing = FALSE,
    null_ok = FALSE
  ) {
  checkmate::assert_flag(any_missing)
  checkmate::assert_flag(null_ok)
  checkmate::assert_character(
    color, any.missing = any_missing, null.ok = null_ok
  )

  color_pattern <- "(?i)^#[a-f0-9]{3}$|(?i)^#[a-f0-9]{6}$|(?i)^transparent$"

  for (i in color) {
    if (!i %in% grDevices::colors() && #nolint
        !checkmate::test_string(i, pattern = color_pattern)) { #nolint
      cli::cli_abort(
        paste0(
          "{.strong {cli::col_red(i)}} is not a valid color code. ",
          "It must contain a hexadecimal color code or one of the ",
          "values in {.strong {cli::col_blue('grDevices::color()')}}."
        )
      )
    }
  }

  invisible(color)
}
