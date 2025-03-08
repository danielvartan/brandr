testthat::test_that("color_brand_sequential() | General test", {
  color_brand_sequential(3) |>
    testthat::expect_equal(c("#390963", "#DA4E3C", "#FB9706"))
})

testthat::test_that("color_brand_diverging() | General test", {
  color_brand_diverging(3) |>
    testthat::expect_equal(c("#390963", "#FFFFFF", "#FB9706"))
})

testthat::test_that("color_brand_qualitative() | General test", {
  color_brand_qualitative(3) |>
    testthat::expect_equal(c("#DA4E3C", "#390963", "#FB9706"))
})
