testthat::test_that("default_options() | General test", {
  default_options("BRANDR_BRAND_YML") |> checkmate::expect_character()
  default_options("BRANDR_COLOR_SEQUENTIAL") |> checkmate::expect_character()
  default_options("BRANDR_COLOR_DIVERGING") |> checkmate::expect_character()
  default_options("BRANDR_COLOR_QUALITATIVE") |> checkmate::expect_character()
})

testthat::test_that("get_default_brandr_color_type() | General test", {
  get_default_brandr_color_type("seq") |> checkmate::expect_character()
  get_default_brandr_color_type("sequential") |> checkmate::expect_character()
  get_default_brandr_color_type("div") |> checkmate::expect_character()
  get_default_brandr_color_type("diverging") |> checkmate::expect_character()
  get_default_brandr_color_type("qual") |> checkmate::expect_character()
  get_default_brandr_color_type("qualitative") |> checkmate::expect_character()
})

testthat::test_that("get_default_brandr_color_type() | Error test", {
  # checkmate::assert_choice(type, type_choices)
  get_default_brandr_color_type("a") |> testthat::expect_error()
})
