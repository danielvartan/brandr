## Based on: https://github.com/hadley/r4ds/blob/main/_common.R

# Load packages -----

# Related to './R/.post-render.R'
library(downlit)
library(beepr)
library(cffr)
library(codemetar)
library(fs)
library(ggplot2)
library(groomr) # https://github.com/danielvartan/groomr
library(here)
library(httpgd)
library(magrittr)
library(ragg)
library(readr)
library(rlang)
library(rutils) # https://github.com/danielvartan/rutils
library(stringr)
library(showtext)
library(sysfonts)
library(xml2)
# library(yaml)

# Set general options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> Comment
)

# Set variables -----

set.seed(2025)

# Set knitr -----

knitr::clean_cache() |> rutils::shush()

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here::here(),
  dev = "ragg_png",
  # dev.args = list(bg = "transparent"),
  fig.showtext = TRUE
)

# Set and load graph fonts -----

sysfonts::font_paths(here::here("ttf")) |> invisible()

sysfonts::font_add(
  family = "rubik",
  regular = here::here("ttf", "rubik-regular.ttf"),
  bold = here::here("ttf", "rubik-bold.ttf"),
  italic = here::here("ttf", "rubik-italic.ttf"),
  bolditalic = here::here("ttf", "rubik-bolditalic.ttf"),
  symbol = NULL
)

sysfonts::font_add(
  family = "open-sans",
  regular = here::here("ttf", "opensans-regular.ttf"),
  bold = here::here("ttf", "opensans-bold.ttf"),
  italic = here::here("ttf", "opensans-italic.ttf"),
  bolditalic = here::here("ttf", "opensans-bolditalic.ttf"),
  symbol = NULL
)

sysfonts::font_add(
  family = "ibm-plex-mono",
  regular = here::here("ttf", "ibmplexmono-regular.ttf"),
  bold = here::here("ttf", "ibmplexmono-bold.ttf"),
  italic = here::here("ttf", "ibmplexmono-italic.ttf"),
  bolditalic = here::here("ttf", "ibmplexmono-bolditalic.ttf"),
  symbol = NULL
)

showtext::showtext_auto()

# Set `ggplot2` theme -----

ggplot2::theme_set(
  ggplot2::theme_bw() +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = brandr::get_brand_color("black"),
        family = "open-sans",
        face = "plain"
      ),
    #   panel.background = ggplot2::element_rect(fill = "transparent"),
    #   plot.background = ggplot2::element_rect(
    #     fill = "transparent", color = NA
    #   ),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
    #   legend.background = ggplot2::element_rect(fill = "transparent"),
    #   legend.box.background = ggplot2::element_rect(
    #     fill = "transparent", color = NA
    #   ),
      legend.frame = ggplot2::element_blank(),
      legend.ticks = ggplot2::element_line(color = "white")
    )
)
