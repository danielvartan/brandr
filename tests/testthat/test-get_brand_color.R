testthat::test_that("get_brand_color() | General test", {
  get_brand_color("primary") |> testthat::expect_equal("#DA4E3C")
  get_brand_color("secondary") |> testthat::expect_equal("#390963")
  get_brand_color("tertiary") |> testthat::expect_equal("#FB9706")
  get_brand_color("red") |> testthat::expect_equal("#DA4E3C")
  get_brand_color("red", 0.5) |> testthat::expect_equal("#DA4E3C80")
  get_brand_color("purple") |> testthat::expect_equal("#390963")

  get_brand_color(c("primary", "secondary")) |>
    testthat::expect_equal(c("#DA4E3C", "#390963"))

  get_brand_color(c("primary", "secondary"), 0.5) |>
    testthat::expect_equal(c("#DA4E3C80", "#39096380"))

  get_brand_color(c("primary", "secondary", "tertiary")) |>
    testthat::expect_equal(c("#DA4E3C", "#390963", "#FB9706"))

  # get_brand_color(c("TeSt")) |> testthat::expect_equal(NA)
})

testthat::test_that("get_brand_color() | Error test", {
  # checkmate::assert_character(color, null.ok = FALSE, any.missing = FALSE)
  get_brand_color(1) |> testthat::expect_error()

  # checkmate::assert_number(alpha, lower = 0, upper = 1, null.ok = TRUE)
  get_brand_color("primary", -1) |> testthat::expect_error()

  # cli::cli_alert_warning()
  get_brand_color("TeSt") |> testthat::expect_message()
})
