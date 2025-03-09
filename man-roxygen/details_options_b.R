#' @details
#'
#' ## Path to `_brand.yml`
#'
#' `brandr` will always look for a `_brand.yml` file in the root directory of
#' your project. If the file is not found, an error message will be displayed.
#' You can also set the path to the file manually using the
#' [`options()`][base::options] function:
#'
#' ```r
#' options(BRANDR_BRAND_YML = "PATH_TO_BRAND.YML")
#' ```
