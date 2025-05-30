% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_brand.R
\name{get_brand_color}
\alias{get_brand_color}
\title{Get brand colors}
\usage{
get_brand_color(color, alpha = NULL)
}
\arguments{
\item{color}{A \code{\link[base:character]{character}} vector indicating the name of
colors present in the \code{color} section of the \verb{_brand.yml} file.}

\item{alpha}{(Optional) A number between \code{0} and \code{1}, indicating the
transparency of the colors (Default: \code{NULL}).}
}
\value{
A \code{\link[base:character]{character}} vector with
\href{https://en.wikipedia.org/wiki/Web_colors}{hexadecimal} color codes.
}
\description{
\code{get_brand_color()} retrieves color codes from the \verb{_brand.yml} file.
}
\details{
\subsection{Path to \verb{_brand.yml}}{

\code{brandr} will always look for a \verb{_brand.yml} file in the root directory of
your project. If the file is not found, an error message will be displayed.
You can also set the path to the file manually using the
\code{\link[base:options]{options()}} function:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{options(BRANDR_BRAND_YML = "PATH_TO_BRAND.YML")
}\if{html}{\out{</div>}}
}
}
\examples{
get_brand_color("primary")
#> [1] "#DA4E3C" # Expected

get_brand_color("secondary")
#> [1] "#390963" # Expected

get_brand_color("tertiary")
#> [1] "#FB9706" # Expected

get_brand_color("tertiary", alpha = 0.5)
#> [1] "#FB970680" # Expected

get_brand_color(c("primary", "secondary"))
#> [1] "#DA4E3C" "#390963" # Expected

get_brand_color(c("red", "purple", "orange"))
#> [1] "#DA4E3C" "#390963" "#F06F20" # Expected
}
\seealso{
Other utility functions: 
\code{\link{get_brand_color_mix}()},
\code{\link{get_brand_color_tint}()},
\code{\link{get_brand_font}()}
}
\concept{utility functions}
