# brandr <a href = "https://danielvartan.github.io/brandr/"><img src = "man/figures/logo.png" align="right" width="120" /></a>

<!-- quarto render -->

<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check.yaml](https://github.com/danielvartan/brandr/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/danielvartan/brandr/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/danielvartan/brandr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/danielvartan/brandr?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/license/mit)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://www.contributor-covenant.org/version/2/1/code_of_conduct/)
<!-- badges: end -->

## Overview

`brandr` is an R package designed to facilitate brand identity
management using the [brand.yml](https://posit-dev.github.io/brand-yml/)
standard. It provides functions to consistently access and apply brand
colors, typography, and other visual elements across your R projects.

Unlike [Posit](https://posit.co/)’s
[`thematic`](https://rstudio.github.io/thematic/) package, `brandr`
offers more refined control over brand assets.

**Please note that `brandr` is not affiliated with
[Posit](https://posit.co/)**.

## Installation

You can install the released version of `brandr` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("brandr")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("danielvartan/brandr")
```

## Usage

`brandr` is equipped with several functions to help you use your
`_brand.yml` file, like:

- `color_brand_sequential()`, `color_brand_diverging()`,
  `color_brand_qualitative()`: Create scales with your brand colors
- `scale_brand()`, `scale_color_brand_d()`, `scale_color_brand_c()`,
  `scale_color_brand_b()`, `scale_fill_brand_d()`,
  `scale_fill_brand_c()`, `scale_fill_brand_b()`: Discrete, continuous,
  and binned brand color scales for
  [`ggplot2`](https://ggplot2.tidyverse.org/)
- `get_brand_color()`: Get a brand color by name (e.g., primary)
- `get_brand_color_tint()`: Get a brand color tint
- `get_brand_color_mix()`: Get a mix of brand colors
- `get_brand_font()`: Get a brand font by name (e.g., headings)

Example:

``` r
library(brandr)
library(ggplot2)
library(palmerpenguins)

penguins |>
  ggplot(aes(x = flipper_length_mm, fill = species)) +
    geom_histogram(alpha = 0.5, position = "identity") +
    scale_fill_brand_d() +
    labs(
      x = "Flipper Length (mm)",
      y = "Frequency",
      fill = "Species"
    )
```

![](man/figures/readme-figure-1.png)

## Configuration

### Path to `_brand.yml`

`brandr` will always look for a `_brand.yml` file in the root directory
of your project. If the file is not found, an error message will be
displayed. You can also set the path to the file manually using the
`options()` function:

``` r
options(BRANDR_BRAND_YML = "PATH_TO_BRAND.YML")
```

### Brand Color Scales

To control the colors of each brand color scale, assign hexadecimal
color codes in a `character` vector to the following options:

- `BRANDR_COLOR_SEQUENTIAL`: For sequential color scales
- `BRANDR_COLOR_DIVERGING`: For diverging color scales
- `BRANDR_COLOR_QUALITATIVE`: For qualitative color scales

You can use `get_brand_color()` to get the hexadecimal color codes from
the `_brand.yml` file.

Example:

``` r
options(
 BRANDR_COLOR_SEQUENTIAL =
   get_brand_color(c("primary", "secondary")),
 BRANDR_COLOR_DIVERGING =
   get_brand_color(c("primary", "white", "secondary")),
 BRANDR_COLOR_QUALITATIVE =
   get_brand_color(c("primary", "secondary", "tertiary"))
)
```

## Setting Brand Fonts/Typefaces

Currently, `brandr` does not support the use of custom fonts directly.
This feature is planned for future releases.

In the meantime, you can use Yixuan Qiu’s
[`showtext`](https://doi.org/10.32614/CRAN.package.showtext) R package
to apply custom fonts/typefaces to your plots.

Below is an example of how to use the Google Font [Open
Sans](https://fonts.google.com/specimen/Open+Sans) in all of your plots.
This example assumes that the font files are located in a `ttf` folder
within your project directory.

``` r
library(brandr)
library(ggplot2)
library(here)
library(sysfonts)
library(showtext)

font_paths(here("ttf"))

font_add(
  family = "open-sans",
  regular = here("ttf", "opensans-regular.ttf"),
  bold = here("ttf", "opensans-bold.ttf"),
  italic = here("ttf", "opensans-italic.ttf"),
  bolditalic = here("ttf", "opensans-bolditalic.ttf"),
  symbol = NULL
)

showtext_auto()

theme_set(
  theme(
    text = element_text(
      color = get_brand_color("black"),
      family = "open-sans",
      face = "plain"
    )
  )
)
```

## License

[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/license/mit)

`brandr` code is released under the [MIT
license](https://opensource.org/license/mit).

## Contributing

Contributions are welcome, including bug reports. Take a moment to
review the [Guidelines for
Contributing](https://danielvartan.github.io/brandr/CONTRIBUTING.html).

<br>

Become a `brandr` supporter!

Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please indicate the `brandr` package in your donation message.
