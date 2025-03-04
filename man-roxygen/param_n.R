#' @param n This parameter accepts two types of inputs:
#'   - If the value is an integer number and `type` is `seq` or `div`, the
#'     function will return a discrete color spectrum with `n` colors.
#'   - if the value is an integer number and `type` is `qual`, the function
#'     will return `n` colors from the `colors` parameter, in the same order,
#'     repeating them, if necessary.
#'   - If the value is a [`numeric`][base::numeric] vector between `0` and `1`,
#'     the function will return the color positions at `n` considering a
#'     continuous color spectrum ranging from `0` to `1`.
