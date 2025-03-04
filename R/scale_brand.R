#' Brand color scales for `ggplot2``
#'
#' @description
#'
#' `scale_*_brand_*()` functions provide color scales for
#' [ggplot2](https://ggplot2.tidyverse.org/) based on brand colors defined
#' in the `_brand.yml` file. These functions create discrete, continuous, or
#' binned scales with sequential, diverging, or qualitative color palettes
#' that match your brand identity.
#'
#' @param aesthetics (Optional) A [`character`][base::character] string
#'   indicating the name of the aesthetic of the scale (e.g., `"color"``,
#'  `"fill"`).
#' @param scale_type (Optional) A [`character`][base::character] string
#'   indicating the type of scale: `"d"`/`"discrete"`, `"c"`/`"continuous"`,
#'   or `"b"`/`"binned"`.
#' @param color_type (Optional) A [`character`][base::character] string
#'   indicating the type of color scale: `"seq"`/`"sequential"``,
#' `"div"`/`"diverging"``, or `"qual"`/`"qualitative"` (Default: `c `).
#' @param na.value (Optional) A [`character`][base::character] string
#'   indicating the color to use for missing values. It must contain a
#'   hexadecimal color code or one of the values in
#'   [`colors()`][grDevices::colors] (Default: `NA`).
#' @param reverse A [`logical`][base::logical] indicating whether the
#'   legend or color bar should be reversed (Default: `FALSE`).
#' @param brand_yml (Optional) A [`character`][base::character] string
#'   indicating the path to the `_brand.yml` file. If not provided, the
#'   function will look for the `_brand.yml` file in the current working
#'   directory.
#' @param ... Additional arguments passed to the `ggplot2` scale function:
#'   [`discrete_scale()`][ggplot2::discrete_scale],
#'   [`continuous_scale()`][ggplot2::continuous_scale], or
#'   [`binned_scale()`][ggplot2::binned_scale].
#'
#' @return A [`ggplot2`][ggplot2::continuous_scale] scale object.
#'
#' @template param_direction
#' @template param_brand_yml
#' @template details_options
#' @family ggplot2 functions.
#' @export
#'
#' @examples
#' if (base::interactive()) {
#'   library(ggplot2)
#'
#'   ggplot(mtcars, aes(mpg, wt, color = cyl)) +
#'     geom_bar() +
#'     scale_color_brand_c() +
#'     theme_bw()
#'
#'   ggplot(mtcars, aes(mpg, wt, fill = factor(cyl))) +
#'     geom_boxplot() +
#'     scale_fill_brand_d(color_type = "qual") +
#'     theme_bw()
#' }
scale_brand <- function(
    aesthetics = "color", #nolint
    scale_type = "c",
    color_type = "seq",
    direction = 1,
    na.value = NA, # Must follow ggplot2 arg names. # "grey50" #nolint
    reverse = FALSE,
    brand_yml = here::here("_brand.yml"),
    ...
  ) {
  # https://ggplot2-book.org/extensions#sec-new-scales to learn more.
  # See https://ggplot2.tidyverse.org/reference/scale_viridis.html
  scale_type_choices <- c(
    "d", "discrete",
    "c", "continuous",
    "b", "binned"
  )

  # See https://ggplot2.tidyverse.org/reference/scale_brewer.html
  color_type_choices <- c(
    "seq", "sequential",
    "div", "diverging",
    "qual", "qualitative"
  )

  checkmate::assert_string(aesthetics)
  checkmate::assert_choice(scale_type, scale_type_choices)
  checkmate::assert_choice(color_type, color_type_choices)
  checkmate::assert_choice(direction, c(-1, 1))
  if (!is.na(na.value)) prettycheck::assert_color(na.value)
  checkmate::assert_flag(reverse)
  checkmate::assert_file_exists(brand_yml)

  if (color_type %in% c("seq", "sequential")) {
    palette <- \(x) color_brand_sequential(x, direction = direction)
  } else if (color_type %in% c("div", "diverging")) {
    palette <- \(x) color_brand_diverging(x, direction = direction)
  } else if (color_type %in% c("qual", "qualitative")) {
    palette <- \(x) color_brand_qualitative(x, direction = direction)
  }

  if (scale_type %in% c("d", "discrete")) {
    scale_fun <- ggplot2::discrete_scale
    guide <- ggplot2::guide_legend(reverse = reverse)
  } else if (scale_type %in% c("c", "continuous")) {
    scale_fun <- ggplot2::continuous_scale
    guide <- ggplot2::guide_colourbar(reverse = reverse)
  } else if (scale_type %in% c("b", "binned")) {
    scale_fun <- ggplot2::binned_scale
    guide <- ggplot2::guide_colorsteps(reverse = reverse)
  }

  arg_list <- list(
    aesthetics = aesthetics,
    palette = palette,
    na.value = na.value,
    guide = guide
  )

  do.call(
    what = scale_fun,
    args = c(
      list(...)[names(list(...)) %in% names(formals(scale_fun))],
      arg_list
    ) |>
      clean_arg_list()
  )
}

#' @rdname scale_brand
#' @export
scale_color_brand_d <- function(
    aesthetics = "color", #nolint
    scale_type = "d",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_color_brand_c <- function(
    aesthetics = "color", #nolint
    scale_type = "c",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_color_brand_b <- function(
    aesthetics = "color", #nolint
    scale_type = "b",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_colour_brand_d <- scale_color_brand_d

#' @rdname scale_brand
#' @export
scale_colour_brand_c <- scale_color_brand_c

#' @rdname scale_brand
#' @export
scale_colour_brand_b <- scale_color_brand_b

#' @rdname scale_brand
#' @export
scale_fill_brand_d <- function(
    aesthetics = "fill", #nolint
    scale_type = "d",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_fill_brand_c <- function(
    aesthetics = "fill", #nolint
    scale_type = "c",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_fill_brand_b <- function(
    aesthetics = "fill", #nolint
    scale_type = "b",
    color_type = "seq",
    direction = 1,
    ...
  ) {
  do.call("scale_brand", rutils::grab_fun_par())
}
