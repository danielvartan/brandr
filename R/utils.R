# TO DO: Move this functions to `rutils` package -----

# library(prettycheck) # github.com/danielvartan/prettycheck

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

# library(prettycheck) # github.com/danielvartan/prettycheck

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
