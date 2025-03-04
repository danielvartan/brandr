% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interpolate_colors.R
\name{interpolate_colors}
\alias{interpolate_colors}
\title{Interpolate colors}
\usage{
interpolate_colors(
  n,
  colors = getOption("BRANDR_COLOR_SEQUENTIAL"),
  type = "seq",
  direction = 1,
  ...
)
}
\arguments{
\item{n}{This parameter accepts two types of inputs:
\itemize{
\item If the value is an integer number and \code{type} is \code{seq} or \code{div}, the
function will return a discrete color spectrum with \code{n} colors.
\item if the value is an integer number and \code{type} is \code{qual}, the function
will return \code{n} colors from the \code{colors} parameter, in the same order,
repeating them, if necessary.
\item If the value is a \code{\link[base:numeric]{numeric}} vector between \code{0} and \code{1},
the function will return the color positions at \code{n} considering a
continuous color spectrum ranging from \code{0} to \code{1}.
}}

\item{colors}{(Optional) A \code{\link[base:character]{character}} vector of colors
to use in the scale. If \code{NULL}, \code{brandr} will try to choose the colors
based on the \code{type} argument.}

\item{type}{(Optional) A \code{\link[base:character]{character}} string indicating
the type of color scale: \code{"seq"}/\verb{"sequential"``, }"div"\code{/}"diverging"``, or \code{"qual"}/`"qualitative"` (Default: `c `).}

\item{direction}{(Optional) Sets the order of colors in the scale. If \code{1}
colors are as output by the palette function. If \code{-1}, the order of
colors is reversed (Default: \code{1}).}

\item{...}{Additional arguments passed to
\code{\link[grDevices:colorRamp]{colorRampPalette()}} when creating the
color ramp. Only valid when type is \code{seq} or \code{div}.}
}
\value{
A \code{\link[base:character]{character}} vector with hexadecimal color
codes.
}
\description{
\code{interpolate_colors()} interpolate colors for sequential, diverging,
and qualitative color scales.
}
\details{
\subsection{Path to \verb{_brand.yml}}{

\code{brandr} will always look for the \verb{_brand.yml} file in the root directory of
your project. If the file is not found, an error message will be displayed.
You can also set the path to the file manually using the
\code{\link[base:options]{options()}} function:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{options(BRANDR_BRAND_YML = [PATH TO _brand.yml])
}\if{html}{\out{</div>}}
}

\subsection{Brand color scales}{

To control the colors for each brand color scale, assign the desired
hexadecimal color codes in a \code{\link[base:character]{character}} vector to the
following options:
\itemize{
\item \code{BRANDR_COLOR_SEQUENTIAL}: For sequential color scales
\item \code{BRANDR_COLOR_DIVERGING}:  For diverging color scales
\item \code{BRANDR_COLOR_QUALITATIVE}: For qualitative color scales
}

Use \code{\link[=get_brand_color]{get_brand_color()}} to get the hexadecimal
color codes from the \verb{_brand.yml} file.

Example:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{options(
  BRANDR_BRAND_YML = here::here("_brand.yml"),
  BRANDR_COLOR_SEQUENTIAL =
    get_brand_color(c("primary", "secondary")),
  BRANDR_COLOR_DIVERGING =
    get_brand_color(c("primary", "white", "secondary")),
  BRANDR_COLOR_QUALITATIVE =
    get_brand_color(c("primary", "secondary", "tertiary"))
)
}\if{html}{\out{</div>}}
}
}
\examples{
interpolate_colors(3, color = c("red", "blue"), type = "seq")
#> [1] "#FF0000" "#7F007F" "#0000FF" # Expected

# Same results of `type = "seq"`
interpolate_colors(3, color = c("red", "white", "blue"), type = "div")
#> [1] "#FF0000" "#FFFFFF" "#0000FF" # Expected

interpolate_colors(3, color = c("red", "blue"), type = "qual")
#> [1] "red"  "blue" "red" # Expected

interpolate_colors(3, color = c("red", "blue"), type = "seq", direction = -1)
#> [1] "#0000FF" "#7F007F" "#FF0000" # Expected

interpolate_colors(3, color = c("red", "blue"), type = "seq", bias = 100)
#> [1] "#FF0000" "#7F007F" "#0000FF" # Expected
}
\seealso{
Other color functions.: 
\code{\link{color_brand_sequential}()}
}
\concept{color functions.}
