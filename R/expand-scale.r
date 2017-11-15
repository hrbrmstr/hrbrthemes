#' Generate expansion vector for scales.
#'
#' This is a convenience function for generating scale expansion vectors
#' for the \code{expand} argument of
#' \code{scale_x_continuous} and \code{scale_x_discrete}.
#' The expansions vectors are used to add some space between
#' the data and the axes.
#'
#' @name expand_scale
#' @export
#' @param mult vector of multiplicative range expansion factors.
#'   If length 1, both the lower and upper limits of the scale
#'   are expanded outwards by \code{mult}. If length 2, the lower limit
#'   is expanded by \code{mult[1]} and the upper limit by \code{mult[2]}.
#' @param add vector of additive range expansion constants.
#'   If length 1, both the lower and upper limits of the scale
#'   are expanded outwards by \code{add} units. If length 2, the
#'   lower limit is expanded by \code{add[1]} and the upper
#'   limit by \code{add[2]}.
NULL