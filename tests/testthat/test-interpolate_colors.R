testthat::test_that("interpolate_colors() | General test", {
  interpolate_colors(
    n = 3,
    colors = c("red", "blue"),
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_equal(c("#FF0000", "#7F007F", "#0000FF"))

  interpolate_colors(
    n = c(0, 0.5, 1),
    colors = c("red", "blue"),
    type = "seq",
    direction = -1
  ) |>
    testthat::expect_equal(c("#0000FF", "#7F007F", "#FF0000"))

  interpolate_colors(
    n = 3,
    colors = c("red", "blue"),
    type = "seq",
    direction = 1,
    values = c("low", "middle", "high")
  ) |>
    testthat::expect_equal(
      c("#FF0000", "#7F007F", "#0000FF") %>%
        magrittr::set_names(c("low", "middle", "high"))
    )

  interpolate_colors(
    n = 3,
    colors = c("red", "white", "blue"),
    type = "div",
    direction = 1
  ) |>
    testthat::expect_equal(c("#FF0000", "#FFFFFF", "#0000FF"))

  interpolate_colors(
    n = 1,
    colors = c("red", "white", "blue"),
    type = "div",
    direction = 1
  ) |>
    testthat::expect_equal("#0000FF")

  interpolate_colors(
    n = 1,
    colors = c("red", "green", "blue"),
    type = "qual",
    direction = 1
  ) |>
    testthat::expect_equal("red")

  interpolate_colors(
    n = 4,
    colors = c("red", "green", "blue"),
    type = "qual",
    direction = 1
  ) |>
    testthat::expect_equal(c("red", "green", "blue", "red"))

  interpolate_colors(
    n = 3,
    colors = NULL,
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_equal(c("#390963", "#DA4E3C", "#FB9706"))

  interpolate_colors(
    n = 1,
    colors = NULL,
    type = "seq",
    direction = -1
  ) |>
    testthat::expect_equal("#390963")
})

testthat::test_that("interpolate_colors() | Error test", {
  # checkmate::assert_numeric(n, lower = 0, min.len = 1)
  interpolate_colors(
    n = -1,
    colors = c("red", "blue"),
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(colors, min.len = 2, null.ok = TRUE)
  interpolate_colors(
    n = 3,
    colors = 1:3,
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_error()

  interpolate_colors(
    n = 3,
    colors = "a",
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_error()

  # assert_color(colors)
  interpolate_colors(
    n = 3,
    colors = c("test1", "test2", "test3"),
    type = "seq",
    direction = 1
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(type, type_choices)
  interpolate_colors(
    n = 3,
    colors = c("red", "blue"),
    type = "test",
    direction = 1
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(direction, c(-1, 1))
  interpolate_colors(
    n = 3,
    colors = c("red", "blue"),
    type = "seq",
    direction = 0
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(n, lower = 1)
  interpolate_colors(
    n = 0.5,
    colors = c("red", "blue"),
    type = "qual",
    direction = 1
  ) |>
    testthat::expect_error()
})

testthat::test_that("make_color_ramp() | General test", {
  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1
  ) |>
    testthat::expect_equal(c("#FF0000", "#7F007F", "#0000FF"))

  make_color_ramp(
    n_prop = c(0, 0.5, 1),
    colors = c("red", "blue"),
    direction = -1
  ) |>
    testthat::expect_equal(c("#0000FF", "#7F007F", "#FF0000"))

  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1,
    values = c("low", "middle", "high")
  ) |>
    testthat::expect_equal(
      c("#FF0000", "#7F007F", "#0000FF") %>%
        magrittr::set_names(c("low", "middle", "high"))
    )

  make_color_ramp(
    n = 3,
    colors = c("red", "white", "blue"),
    direction = 1
  ) |>
    testthat::expect_equal(c("#FF0000", "#FFFFFF", "#0000FF"))

  make_color_ramp(
    n_prop = 1,
    colors = c("red", "white", "blue"),
    direction = 1
  ) |>
    testthat::expect_equal("#0000FF")

  make_color_ramp(
    n_prop = 1,
    colors = NULL,
    direction = 1
  ) |>
    testthat::expect_equal("#FB9706")

  make_color_ramp(
    n_prop = 0,
    colors = c("red", "blue"),
    direction = 1
  ) |>
    testthat::expect_equal("#FF0000")
})

testthat::test_that("make_color_ramp() | Error test", {
  # checkmate::assert_int(n, lower = 1, null.ok = TRUE)
  make_color_ramp(
    n = -1,
    colors = c("red", "blue"),
    direction = 1
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(colors, min.len = 2, null.ok = TRUE)
  make_color_ramp(
    n = 3,
    colors = 1:3,
    direction = 1
  ) |>
    testthat::expect_error()

  make_color_ramp(
    n = 3,
    colors = "a",
    direction = 1
  ) |>
    testthat::expect_error()

  # assert_color(colors)
  make_color_ramp(
    n = 3,
    colors = c("test1", "test2", "test3"),
    direction = 1
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(direction, c(-1, 1))
  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 0
  ) |>
    testthat::expect_error()

  # checkmate::assert_numeric(n_prop, lower = 0, upper = 1, null.ok = TRUE)
  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1,
    n_prop = 2
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(n_prop_res, lower = 1)
  make_color_ramp(
    n = NULL,
    colors = c("red", "blue"),
    direction = 1,
    n_prop = 0.5,
    n_prop_res = 0
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(n_prop_res, lower = n_prop)
  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1,
    n_prop_res = 2
  ) |>
    testthat::expect_error()

  # cli::cli_abort()
  make_color_ramp(
    n = NULL,
    colors = c("red", "blue"),
    direction = 1,
    n_prop = NULL
  ) |>
    testthat::expect_error()

  # checkmate::assert_atomic(values, len = n)
  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1,
    values = c("low", "middle")
  ) |>
    testthat::expect_error()

  make_color_ramp(
    n = 3,
    colors = c("red", "blue"),
    direction = 1,
    values = list("low", "middle", "high", "extra")
  ) |>
    testthat::expect_error()
})
