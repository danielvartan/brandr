test_that("cli_abort() | General test", {
  cli_abort("A") |> testthat::expect_error()
})

test_that("is_interactive() | General test", {
  is_interactive() |> testthat::expect_equal(interactive())
})

test_that("test_file_exists() | General test", {
  test_file_exists("TeST") |> testthat::expect_false()
})
