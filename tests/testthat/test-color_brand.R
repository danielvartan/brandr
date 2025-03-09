testthat::test_that("color_brand_sequential() | General test", {
  color_brand_sequential(3) |>
    testthat::expect_equal(c("#390963", "#DA4E3C", "#FB9706"))

  color_brand_sequential(3, alpha = 0.5) |>
    testthat::expect_equal(c("#39096380", "#DA4E3C80", "#FB970680"))

  color_brand_sequential(3, direction = -1) |>
    testthat::expect_equal(c("#FB9706", "#DA4E3C", "#390963"))
})

testthat::test_that("color_brand_diverging() | General test", {
  color_brand_diverging(3) |>
    testthat::expect_equal(c("#390963", "#FFFFFF", "#FB9706"))

  color_brand_diverging(3, alpha = 0.5) |>
    testthat::expect_equal(c("#39096380", "#FFFFFF80", "#FB970680"))

  color_brand_diverging(3, direction = -1) |>
    testthat::expect_equal(c("#FB9706", "#FFFFFF", "#390963"))
})

testthat::test_that("color_brand_qualitative() | General test", {
  color_brand_qualitative(3) |>
    testthat::expect_equal(c("#DA4E3C", "#390963", "#FB9706"))

  color_brand_qualitative(3, alpha = 0.5) |>
    testthat::expect_equal(c("#DA4E3C80", "#39096380", "#FB970680"))

  color_brand_qualitative(3, direction = -1) |>
    testthat::expect_equal(c("#FB9706", "#390963", "#DA4E3C"))
})
