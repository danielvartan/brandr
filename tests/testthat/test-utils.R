testthat::test_that("grab_fun_par() | General test", {
  foo <- function(a = 1) grab_fun_par()
  foo() |> testthat::expect_equal(list(a = 1))

  foo <- function(...) grab_fun_par()
  foo(a = 1) |> testthat::expect_equal(list(a = 1))

  foo <- function(..., a = 1) grab_fun_par()
  foo() |> testthat::expect_equal(list(a = 1))

  foo <- function(...) grab_fun_par()
  foo(1) |> testthat::expect_equal(list())
})

testthat::test_that("clean_arg_list() | General test", {
  clean_arg_list(list(a = 1, b = "", c = 3)) |>
    testthat::expect_equal(list(a = 1, b = NULL, c = 3))

  clean_arg_list(pairlist(a = 1, a = "")) |>
    testthat::expect_equal(list(a = 1))
})

testthat::test_that("clean_arg_list() | Error test", {
  # checkmate::assert_multi_class(list, c("list", "pairlist"))
  clean_arg_list("a") |> testthat::expect_error()
  clean_arg_list(1) |> testthat::expect_error()
  clean_arg_list(data.frame(a = 1)) |> testthat::expect_error()

  # checkmate::assert_list(as.list(list), names = "named")
  clean_arg_list(list(1, 2, 3)) |> testthat::expect_error()
})

testthat::test_that("nullify_list() | General test", {
  nullify_list(list(a = 1, b = "", c = 3)) |>
    testthat::expect_equal(list(a = 1, b = NULL, c = 3))
})

testthat::test_that("nullify_list() | Error test", {
  # checkmate::assert_multi_class(list, c("list", "pairlist"))
  nullify_list("a") |> testthat::expect_error()
  nullify_list(1) |> testthat::expect_error()
  nullify_list(data.frame(a = 1)) |> testthat::expect_error()

  # checkmate::assert_list(as.list(list), names = "named")
  nullify_list(list(1, 2, 3)) |> testthat::expect_error()
})
