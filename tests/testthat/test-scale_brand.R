testthat::test_that("scale_brand() | General test", {
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_s3_class("gg")

  scale_brand(
    aesthetics = "color",
    scale_type = "c",
    color_type = "div",
    alpha = 0.5,
    direction = -1,
    na.value = "white",
    reverse = TRUE
  ) |>
    testthat::expect_s3_class("gg")

  scale_brand(
    aesthetics = "color",
    scale_type = "b",
    color_type = "qual",
    alpha = NULL,
    direction = 1,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_s3_class("gg")
})

testthat::test_that("scale_brand() | Error test", {
  # checkmate::assert_string(aesthetics)
  scale_brand(
    aesthetics = 1,
    scale_type = "d",
    color_type = "qual",
    direction = 1,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(scale_type, scale_type_choices)
  scale_brand(
    aesthetics = "color",
    scale_type = "a",
    color_type = "qual",
    direction = 1,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(color_type, color_type_choices)
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "a",
    direction = 1,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_number(alpha, lower = 0, upper = 1, null.ok = TRUE)
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "qual",
    direction = 1,
    na.value = NA,
    reverse = FALSE,
    alpha = -1
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(direction, c(-1, 1))
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "qual",
    direction = 0,
    na.value = NA,
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(na.value, na.ok = TRUE)
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "qual",
    direction = 1,
    na.value = 1,
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # if (!is.na(na.value)) assert_color(na.value)
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "qual",
    direction = 1,
    na.value = "a",
    reverse = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(reverse)
  scale_brand(
    aesthetics = "color",
    scale_type = "d",
    color_type = "qual",
    direction = 1,
    na.value = NA,
    reverse = "a"
  ) |>
    testthat::expect_error()
})

testthat::test_that("scale_color_brand_d() | General test", {
  scale_color_brand_d() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_color_brand_c() | General test", {
  scale_color_brand_c() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_color_brand_b() | General test", {
  scale_colour_brand_b() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_colour_brand_d() | General test", {
  scale_colour_brand_d() |> testthat::expect_s3_class("gg")
})
testthat::test_that("scale_colour_brand_c() | General test", {
  scale_colour_brand_c() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_colour_brand_b() | General test", {
  scale_colour_brand_b() |> testthat::expect_s3_class("gg")
})
testthat::test_that("scale_fill_brand_d() | General test", {
  scale_fill_brand_d() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_fill_brand_c() | General test", {
  scale_fill_brand_c() |> testthat::expect_s3_class("gg")
})

testthat::test_that("scale_fill_brand_b() | General test", {
  scale_fill_brand_b() |> testthat::expect_s3_class("gg")
})
