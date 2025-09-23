#  TO DO: Create conditional options.

default_options <- function(option) {
  brandr_options <- list(
    "BRANDR_BRAND_YML" = here::here("_brand.yml"),
    "BRANDR_COLOR_SEQUENTIAL" =
      get_brand_color(c("secondary", "primary", "tertiary")),
    "BRANDR_COLOR_DIVERGING" =
      get_brand_color(c("secondary", "white", "tertiary")),
    "BRANDR_COLOR_QUALITATIVE" =
      get_brand_color(c("primary", "secondary", "tertiary"))
  )

  brandr_options[[option]]
}

get_default_brandr_color_type <- function(type) {
  # See: https://ggplot2.tidyverse.org/reference/scale_brewer.html
  type_choices <- c(
    "seq", "sequential",
    "div", "diverging",
    "qual", "qualitative"
  )

  checkmate::assert_choice(type, type_choices)

  switch(
    type,
    "seq" = default_options("BRANDR_COLOR_SEQUENTIAL"),
    "sequential" = default_options("BRANDR_COLOR_SEQUENTIAL"),
    "div" = default_options("BRANDR_COLOR_DIVERGING"),
    "diverging" = default_options("BRANDR_COLOR_DIVERGING"),
    "qual" = default_options("BRANDR_COLOR_QUALITATIVE"),
    "qualitative" = default_options("BRANDR_COLOR_QUALITATIVE")
  )
}
