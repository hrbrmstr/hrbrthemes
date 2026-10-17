#' Tern & omp Color Palettes and Scales
#'
#' @description
#' Colors and scales for charts that sit inside [Tern](https://tern.stencil.so)
#' and beside [omp](https://github.com/can1357/oh-my-pi) charts.
#'
#' Two palettes are exposed:
#'
#' * `tern_dark` holds the `dark-cosmos` terminal theme Tern currently uses:
#'   page, panel, ink, accent, and the semantic success/error/warning colors.
#' * `omp_titanium` holds the `titanium` theme omp charts are drawn with.
#'
#' `omp_chart_palette()` reproduces omp's series palette. omp does not ship a
#' fixed chart palette: it starts from the theme accent in OKLCH, then picks
#' six hues at least 30 degrees apart (`packages/tui/src/chat/svg-figure.ts`),
#' clamps lightness to `[0.68, 0.82]` in dark themes (`[0.52, 0.66]` in light
#' ones) and chroma to 0.19, and emits them as `--c1`..`--c6`. The function
#' follows the same steps, so a different omp theme accent yields the palette
#' omp would draw.
#'
#' @param accent Theme accent used to derive the series palette
#' @param light `TRUE` for a light terminal theme, `FALSE` for a dark one
#' @param direction `1` for the palette order, `-1` to reverse it
#' @param ... Additional arguments passed to `scale_color_manual()`,
#'        `scale_fill_manual()`, `scale_color_gradientn()`, or
#'        `scale_fill_gradientn()`
#'
#' @return A named character vector of hex colors, a palette vector, or a
#'   ggplot2 scale object.
#'
#' @examples
#' omp_chart_palette()
#' omp_chart_palette(light = TRUE)
#'
#' library(ggplot2)
#' ggplot(mpg, aes(class, fill = class)) +
#'   geom_bar() +
#'   scale_fill_tern()
#'
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_fill_tern_continuous()
#'
#' @name tern
NULL

#' Tern `dark-cosmos` theme colors
#'
#' @format A named character vector of hex color codes
#' @export
tern_dark <- c(
  page = "#07070d",
  card = "#0f1018",
  info = "#17152a",
  void = "#040406",
  shadow = "#101019",
  galaxy = "#3a2a6d",
  nebula = "#5b4bb7",
  starlight = "#f4f1ff",
  starblue = "#7aa4ff",
  fg = "#dcd8f0",
  muted = "#8c88a3",
  dim = "#66627b",
  success = "#63cfa5",
  error = "#e05a6a",
  warning = "#f0b05a",
  sep = "#26223a"
)

#' omp `titanium` theme colors
#'
#' @format A named character vector of hex color codes
#' @export
omp_titanium <- c(
  page = "#151820",
  panel = "#0f1216",
  accent = "#00b4ff",
  deep = "#0082b3",
  gold = "#d4c090",
  fg = "#e8ecf4",
  muted = "#9ca3b0",
  dim = "#6b7280",
  border = "#1f252d",
  grid = "#2a3038",
  success = "#00ff88",
  error = "#ff4757",
  warning = "#ffb347"
)

# --- OKLCH helpers -------------------------------------------------------
# Direct ports of the helpers omp uses in svg-figure.ts. Single values only.

.omp_srgb_to_linear <- function(v) {
  v <- v / 255
  if (v <= 0.04045) v / 12.92 else ((v + 0.055) / 1.055)^2.4
}

.omp_linear_to_srgb <- function(v) {
  v <- pmin(1, pmax(0, v))
  ifelse(v <= 0.0031308, v * 12.92, 1.055 * v^(1 / 2.4) - 0.055)
}

.omp_hex_linear <- function(hex) {
  hex <- sub("^#", "", hex)
  vapply(c(1L, 3L, 5L), function(i) {
    .omp_srgb_to_linear(strtoi(substr(hex, i, i + 1L), 16L))
  }, numeric(1))
}

.omp_linear_oklab <- function(r, g, b) {
  l <- 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
  m <- 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
  s <- 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b
  l <- sign(l) * abs(l)^(1 / 3)
  m <- sign(m) * abs(m)^(1 / 3)
  s <- sign(s) * abs(s)^(1 / 3)
  c(
    L = 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    a = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    b = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
  )
}

.omp_oklab_linear <- function(L, a, b) {
  l <- (L + 0.3963377774 * a + 0.2158037573 * b)^3
  m <- (L - 0.1055613458 * a - 0.0638541728 * b)^3
  s <- (L - 0.0894841775 * a - 1.2914855480 * b)^3
  c(
    r =  4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
    g = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
    b = -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
  )
}

.omp_hex_oklch <- function(hex) {
  lab <- .omp_linear_oklab(.omp_hex_linear(hex)[1],
                           .omp_hex_linear(hex)[2],
                           .omp_hex_linear(hex)[3])
  c(L = unname(lab["L"]),
    C = unname(sqrt(lab["a"]^2 + lab["b"]^2)),
    h = unname((atan2(lab["b"], lab["a"]) * 180 / pi) %% 360))
}

.omp_max_chroma <- function(n, e) {
  if (-1.88170328 * n - 0.80936493 * e > 1) {
    t <- 1.19086277; o <- 1.76576728; r <- 0.59662641
    i <- 0.75515197; u <- 0.56771245
    cc <- 4.0767416621; f <- -3.3077115913; a <- 0.2309699292
  } else if (1.81444104 * n - 1.19445276 * e > 1) {
    t <- 0.73956515; o <- -0.45954404; r <- 0.08285427
    i <- 0.1254107; u <- 0.14503204
    cc <- -1.2684380046; f <- 2.6097574011; a <- -0.3413193965
  } else {
    t <- 1.35733652; o <- -0.00915799; r <- -1.1513021
    i <- -0.50559606; u <- 0.00692167
    cc <- -0.0041960863; f <- -0.7034186147; a <- 1.707614701
  }
  l <- t + o * n + r * e + i * n^2 + u * n * e
  d <- 0.3963377774 * n + 0.2158037573 * e
  p <- -0.1055613458 * n - 0.0638541728 * e
  bb <- -0.0894841775 * n - 1.291485548 * e
  E <- 1 + l * d
  x <- 1 + l * p
  s <- 1 + l * bb
  h <- cc * E^3 + f * x^3 + a * s^3
  m <- cc * 3 * d * E^2 + f * 3 * p * x^2 + a * 3 * bb * s^2
  T <- cc * 6 * d^2 * E + f * 6 * p^2 * x + a * 6 * bb^2 * s
  l - h * m / (m^2 - 0.5 * h * T)
}

# The most saturated color at this hue: its gamut cusp
.omp_gamut_hue <- function(hdeg) {
  e <- hdeg * pi / 180
  cosp <- cos(e)
  sinp <- sin(e)
  r <- .omp_max_chroma(cosp, sinp)
  lin <- .omp_oklab_linear(1, r * cosp, r * sinp)
  u <- (1 / max(lin))^(1 / 3)
  c(l = u, c = u * r)
}

.omp_oklch_hex <- function(l, c, h) {
  e <- max(0, min(1, l))
  t <- h * pi / 180
  mk <- function(ch) .omp_oklab_linear(e, ch * cos(t), ch * sin(t))
  ok <- function(v) all(v >= -1e-4 & v <= 1 + 1e-4)
  v <- mk(c)
  if (!ok(v)) {
    lo <- 0
    hi <- c
    for (i in 1:20) {
      mid <- (lo + hi) / 2
      if (ok(mk(mid))) lo <- mid else hi <- mid
    }
    v <- mk(lo)
  }
  # Math.round semantics, as omp's formatter uses
  chan <- floor(.omp_linear_to_srgb(v) * 255 + 0.5)
  sprintf("#%02x%02x%02x", chan[1], chan[2], chan[3])
}

.omp_hue_distance <- function(a, b) {
  t <- abs(a - b) %% 360
  pmin(t, 360 - t)
}

#' omp chart series palette
#'
#' Reproduces the `--c1`..`--c6` palette omp derives for chart SVGs.
#'
#' @param accent Theme accent color (defaults to `titanium`'s `#00b4ff`)
#' @param light `TRUE` for a light terminal theme
#' @param n Number of series colors to return (omp uses at most 6)
#'
#' @return A character vector of hex colors
#' @export
#' @examples
#' omp_chart_palette()
#' omp_chart_palette("#5b4bb7")   # Tern dark-cosmos accent
omp_chart_palette <- function(accent = omp_titanium[["accent"]],
                              light = FALSE, n = 6L) {
  lch <- .omp_hex_oklch(accent)
  hue <- if (lch[["C"]] >= 0.04) lch[["h"]] else 255
  picks <- c(255, 55, 145, 305, 0, 200)
  picks <- picks[.omp_hue_distance(picks, hue) >= 30]
  hues <- hue
  while (length(picks) > 0) {
    spread <- vapply(picks, function(p) {
      min(.omp_hue_distance(p, hues))
    }, numeric(1))
    pick <- picks[which.max(spread)]
    hues <- c(hues, pick)
    picks <- setdiff(picks, pick)
  }
  if (length(hues) < 6) hues <- c(hues, 90)
  bands <- if (light) c(0.52, 0.66) else c(0.68, 0.82)
  hues <- hues[seq_len(min(6L, n))]
  vapply(hues, function(h) {
    g <- .omp_gamut_hue(h)
    .omp_oklch_hex(min(bands[2], max(bands[1], g[["l"]])),
                   min(0.19, g[["c"]]), h)
  }, character(1))
}

#' @name tern
#' @export
scale_color_tern <- function(..., accent = omp_titanium[["accent"]],
                             light = FALSE, direction = 1) {
  pal <- omp_chart_palette(accent, light)
  if (direction < 0) pal <- rev(pal)
  ggplot2::discrete_scale(
    aesthetics = "colour",
    palette = function(n) {
      if (n <= length(pal)) pal[seq_len(n)]
      else grDevices::colorRampPalette(pal, space = "Lab")(n)
    },
    ...
  )
}

#' @name tern
#' @export
scale_fill_tern <- function(..., accent = omp_titanium[["accent"]],
                            light = FALSE, direction = 1) {
  pal <- omp_chart_palette(accent, light)
  if (direction < 0) pal <- rev(pal)
  ggplot2::discrete_scale(
    aesthetics = "fill",
    palette = function(n) {
      if (n <= length(pal)) pal[seq_len(n)]
      else grDevices::colorRampPalette(pal, space = "Lab")(n)
    },
    ...
  )
}

.tern_gradient <- function(accent, light, direction) {
  pal <- omp_chart_palette(accent, light)
  if (direction < 0) pal <- rev(pal)
  grDevices::colorRampPalette(pal, space = "Lab")(9)
}

#' @name tern
#' @export
scale_color_tern_continuous <- function(..., accent = omp_titanium[["accent"]],
                                        light = FALSE, direction = 1) {
  ggplot2::scale_color_gradientn(
    colours = .tern_gradient(accent, light, direction), ...
  )
}

#' @name tern
#' @export
scale_fill_tern_continuous <- function(..., accent = omp_titanium[["accent"]],
                                       light = FALSE, direction = 1) {
  ggplot2::scale_fill_gradientn(
    colours = .tern_gradient(accent, light, direction), ...
  )
}

#' A ggplot2 theme for Tern and omp charts
#'
#' Matches Tern's `dark-cosmos` chrome and omp's chart styling: no axis lines
#' or ticks, one direction of quiet grid lines, a transparent legend background,
#' and no panel border. Text defaults to Geist, the first family in omp's chart
#' font stack; the package ships the TTFs and [import_geist()] points to them.
#' Install the fonts before using this theme, or pass a different `base_family`.
#'
#' @param base_family,base_size base font family and size
#' @param plot_title_family,plot_title_face,plot_title_size,plot_title_margin plot title family, face, size and margin
#' @param subtitle_family,subtitle_face,subtitle_size,subtitle_margin plot subtitle family, face, size and margin
#' @param caption_family,caption_face,caption_size,caption_margin plot caption family, face, size and margin
#' @param axis_title_family,axis_title_face,axis_title_size axis title family, face and size
#' @param axis_text_size axis text size
#' @param strip_text_family facet strip text family
#' @param plot_margin plot margin (specify with `ggplot2::margin()`)
#' @param bg,panel_bg,ink,title_col,muted_col,dim_col colors for the page,
#'        panel, text, title, muted text and dim text
#' @param grid_col,axis_col grid and axis line colors
#' @param grid panel grid (`TRUE`, `FALSE`, or a combination of `X`, `x`, `Y`, `y`)
#' @param axis add x or y axes? `TRUE`, `FALSE`, `"xy"`
#' @param ticks ticks if `TRUE` add ticks
#' @param legend_position legend position
#'
#' @return A ggplot2 theme object
#' @export
#' @examples \dontrun{
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point(color = omp_chart_palette()[1]) +
#'   labs(x = "Weight", y = "Miles per gallon", title = "Tern-styled chart") +
#'   theme_tern()
#' }
theme_tern <- function(base_family = "Geist", base_size = 12,
                       plot_title_family = "Geist SemiBold", plot_title_size = 16,
                       plot_title_face = "plain", plot_title_margin = 8,
                       subtitle_family = base_family, subtitle_size = 12,
                       subtitle_face = "plain", subtitle_margin = 10,
                       caption_family = base_family, caption_size = 9,
                       caption_face = "plain", caption_margin = 8,
                       axis_title_family = "Geist Medium", axis_title_size = 10,
                       axis_title_face = "plain", axis_text_size = 10,
                       strip_text_family = "Geist SemiBold",
                       plot_margin = ggplot2::margin(16, 16, 12, 12),
                       bg = tern_dark[["page"]],
                       panel_bg = tern_dark[["page"]],
                       ink = tern_dark[["fg"]],
                       title_col = tern_dark[["starlight"]],
                       muted_col = tern_dark[["muted"]],
                       dim_col = tern_dark[["dim"]],
                       grid_col = tern_dark[["shadow"]],
                       axis_col = tern_dark[["sep"]],
                       grid = "Y", axis = FALSE, ticks = FALSE,
                       legend_position = "top") {

  ret <- ggplot2::theme_minimal(base_family = base_family, base_size = base_size)

  ret <- ret + ggplot2::theme(
    plot.background = ggplot2::element_rect(fill = bg, colour = NA),
    panel.background = ggplot2::element_rect(fill = panel_bg, colour = NA),
    panel.border = ggplot2::element_blank(),
    plot.margin = plot_margin,
    text = ggplot2::element_text(colour = ink),
    plot.title = ggplot2::element_text(
      family = plot_title_family, face = plot_title_face,
      size = plot_title_size, colour = title_col,
      margin = ggplot2::margin(b = plot_title_margin)
    ),
    plot.subtitle = ggplot2::element_text(
      family = subtitle_family, face = subtitle_face, size = subtitle_size,
      colour = muted_col, margin = ggplot2::margin(b = subtitle_margin)
    ),
    plot.caption = ggplot2::element_text(
      family = caption_family, face = caption_face, size = caption_size,
      colour = dim_col, hjust = 1, margin = ggplot2::margin(t = caption_margin)
    ),
    axis.title = ggplot2::element_text(
      family = axis_title_family, face = axis_title_face,
      size = axis_title_size, colour = muted_col
    ),
    axis.text = ggplot2::element_text(
      family = base_family, size = axis_text_size, colour = muted_col
    ),
    strip.text = ggplot2::element_text(
      family = strip_text_family, size = base_size, colour = title_col,
      face = "plain"
    ),
    strip.background = ggplot2::element_rect(
      fill = tern_dark[["card"]], colour = NA
    ),
    legend.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.title = ggplot2::element_text(
      family = base_family, size = base_size, colour = muted_col
    ),
    legend.text = ggplot2::element_text(
      family = base_family, size = axis_text_size, colour = muted_col
    ),
    legend.position = legend_position
  )

  if (inherits(grid, "character") || isTRUE(grid)) {
    ret <- ret +
      ggplot2::theme(
        panel.grid = ggplot2::element_line(colour = grid_col, linewidth = 0.3),
        panel.grid.major = ggplot2::element_line(colour = grid_col, linewidth = 0.3),
        panel.grid.minor = ggplot2::element_line(colour = grid_col, linewidth = 0.2)
      )
    if (inherits(grid, "character")) {
      if (regexpr("X", grid)[1] < 0)
        ret <- ret + ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
      if (regexpr("Y", grid)[1] < 0)
        ret <- ret + ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
      if (regexpr("x", grid)[1] < 0)
        ret <- ret + ggplot2::theme(panel.grid.minor.x = ggplot2::element_blank())
      if (regexpr("y", grid)[1] < 0)
        ret <- ret + ggplot2::theme(panel.grid.minor.y = ggplot2::element_blank())
    }
  } else {
    ret <- ret + ggplot2::theme(panel.grid = ggplot2::element_blank())
  }

  if (inherits(axis, "character") || isTRUE(axis)) {
    axis <- if (inherits(axis, "character")) tolower(axis) else "xy"
    ret <- ret + ggplot2::theme(axis.line = ggplot2::element_line(
      colour = axis_col, linewidth = 0.3
    ))
    if (regexpr("x", axis)[1] < 0)
      ret <- ret + ggplot2::theme(axis.line.x = ggplot2::element_blank())
    if (regexpr("y", axis)[1] < 0)
      ret <- ret + ggplot2::theme(axis.line.y = ggplot2::element_blank())
  } else {
    ret <- ret + ggplot2::theme(axis.line = ggplot2::element_blank())
  }

  if (isTRUE(ticks)) {
    ret <- ret + ggplot2::theme(
      axis.ticks = ggplot2::element_line(colour = axis_col, linewidth = 0.3),
      axis.ticks.length = grid::unit(4, "pt")
    )
  } else {
    ret <- ret + ggplot2::theme(axis.ticks = ggplot2::element_blank())
  }

  ret
}
