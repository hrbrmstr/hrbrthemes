#' Color Utilities for hrbrthemes
#'
#' Internal helper functions for color palette operations.
#'
#' @keywords internal

#' Create Continuous Color Scale
#'
#' Internal function to generate continuous color scales from a vector of colors
#'
#' @param colors Vector of hex color codes
#' @return A color ramp palette function
#' @keywords internal
create_continuous_scale <- function(colors) {
  colorRampPalette(colors)
}

#' Validate Palette Name
#'
#' Checks if a palette name is valid and aborts with a helpful error if not.
#'
#' @param palette The palette name to validate
#' @param valid A character vector of valid palette names
#' @keywords internal
validate_palette <- function(palette, valid) {
  if (!palette %in% valid) {
    stop(paste0("palette must be one of: ", paste(valid, collapse = ", ")), call. = FALSE)
  }
}

#' Validate Direction Parameter
#'
#' Checks if direction is 1 or -1 and aborts with a helpful error if not.
#'
#' @param direction The direction parameter to validate
#' @keywords internal
validate_direction <- function(direction) {
  if (!direction %in% c(1, -1)) {
    stop("direction must be 1 or -1", call. = FALSE)
  }
}
