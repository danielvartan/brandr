# brandr <a href = "https://danielvartan.github.io/brandr/"><img src = "man/figures/hex-logo.svg" align="right" width="135" /></a>

<!-- quarto render -->

<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check.yaml](https://github.com/danielvartan/brandr/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/danielvartan/brandr/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/danielvartan/brandr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/danielvartan/brandr?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)
<!-- badges: end -->

## Overview

👁️🎨🌈🔠🆎🔠🔡🔤📐✒️🖋️🖌️🖍️💭📢🎯💡📱🖥️🖨️🎪🎭🚀💼✨🌟

`brandr` is an R package designed to facilitate brand identity
management using the [brand.yml](https://posit-dev.github.io/brand-yml/)
standard, providing functions to consistently access and apply brand
colors, typography, and other visual elements across your R projects.

Please note that `brandr` **is not affiliated with
[Posit](https://posit.co/)**.

## Installation

You can install `brandr` using the
[`remotes`](https://github.com/r-lib/remotes) package:

``` r
remotes::install_github("danielvartan/brandr")
```

## Usage

`brandr` is equipped with several functions to help you use your
`_brand.yml` file. Like:

- `color_brand_sequential()`, `color_brand_diverging()`,
  `color_brand_qualitative()`: Brand color functions
- `scale_brand()`, `scale_color_brand_d()`, `scale_color_brand_c()`,
  `scale_color_brand_b()`, `scale_fill_brand_d()`,
  `scale_fill_brand_c()`, `scale_fill_brand_b()`:
  [`ggplot2`](https://ggplot2.tidyverse.org/) scales for brand colors
- `get_brand_color()`: Get a brand color by name
- `get_brand_color_tint()`: Get a brand color tint by name
- `get_brand_color_mix()`: Get a mix of brand colors
- `get_brand_font()`: Get a brand font by name

Example:

``` r
get_brand_color(c("primary", "red", "dark"))
```

    [1] "#DA4E3C" "#DA4E3C" "#35131F"

## License

[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/license/mit/)

`brandr` code is released under the [MIT
license](https://opensource.org/license/mit/).

## Contributing

We welcome contributions, including bug reports. Take a moment to review
our [Guidelines for
Contributing](https://danielvartan.github.io/brandr/CONTRIBUTING.html).

<br>

Become an `brandr` supporter!

Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please indicate the `brandr` package in your donation message.
