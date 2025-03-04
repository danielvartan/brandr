assert_brand_yml <- function() {
  path <- getOption("BRANDR_BRAND_YML")

  if (is.null(path) || !checkmate::test_file_exists(path)) {
    if (!interactive()) {
      path <- system.file("extdata", "_brand.yml", package = "brandr")
    } else if (!checkmate::test_file_exists(here::here("_brand.yml"))) {
      cli::cli_abort(
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
