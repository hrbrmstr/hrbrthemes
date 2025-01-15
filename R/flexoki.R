#' Flexoki Color Palettes and Scales
#'
#' @description
#' Color palettes and scales based on the Flexoki color scheme, a warm and soft color system
#' designed by Steph Ango. Flexoki emphasizes readability and natural color harmony, making
#' it particularly suitable for data visualization and long-form reading. The palette includes
#' both light and dark variants, with each offering 8 distinct colors.
#'
#' The name "Flexoki" combines "flexible" and "karaoke", reflecting its adaptable nature
#' and harmonious color relationships.
#'
#' @name flexoki
#' @details
#' The package provides several types of scales:
#' * Discrete scales for both light and dark variants
#' * Continuous scales with extended color ramps
#'
#' The color palette includes:
#' * Red: For emphasis and warnings
#' * Orange: For secondary emphasis
#' * Yellow: For highlighting
#' * Green: For success states and nature-related data
#' * Cyan: For information and water-related data
#' * Blue: For primary elements and cool tones
#' * Purple: For luxury and depth
#' * Magenta: For creative and feminine contexts
#'
#' @param ... Additional arguments passed to scale_color_manual() or scale_fill_manual()
#' @param palette For continuous scales, the name of the color palette to use
#'        (one of "red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta")
#'
#' @return A ggplot2 scale object
#'
#' @examples
#' library(ggplot2)
#'
#' # Discrete color scale (light variant)
#' ggplot(mpg, aes(class, fill = class)) +
#'   geom_bar() +
#'   scale_fill_flexoki_light()
#'
#' # Continuous color scale
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_fill_flexoki_continuous(palette = "blue")
#'
#' @references
#' Flexoki Color System: https://stephango.com/flexoki
#'
#' @importFrom ggplot2 scale_color_manual scale_fill_manual scale_color_gradientn scale_fill_gradientn
NULL

#' Flexoki Light Color Palette
#'
#' A vector of 8 colors in the light variant of the Flexoki color scheme
#'
#' @format A named character vector of hex color codes
#' @export
flexoki_light <- c(
  red = "#D14D41", orange = "#DA702C", yellow = "#D0A215",
  green = "#879A39", cyan = "#3AA99F", blue = "#4385BE",
  purple = "#8B7EC8", magenta = "#CE5D97"
)

#' Flexoki Dark Color Palette
#'
#' A vector of 8 colors in the dark variant of the Flexoki color scheme
#'
#' @format A named character vector of hex color codes
#' @export
flexoki_dark <- c(
  red = "#AF3029", orange = "#BC5215", yellow = "#AD8301",
  green = "#66800B", cyan = "#24837B", blue = "#205EA6",
  purple = "#5E409D", magenta = "#A02F6F"
)

#' Discrete Color Scale Using Flexoki Light Colors
#'
#' @param ... Additional arguments passed to scale_color_manual()
#' @return A discrete ggplot2 color scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'   geom_point() +
#'   scale_color_flexoki_light()
scale_color_flexoki_light <- function(...) {
  scale_color_manual(values = unname(flexoki_light), ...)
}

#' Discrete Fill Scale Using Flexoki Light Colors
#'
#' @param ... Additional arguments passed to scale_fill_manual()
#' @return A discrete ggplot2 fill scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
#'   geom_bar() +
#'   scale_fill_flexoki_light()
scale_fill_flexoki_light <- function(...) {
  scale_fill_manual(values = unname(flexoki_light), ...)
}

#' Discrete Color Scale Using Flexoki Dark Colors
#'
#' @param ... Additional arguments passed to scale_color_manual()
#' @return A discrete ggplot2 color scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'   geom_point() +
#'   scale_color_flexoki_dark()
scale_color_flexoki_dark <- function(...) {
  scale_color_manual(values = unname(flexoki_dark), ...)
}

#' Discrete Fill Scale Using Flexoki Dark Colors
#'
#' @param ... Additional arguments passed to scale_fill_manual()
#' @return A discrete ggplot2 fill scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
#'   geom_bar() +
#'   scale_fill_flexoki_dark()
scale_fill_flexoki_dark <- function(...) {
  scale_fill_manual(values = unname(flexoki_dark), ...)
}

#' Extended Flexoki Color Palettes
#'
#' A list of 8 color palettes, each containing 13 shades for continuous color interpolation
#'
#' @format A list of character vectors containing hex color codes
#' @export
flexoki_extended <- list(
  red = c(
    "#FFE1D5", "#FFCABB", "#FDB2A2", "#F89A8A", "#E8705F", "#D14D41",
    "#C03E35", "#AF3029", "#942822", "#6C201C", "#551B18", "#3E1715", "#261312"
  ),
  orange = c(
    "#FFE7CE", "#FED3AF", "#FCC192", "#F9AE77", "#EC8B49", "#DA702C",
    "#CB6120", "#BC5215", "#9D4310", "#71320D", "#59290D", "#40200D", "#27180E"
  ),
  yellow = c(
    "#FAEEC6", "#F6E2A0", "#F1D67E", "#ECCB60", "#DFB431", "#D0A215",
    "#BE9207", "#AD8301", "#8E6B01", "#664D01", "#503D02", "#3A2D04", "#241E08"
  ),
  green = c(
    "#EDEECF", "#DDE2B2", "#CDD597", "#BEC97E", "#A0AF54", "#879A39",
    "#768D21", "#66800B", "#536907", "#3D4C07", "#313D07", "#252D09", "#1A1E0C"
  ),
  cyan = c(
    "#DDF1E4", "#BFE8D9", "#A2DECE", "#87D3C3", "#5ABDAC", "#3AA99F",
    "#2F968D", "#24837B", "#1C6C66", "#164F4A", "#143F3C", "#122F2C", "#101F1D"
  ),
  blue = c(
    "#E1ECEB", "#C6DDE8", "#ABCFE2", "#92BFDB", "#66A0C8", "#4385BE",
    "#3171B2", "#205EA6", "#1A4F8C", "#163B66", "#133051", "#12253B", "#101A24"
  ),
  purple = c(
    "#F0EAEC", "#E2D9E9", "#D3CAE6", "#C4B9E0", "#A699D0", "#8B7EC8",
    "#735EB5", "#5E409D", "#4F3685", "#3C2A62", "#31234E", "#261C39", "#1A1623"
  ),
  magenta = c(
    "#FEE4E5", "#FCCFDA", "#F9B9CF", "#F4A4C2", "#E47DA8", "#CE5D97",
    "#B74583", "#A02F6F", "#87285E", "#641F46", "#4F1B39", "#39172B", "#24131D"
  )
)

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

#' Continuous Color Scale Using Flexoki Colors
#'
#' @param palette Name of the color palette to use ("red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta")
#' @param ... Additional arguments passed to scale_color_gradientn()
#' @return A continuous ggplot2 color scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_color_flexoki_continuous(palette = "blue")
scale_color_flexoki_continuous <- function(palette = "red", ...) {
  scale_color_gradientn(colors = create_continuous_scale(flexoki_extended[[palette]])(100), ...)
}

#' Continuous Fill Scale Using Flexoki Colors
#'
#' @param palette Name of the color palette to use ("red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta")
#' @param ... Additional arguments passed to scale_fill_gradientn()
#' @return A continuous ggplot2 fill scale
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_fill_flexoki_continuous(palette = "blue")
scale_fill_flexoki_continuous <- function(palette = "red", ...) {
  scale_fill_gradientn(colors = create_continuous_scale(flexoki_extended[[palette]])(100), ...)
}
