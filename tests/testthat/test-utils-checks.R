testthat::test_that("assert_brand_yml() | General test", {
  option <- getOption("BRANDR_BRAND_YML")
  sys_brand_yml <- system.file("extdata", "_brand.yml", package = "brandr")

  assert_brand_yml() |> checkmate::expect_character()

  options("BRANDR_BRAND_YML" = sys_brand_yml)
  assert_brand_yml() |> checkmate::expect_character()

  options("BRANDR_BRAND_YML" = NULL)
  testthat::local_mocked_bindings(
    is_interactive = function(...) TRUE,
    test_file_exists = function(...) TRUE
  )
  assert_brand_yml() |> testthat::expect_equal(here::here("_brand.yml"))

  # do.call("options", list("BRANDR_BRAND_YML" = option))
  do.call("options", list("BRANDR_BRAND_YML" = NULL))
})

testthat::test_that("assert_brand_yml() | Error test", {
  option <- getOption("BRANDR_BRAND_YML")

  # cli::cli_abort()
  options("BRANDR_BRAND_YML" = NULL)
  testthat::local_mocked_bindings(
    cli_abort = function(...) NULL,
    is_interactive = function(...) TRUE,
    test_file_exists = function(...) FALSE
  )
  assert_brand_yml() |> testthat::expect_null()

  # do.call("options", list("BRANDR_BRAND_YML" = option))
  do.call("options", list("BRANDR_BRAND_YML" = NULL))
})

testthat::test_that("assert_color() | General test", {
  assert_color("red",  FALSE, FALSE) |> testthat::expect_invisible()
  assert_color("red",  FALSE, FALSE) |> testthat::expect_equal("red")
  assert_color(NULL,  FALSE, TRUE) |> testthat::expect_null()

  assert_color(c("red", "blue"),  FALSE, FALSE) |>
    testthat::expect_equal(c("red", "blue"))

  assert_color(c("red", NA),  TRUE, FALSE) |>
    testthat::expect_equal(c("red", NA))
})

testthat::test_that("assert_color() | Error test", {
  # checkmate::assert_flag(any_missing)
  assert_color("red",  "a", TRUE) |> testthat::expect_error()

  # checkmate::assert_flag(null_ok)
  assert_color("red", TRUE, "a") |> testthat::expect_error()

  # checkmate::assert_character()
  assert_color(1, TRUE, TRUE) |> testthat::expect_error()

  # cli::cli_abort()
  assert_color("TeSt", TRUE, TRUE) |> testthat::expect_error()
})
