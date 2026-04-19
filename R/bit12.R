#' Bit12 Color Palettes and Scales
#'
#' @description
#' Color palettes and scales based on the Bit12 color scheme, a vibrant 12-color system
#' designed for clear data visualization. The palette offers a complete spectrum of
#' distinct colors that work well for categorical data while maintaining good contrast
#' and accessibility.
#'
#' @name bit12_scale
#' @details
#' The package provides several types of scales:
#' * Discrete scales for categorical data
#' * Continuous scales with extended color ramps
#'
#' The color palette includes:
#' * Plum: Deep purple for emphasis
#' * Rose: Rich pink-red for highlighting important elements
#' * Coral: Soft reddish-orange for warm secondary elements
#' * Apricot: Muted orange for highlighting
#' * Lemon: Bright yellow for high visibility elements
#' * Lime: Fresh green for positive values and growth
#' * Mint: Cool green-blue for calm elements
#' * Teal: Balanced blue-green for neutral data
#' * Sky: Light blue for information elements
#' * Azure: Clear blue for primary interactions
#' * Cobalt: Deep blue for stability and reliability
#' * Violet: Purple for creative and distinctive elements
#'
#' @param ... Additional arguments passed to scale_color_manual(), scale_fill_manual(), scale_color_gradientn(), or scale_fill_gradientn()
#' @param palette For continuous scales, the name of the color palette to use
#'        (one of "plum", "rose", "coral", "apricot", "lemon", "lime", "mint", "teal", "sky", "azure", "cobalt", "violet")
#' @param direction Sets the direction of the color scale (1 = default, -1 = reversed)
#'
#' @return A ggplot2 scale object
#'
#' @examples
#' library(ggplot2)
#'
#' # Discrete color scale
#' ggplot(mpg, aes(class, fill = class)) +
#'   geom_bar() +
#'   scale_fill_bit12()
#'
#' # Continuous color scale
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_fill_bit12_continuous(palette = "azure")
#'
#' @importFrom ggplot2 scale_color_manual scale_fill_manual scale_color_gradientn scale_fill_gradientn
NULL

#' Bit12 Color Palette
#'
#' A vector of 12 colors in the Bit12 color scheme
#'
#' @format A named character vector of hex color codes
#' @export
bit12 <- c(
  plum = "#817",
  rose = "#a35",
  coral = "#c66",
  apricot = "#e94",
  lemon = "#ed0",
  lime = "#9d5",
  mint = "#4d8",
  teal = "#2cb",
  sky = "#0bc",
  azure = "#09c",
  cobalt = "#36b",
  violet = "#639"
)

.valid_bit12_palettes <- c("plum", "rose", "coral", "apricot", "lemon", "lime", "mint", "teal", "sky", "azure", "cobalt", "violet")

#' @name bit12_scale
#' @export
scale_color_bit12 <- function(...) {
  scale_color_manual(values = unname(bit12), ...)
}

#' @name bit12_scale
#' @export
scale_fill_bit12 <- function(...) {
  scale_fill_manual(values = unname(bit12), ...)
}

#' Extended Bit12 Color Palettes
#'
#' A list of 12 color palettes, each containing 9 shades for continuous color interpolation
#'
#' @format A list of character vectors containing hex color codes
#' @export
bit12_extended <- list(
  plum = c(
    "#FBE5FB", "#F0C0F0", "#E596E5", "#CA6CCA", "#AF41AF", "#881788", "#6A126A", "#4D0D4D", "#300830"
  ),
  rose = c(
    "#FFE5EB", "#FFC0D1", "#FFA0B7", "#E57A93", "#CC577A", "#AA3355", "#832842", "#5C1C2E", "#35111C"
  ),
  coral = c(
    "#FFE5E5", "#FFD0D0", "#FFBBBB", "#F0A0A0", "#E08585", "#CC6666", "#A35252", "#7A3D3D", "#512929"
  ),
  apricot = c(
    "#FFECD9", "#FFD9B3", "#FFC68C", "#FFAD66", "#F9944E", "#EE9944", "#C57A37", "#9C622C", "#734921"
  ),
  lemon = c(
    "#FEFFD9", "#FEFFB3", "#FEFF8C", "#F7F06A", "#F1E43B", "#EEDD00", "#BEB100", "#8F8500", "#605900"
  ),
  lime = c(
    "#F0FFE5", "#E0FFC0", "#CCFF9A", "#B9F07A", "#AAE060", "#99DD55", "#7AB144", "#5C8533", "#3D5922"
  ),
  mint = c(
    "#E5FFF0", "#C0FFE0", "#9AFFD0", "#77F0B2", "#60E09A", "#44DD88", "#37B36D", "#298552", "#1C5937"
  ),
  teal = c(
    "#E5FAFA", "#C0F0F0", "#9AE5E5", "#77D0D0", "#55BBBB", "#22CCBB", "#1BA396", "#147A70", "#0D524B"
  ),
  sky = c(
    "#E5FAFF", "#C0F5FF", "#9AEEFF", "#66E0F0", "#40D5E0", "#00BBCC", "#0095A3", "#007079", "#004A52"
  ),
  azure = c(
    "#E5F5FF", "#C0EBFF", "#9ADEFF", "#66C8F0", "#40AEE0", "#0099CC", "#007AA3", "#005C7A", "#003D52"
  ),
  cobalt = c(
    "#E5EAFF", "#C0D1FF", "#9AB8FF", "#77A0F0", "#5585E0", "#3366BB", "#295194", "#1F3D70", "#15294B"
  ),
  violet = c(
    "#F0E5FF", "#D9C0FF", "#C29AFF", "#A577F0", "#8855E0", "#6633AA", "#502985", "#3A1F62", "#251540"
  )
)

#' @name bit12_scale
#' @export
scale_color_bit12_continuous <- function(palette = "azure", ...) {
  validate_palette(palette, .valid_bit12_palettes)
  scale_color_gradientn(
    colors = create_continuous_scale(bit12_extended[[palette]])(100),
    ...
  )
}

#' @name bit12_scale
#' @export
scale_fill_bit12_continuous <- function(palette = "azure", ...) {
  validate_palette(palette, .valid_bit12_palettes)
  scale_fill_gradientn(
    colors = create_continuous_scale(
      bit12_extended[[palette]]
    )(100),
    ...
  )
}

#' @name bit12_scale
#' @export
scale_color_bit12_distiller <- function(palette = "azure", direction = 1, ...) {
  validate_palette(palette, .valid_bit12_palettes)
  validate_direction(direction)
  # Select colors from the palette for a light-to-dark gradient
  if (direction == 1) {
    colors <- c("#FFFFFF", bit12[palette], "#000000")
  } else {
    colors <- c("#000000", bit12[palette], "#FFFFFF")
  }

  scale_color_gradientn(
    colors = colors,
    ...
  )
}

#' @name bit12_scale
#' @export
scale_fill_bit12_distiller <- function(palette = "azure", direction = 1, ...) {
  validate_palette(palette, .valid_bit12_palettes)
  validate_direction(direction)
  # Select colors from the palette for a light-to-dark gradient
  if (direction == 1) {
    colors <- c("#FFFFFF", bit12[palette], "#000000")
  } else {
    colors <- c("#000000", bit12[palette], "#FFFFFF")
  }

  scale_fill_gradientn(
    colors = colors,
    ...
  )
}

#' @name bit12_scale
#' @export
scale_color_bit12_spectrum <- function(direction = 1, ...) {
  validate_direction(direction)
  # Use all colors from the palette
  colors <- unname(bit12)

  if (direction == -1) {
    colors <- rev(colors)
  }

  scale_color_gradientn(
    colors = colors,
    ...
  )
}

#' @name bit12_scale
#' @export
scale_fill_bit12_spectrum <- function(direction = 1, ...) {
  validate_direction(direction)
  # Use all colors from the palette
  colors <- unname(bit12)

  if (direction == -1) {
    colors <- rev(colors)
  }

  scale_fill_gradientn(
    colors = colors,
    ...
  )
}
