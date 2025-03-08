testthat::test_that("get_brand_font() | General test", {
  option <- getOption("BRANDR_BRAND_YML")
  sys_brand_yml <- system.file("extdata", "_brand.yml", package = "brandr")
  options("BRANDR_BRAND_YML" = sys_brand_yml)

  get_brand_font("base") |> testthat::expect_equal("Open Sans")
  get_brand_font("headings") |> testthat::expect_equal("Rubik")
  get_brand_font("monospace") |> testthat::expect_equal("IBM Plex Mono")
  get_brand_font("monospace-block") |> testthat::expect_equal("IBM Plex Mono")

  get_brand_font(c("base", "headings")) |>
    testthat::expect_equal(c("Open Sans", "Rubik"))

  get_brand_font(c("monospace", "headings")) |>
    testthat::expect_equal(c("IBM Plex Mono", "Rubik"))

  # do.call("options", list("BRANDR_BRAND_YML" = option))
  do.call("options", list("BRANDR_BRAND_YML" = NULL))
})

testthat::test_that("get_brand_font() | Error test", {
  option <- getOption("BRANDR_BRAND_YML")
  sys_brand_yml <- system.file("extdata", "_brand.yml", package = "brandr")
  options("BRANDR_BRAND_YML" = sys_brand_yml)

  # checkmate::assert_character(font, null.ok = FALSE, any.missing = FALSE)
  get_brand_font(1) |> testthat::expect_error()

  # cli::cli_alert_warning()
  get_brand_font("link") |> testthat::expect_message()

  # cli::cli_alert_warning()
  get_brand_font("monospace-inline") |> testthat::expect_message()

  # do.call("options", list("BRANDR_BRAND_YML" = option))
  do.call("options", list("BRANDR_BRAND_YML" = NULL))
})
