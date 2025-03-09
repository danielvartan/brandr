#' Brand color scales for `ggplot2`
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `scale_*_brand_*()` functions provide color scales for
#' [ggplot2](https://ggplot2.tidyverse.org/) based on brand colors defined
#' in the `_brand.yml` file. These functions create discrete, continuous, or
#' binned scales with sequential, diverging, or qualitative color palettes
#' that match your brand identity.
#'
#' @param aesthetics (Optional) A [`character`][base::character] string
#'   indicating the name of the aesthetic of the scale (e.g., `"color"`,
#'   `"fill"`) (Default: `"color"`).
#' @param scale_type (Optional) A [`character`][base::character] string
#'   indicating the type of scale: `"d"`/`"discrete"`, `"c"`/`"continuous"`,
#'   or `"b"`/`"binned"` (Default: `"c"`).
#' @param color_type (Optional) A [`character`][base::character] string
#'   indicating the type of color scale: `"seq"`/`"sequential"`,
#'   `"div"`/`"diverging"`, or `"qual"`/`"qualitative"` (Default: `"seq"`).
#' @param na.value (Optional) A [`character`][base::character] string
#'   indicating the color to use for missing values. It must contain a
#'   hexadecimal color code or one of the values in
#'   [`colors()`][grDevices::colors] (Default: `NA`).
#' @param reverse (Optional) A [`logical`][base::logical] indicating whether
#'   the legend or color bar should be reversed (Default: `FALSE`).
#' @param ... Additional arguments passed to the `ggplot2` scale function:
#'   [`discrete_scale()`][ggplot2::discrete_scale],
#'   [`continuous_scale()`][ggplot2::continuous_scale], or
#'   [`binned_scale()`][ggplot2::binned_scale].
#'
#' @return A [`ggplot2`][ggplot2::continuous_scale] scale object.
#'
#' @template param_alpha
#' @template param_direction
#' @template details_options
#' @family ggplot2 functions.
#' @export
#'
#' @examples
#' if (requireNamespace(
#'       c("palmerpenguins", "tidyr", "ggplot2"),
#'       quiet = TRUE
#'     )
#'    ) {
#'   library(ggplot2)
#'   library(palmerpenguins)
#'   library(tidyr)
#'
#'   penguins |>
#'     drop_na(bill_length_mm, species) |>
#'     ggplot(aes(x = species, y = bill_length_mm, fill = species)) +
#'     geom_boxplot(outlier.color = get_brand_color("red")) +
#'     geom_jitter(width = 0.2, alpha = 0.1) +
#'     scale_fill_brand_d(alpha = 0.5) +
#'     labs(
#'       x = "Species",
#'       y = "Bill Length (mm)",
#'       fill = "Species"
#'     ) +
#'     theme_bw()
#' }
#'
#' if (requireNamespace(
#'       c("palmerpenguins", "tidyr", "ggplot2"),
#'       quiet = TRUE
#'     )
#'    ) {
#'   library(ggplot2)
#'   library(palmerpenguins)
#'   library(tidyr)
#'
#'   penguins |>
#'   drop_na(flipper_length_mm, species) |>
#'     ggplot(aes(x = flipper_length_mm, fill = species)) +
#'       geom_histogram(alpha = 0.5, bins = 30, position = "identity") +
#'       scale_fill_brand_d() +
#'       labs(
#'         x = "Flipper Length (mm)",
#'         y = "Frequency",
#'         fill = "Species"
#'       ) +
#'       theme_bw()
#' }
#'
#' if (requireNamespace(
#'       c("palmerpenguins", "tidyr", "ggplot2"),
#'       quiet = TRUE
#'     )
#'    ) {
#'   library(ggplot2)
#'   library(palmerpenguins)
#'   library(tidyr)
#'
#'   penguins |>
#'     drop_na(flipper_length_mm, body_mass_g, species) |>
#'     ggplot(
#'       aes(
#'         x = flipper_length_mm,
#'         y = body_mass_g,
#'         color = species,
#'         shape = species
#'       )
#'     ) +
#'     geom_point(size = 2) +
#'     geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
#'     scale_color_brand_d() +
#'     labs(
#'       x = "Flipper Length (mm)",
#'       y = "Body Mass (g)",
#'       color = "Species",
#'       shape = "Species"
#'     ) +
#'     theme_bw()
#' }
#'
#' if (requireNamespace("ggplot2", quiet = TRUE)) {
#'   library(ggplot2)
#'
#'   faithfuld |>
#'     ggplot(aes(waiting, eruptions, fill = density)) +
#'     geom_raster() +
#'     scale_fill_brand_b() +
#'     labs(
#'       x = "Waiting Time to Next Eruption (min)",
#'       y = "Eruption Time (min)",
#'       fill = "Density"
#'     ) +
#'     theme_bw()
#' }
#'
#' if (requireNamespace("ggplot2", quiet = TRUE)) {
#'   library(ggplot2)
#'   library(hexbin)
#'
#'   data.frame(x = runif(10000), y = runif(10000)) |>
#'     ggplot(aes(x, y)) +
#'     geom_hex() +
#'     coord_fixed() +
#'     scale_fill_brand_c() +
#'     labs(fill = "") +
#'     theme_bw()
#' }
scale_brand <- function(
    aesthetics = "color", #nolint
    scale_type = "c",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    na.value = NA, # Must follow ggplot2 arg names. # "grey50" #nolint
    reverse = FALSE,
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
  checkmate::assert_number(alpha, lower = 0, upper = 1, null.ok = TRUE)
  checkmate::assert_string(na.value, na.ok = TRUE)
  if (!is.na(na.value)) assert_color(na.value)
  checkmate::assert_flag(reverse)

  if (color_type %in% c("seq", "sequential")) {
    palette <- function(x) {
      color_brand_sequential(x, alpha = alpha, direction = direction)
    }
  } else if (color_type %in% c("div", "diverging")) {
    palette <- function (x) {
      color_brand_diverging(x, alpha = alpha, direction = direction)
    }
  } else if (color_type %in% c("qual", "qualitative")) {
    palette <- function(x) {
      color_brand_qualitative(x, alpha = alpha, direction = direction)
    }
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
    color_type = "qual",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_color_brand_c <- function(
    aesthetics = "color", #nolint
    scale_type = "c",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_color_brand_b <- function(
    aesthetics = "color", #nolint
    scale_type = "b",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
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
    color_type = "qual",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_fill_brand_c <- function(
    aesthetics = "fill", #nolint
    scale_type = "c",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
}

#' @rdname scale_brand
#' @export
scale_fill_brand_b <- function(
    aesthetics = "fill", #nolint
    scale_type = "b",
    color_type = "seq",
    alpha = NULL,
    direction = 1,
    ...
  ) {
  do.call("scale_brand", grab_fun_par())
}
