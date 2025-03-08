# See https://danielvartan.github.io/rutils/reference/grab_fun_par.html
grab_fun_par <- function() {
  args_names <- ls(envir = parent.frame(), all.names = TRUE, sorted = FALSE)

  if ("..." %in% args_names) {
    dots <- eval(quote(list(...)), envir = parent.frame())
  } else {
    dots <- list()
  }

  args_names <- sapply(setdiff(args_names, "..."), as.name)

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
