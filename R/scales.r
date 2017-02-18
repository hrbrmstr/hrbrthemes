# Stolen from ggplot2
is.waive <- function (x) { inherits(x, "waiver") }
is.sec_axis <- function (x) { inherits(x, "AxisSecondary") }
is.formula <- function (x) { inherits(x, "formula") }

#' X & Y scales with opinionated pre-sets for percent & comma label formats
#'
#' The `_comma` ones set comma format for axis text and `expand=c(0,0)` (you need to set limits).
#'
#' The `_percent` ones set precent format for axis text and `expand=c(0,0)` (you need to set limits).
#'
#' @md
#' @inheritParams ggplot2::scale_x_continuous
#' @export
scale_x_percent <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                             labels = scales::percent, limits = NULL, expand = c(0,0), oob = censor,
                             na.value = NA_real_, trans = "identity", position = "bottom",
                             sec.axis = waiver()) {
  sc <- ggplot2::continuous_scale(c("x", "xmin", "xmax", "xend", "xintercept",
                           "xmin_final", "xmax_final", "xlower", "xmiddle", "xupper"),
                         "position_c", identity, name = name, breaks = breaks,
                         minor_breaks = minor_breaks, labels = labels, limits = limits,
                         expand = expand, oob = oob, na.value = na.value, trans = trans,
                         guide = "none", position = position, super = ScaleContinuousPosition)
  if (!is.waive(sec.axis)) {
    if (is.formula(sec.axis))
      sec.axis <- sec_axis(sec.axis)
    if (!is.sec_axis(sec.axis))
      stop("Secondary axes must be specified using 'sec_axis()'")
    sc$secondary.axis <- sec.axis
  }
  sc
}

#' @rdname scale_x_percent
#' @export
scale_y_percent <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                             labels = scales::percent, limits = NULL, expand = c(0,0), oob = censor,
                             na.value = NA_real_, trans = "identity", position = "left",
                             sec.axis = waiver()) {
    sc <- ggplot2::continuous_scale(c("y", "ymin", "ymax", "yend", "yintercept",
        "ymin_final", "ymax_final", "lower", "middle", "upper"),
        "position_c", identity, name = name, breaks = breaks,
        minor_breaks = minor_breaks, labels = labels, limits = limits,
        expand = expand, oob = oob, na.value = na.value, trans = trans,
        guide = "none", position = position, super = ScaleContinuousPosition)
    if (!is.waive(sec.axis)) {
        if (is.formula(sec.axis))
            sec.axis <- ggplot2::sec_axis(sec.axis)
        if (!is.sec_axis(sec.axis))
            stop("Secondary axes must be specified using 'sec_axis()'")
        sc$secondary.axis <- sec.axis
    }
    sc
}

#' @rdname scale_x_percent
#' @export
scale_x_comma <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                             labels = scales::comma, limits = NULL, expand = c(0,0), oob = censor,
                             na.value = NA_real_, trans = "identity", position = "bottom",
                             sec.axis = waiver()) {
  sc <- ggplot2::continuous_scale(c("x", "xmin", "xmax", "xend", "xintercept",
                           "xmin_final", "xmax_final", "xlower", "xmiddle", "xupper"),
                         "position_c", identity, name = name, breaks = breaks,
                         minor_breaks = minor_breaks, labels = labels, limits = limits,
                         expand = expand, oob = oob, na.value = na.value, trans = trans,
                         guide = "none", position = position, super = ScaleContinuousPosition)
  if (!is.waive(sec.axis)) {
    if (is.formula(sec.axis))
      sec.axis <- ggplot2::sec_axis(sec.axis)
    if (!is.sec_axis(sec.axis))
      stop("Secondary axes must be specified using 'sec_axis()'")
    sc$secondary.axis <- sec.axis
  }
  sc
}


#' @rdname scale_x_percent
#' @export
scale_y_comma <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                             labels = scales::comma, limits = NULL, expand = c(0,0), oob = censor,
                             na.value = NA_real_, trans = "identity", position = "left",
                             sec.axis = waiver()) {
    sc <- ggplot2::continuous_scale(c("y", "ymin", "ymax", "yend", "yintercept",
        "ymin_final", "ymax_final", "lower", "middle", "upper"),
        "position_c", identity, name = name, breaks = breaks,
        minor_breaks = minor_breaks, labels = labels, limits = limits,
        expand = expand, oob = oob, na.value = na.value, trans = trans,
        guide = "none", position = position, super = ScaleContinuousPosition)
    if (!is.waive(sec.axis)) {
        if (is.formula(sec.axis))
            sec.axis <- ggplot2::sec_axis(sec.axis)
        if (!is.sec_axis(sec.axis))
            stop("Secondary axes must be specified using 'sec_axis()'")
        sc$secondary.axis <- sec.axis
    }
    sc
}