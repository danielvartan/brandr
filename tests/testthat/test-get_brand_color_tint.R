testthat::test_that("get_brand_color_tint() | General test", {
  get_brand_color_tint(500, color = "secondary") |>
    testthat::expect_equal("#390963")

  get_brand_color_tint(c(0, 500, 1000), color = "primary") |>
    testthat::expect_equal(c("#000000", "#DA4E3C", "#FFFFFF"))
})

testthat::test_that("get_brand_color_tint() | Error test", {
  # checkmate::assert_integerish(position, lower = 0, upper = 1000)
  get_brand_color_tint(1001, color = "primary") |>
    testthat::expect_error()
})
