# See https://danielvartan.github.io/rutils/reference/grab_fun_par.html
grab_fun_par <- function() {
  args_names <- ls(envir = parent.frame(), all.names = TRUE, sorted = FALSE)

  if ("..." %in% args_names) {
    dots <- eval(quote(list(...)), envir = parent.frame())
  } else {
    dots <- list()
  }

  args_names <- setdiff(args_names, "...") |> lapply(as.name)
  names(args_names) <- setdiff(args_names, "...")

  if (!length(args_names) == 0) {
    not_dots <- lapply(args_names, eval, envir = parent.frame())
  } else {
    not_dots <- list()
  }

  out <- c(not_dots, dots)

  out[names(out) != ""]
}


# library(checkmate)

# Already in the `rutils` package
clean_arg_list <- function(list) {
  checkmate::assert_multi_class(list, c("list", "pairlist"))
  checkmate::assert_list(as.list(list), names = "named")

  list <- list |> nullify_list()

  out <- list()

  for (i in seq_along(list)) {
    if (!names(list[i]) %in% names(out)) {
      out <- c(out, list[i])
    }
  }

  out
}

# library(checkmate)

# Already in the `rutils` package
nullify_list <- function(list) {
  checkmate::assert_multi_class(list, c("list", "pairlist"))
  checkmate::assert_list(as.list(list), names = "named")

  for (i in names(list)) {
    if (!is.null(list[[i]]) && is.atomic(list[[i]])) {
      if (any(list[[i]] == "", na.rm = TRUE)) {
        list[i] <- list(NULL)
      }
    }
  }

  list
}

# See https://danielvartan.github.io/rutils/reference/col2hex.html
col2hex <- function(x) {
  checkmate::assert_character(x)
  assert_color(x, any_missing = TRUE)

  dplyr::case_when(
    grepl("(?i)^#[a-f0-9]{8}$", x) ~ x,
    is.na(x) ~ NA_character_,
    TRUE ~
      x |>
      grDevices::col2rgb() |>
      t() |>
      as.data.frame() |>
      c(list(names = x, maxColorValue = 255)) |>
      do.call(grDevices::rgb, args = _) |>
      unname()
  )
}