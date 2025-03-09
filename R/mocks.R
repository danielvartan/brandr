# See `?testthat::local_mocked_bindings`` for more information.

cli_abort <- function(...) cli::cli_abort(...)

is_interactive <- function(...) interactive()

test_file_exists <- function(...) checkmate::test_file_exists(...)
