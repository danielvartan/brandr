#' Interpolate colors
#'
#' @description
#'
#' `interpolate_colors()` interpolate colors for sequential, diverging,
#' and qualitative color scales.
#'
#' @param type (Optional) A [`character`][base::character] string indicating
#'   the type of color scale: `"seq"`/`"sequential"``,
#'   `"div"`/`"diverging"``, or `"qual"`/`"qualitative"` (Default: `c `).
#' @param ... Additional arguments passed to
#'   [`colorRampPalette()`][grDevices::colorRampPalette] when creating the
#'   color ramp. Only valid when type is `seq` or `div`.
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_n
#' @template param_colors
#' @template param_direction
#' @template details_options
#' @family color functions.
#' @export
#'
#' @examples
#' interpolate_colors(3, color = c("red", "blue"), type = "seq")
#' #> [1] "#FF0000" "#7F007F" "#0000FF" # Expected
#'
#' # Same results of `type = "seq"`
#' interpolate_colors(3, color = c("red", "white", "blue"), type = "div")
#' #> [1] "#FF0000" "#FFFFFF" "#0000FF" # Expected
#'
#' interpolate_colors(3, color = c("red", "blue"), type = "qual")
#' #> [1] "red"  "blue" "red" # Expected
#'
#' interpolate_colors(3, color = c("red", "blue"), type = "seq", direction = -1)
#' #> [1] "#0000FF" "#7F007F" "#FF0000" # Expected
#'
#' interpolate_colors(3, color = c("red", "blue"), type = "seq", bias = 100)
#' #> [1] "#FF0000" "#7F007F" "#0000FF" # Expected
interpolate_colors <- function(
    n, #nolint
    colors = getOption("BRANDR_COLOR_SEQUENTIAL"),
    type = "seq",
    direction = 1,
    ...
  ) {
  # See https://ggplot2.tidyverse.org/reference/scale_brewer.html
  type_choices <- c(
    "seq", "sequential",
    "div", "diverging",
    "qual", "qualitative"
  )

  prettycheck::assert_numeric(n, lower = 0, min_len = 1)
  checkmate::assert_character(colors, null.ok = TRUE)
  if (is.null(colors)) colors <- get_default_brandr_color_type(type)
  prettycheck::assert_color(colors)
  checkmate::assert_choice(type, type_choices)
  checkmate::assert_choice(direction, c(-1, 1))

  if (!type %in% c("qual", "qualitative")) {
    if (length(n > 1) && all(dplyr::between(n, 0, 1), na.rm = TRUE)) {
      make_color_ramp(
        n_prop = n,
        direction = direction,
        colors = colors,
        ...
      )
    } else {
      make_color_ramp(
        n = n,
        direction = direction,
        colors = colors,
        ...
      )
    }
  } else {
    checkmate::assert_int(n, lower = 1)

    if (direction == -1) colors <- rev(colors)

    rep(colors, length.out = n)
  }
}

#' Make a color ramp vector
#'
#' @description
#'
#' `make_color_ramp()` creates a color ramp for a given number of colors.
#'
#' @details
#'
#' This function uses [`colorRampPalette()`][grDevices::colorRampPalette] to
#' create the color ramp. The default bias is `1`, which means that the space
#' between colors is evenly distributed. You can change the bias and other
#' parameters by passing additional arguments using the `...` parameter.
#'
#' @param values (Optional) A [`character`][base::character] vector with
#'   names to assign to each color.
#' @param n_prop (Optional) A [`numeric`][base::numeric] vector between `0`
#'   and `1`, indicating the color positions to be retrieved, considering a
#'   continuous color spectrum ranging from `0` to `1`. If provided, the
#'  `n` parameter will be ignored.
#' @param n_prop_res (Optional) An integer indicating the amount of colors of
#'   the color spectrum used when `n_prop` is provided (Default: `10000`).
#' @param ... Additional arguments passed to
#'   [`colorRampPalette()`][grDevices::colorRampPalette] when creating the
#'   color ramp.
#'
#' @return A [`character`][base::character] vector with hexadecimal color
#'   codes.
#'
#' @template param_n
#' @template param_colors
#' @template param_direction
#' @template details_options
#' @family color functions.
#' @noRd
#'
#' @examples
#' make_color_ramp(3, colors = c("red", "blue"))
#' #> [1] "#FF0000" "#7F007F" "#0000FF" # Expected
#'
#' make_color_ramp(3, colors = c("red", "blue"), direction = -1)
#' #> [1] "#0000FF" "#7F007F" "#FF0000" # Expected
#'
#' make_color_ramp(3, colors = c("red", "blue"), bias = 100)
#' #> [1] "#FF0000" "#7F007F" "#0000FF" # Expected
#'
#' make_color_ramp(
#'   n = 3,
#'   colors = c("red", "blue"),
#'   values = c("low", "middle", "high")
#' )
#' #>       low    middle      high # Expected
#' #> "#FF0000" "#7F007F" "#0000FF"
#'
#' make_color_ramp(n_prop = c(0.1, 0.5, 1), colors = c("red", "blue"))
#' #> [1] "#E50019" "#7F007F" "#0000FF" # Expected
#'
#' make_color_ramp(
#'   n_prop = c(0.1, 0.5, 1),
#'   colors = c("red", "blue"),
#'   n_prop_res = 10
#' )
#' #> [1] "#FF0000" "#8D0071" "#0000FF" # Expected
make_color_ramp <- function(
    n = NULL, #nolint
    colors = getOption("BRANDR_COLOR_SEQUENTIAL"),
    direction = 1,
    values = NULL,
    n_prop = NULL,
    n_prop_res = 100000,
    ...
  ) {
  checkmate::assert_int(n, lower = 1, null.ok = TRUE)
  if (is.null(colors)) colors <- get_default_brandr_color_type("seq")
  prettycheck::assert_color(colors)
  checkmate::assert_choice(direction, c(-1, 1))
  prettycheck::assert_numeric(n_prop, lower = 0, upper = 1, null_ok = TRUE)
  checkmate::assert_int(n_prop_res, lower = 1)

  if (direction == -1) colors <- rev(colors)

  color_fun <- function(n) {
    color_ramp_fun <- grDevices::colorRampPalette(colors, ...) #nolint

    dplyr::case_when(
      n == 0 ~ color_ramp_fun(1),
      is.na(n) ~ NA,
      TRUE ~ color_ramp_fun(n)
    )
  }

  if (!is.null(n_prop)) {
    n <- n_prop * n_prop_res
    n <- ifelse(n == 0, 1, n)

    out <- color_fun(n_prop_res)[n]
    n <- length(n)
  } else {
    out <- color_fun(n)
  }

  if (!is.null(values)) {
    checkmate::assert_atomic(values, len = n)

    names(out) <- as.character(values)
  }

  out
}
