testthat::test_that("get_brand_color_mix() | General test", {
  get_brand_color_mix(500, "primary", "secondary", 0.5) |>
    expect_equal(c("#8A2C50"))

  get_brand_color_mix(c(0, 500, 1000), "primary", "secondary", 0.5) |>
    expect_equal(c("#000000", "#8A2C50", "#FFFFFF"))
})

testthat::test_that("get_brand_color_mix() | Error test", {
  # checkmate::assert_integerish(position, lower = 0, upper = 1000)
  get_brand_color_mix(0.1, "primary", "secondary", 0.5) |>
    expect_error()

  # checkmate::assert_number(alpha, lower = 0, upper = 1)
  get_brand_color_mix(500, "primary", "secondary", 1.1) |>
    expect_error()
})
