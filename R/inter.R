#' A precise & pristine [ggplot2] theme with opinionated defaults and an emphasis on typoghraphy
#'
#' You should [import_inter()] first and install the fonts on your
#' system before trying to use this theme.
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @section Why Inter?:
#' Google "inter font".
#'
#' @md
#' @param base_family,base_size base font family and size
#' @param plot_title_family,plot_title_face,plot_title_size,plot_title_margin plot tilte family, face, size and margin
#' @param subtitle_family,subtitle_face,subtitle_size plot subtitle family, face and size
#' @param subtitle_margin plot subtitle margin bottom (single numeric value)
#' @param strip_text_family,strip_text_face,strip_text_size facet label font family, face and size
#' @param caption_family,caption_face,caption_size,caption_margin plot caption family, face, size and margin
#' @param axis_text_family,axis_text_face, axis text font family and face
#' @param axis_title_family,axis_title_face,axis_title_size axis title font family, face and size
#' @param axis_title_just axis title font justification one of `[blmcrt]`
#' @param axis_text_size font size of axis text
#' @param plot_margin plot margin (specify with [ggplot2::margin])
#' @param grid_col grid color
#' @param grid panel grid (`TRUE`, `FALSE`, or a combination of `X`, `x`, `Y`, `y`)
#' @param axis_col axis color
#' @param axis add x or y axes? `TRUE`, `FALSE`, "`xy`"
#' @param ticks ticks if `TRUE` add ticks
#' @export
#' @examples \dontrun{
#' library(ggplot2)
#' library(dplyr)
#'
#' # seminal scatterplot
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
#'        title="Seminal ggplot2 scatterplot example",
#'        subtitle="A plot that is only useful for demonstration purposes",
#'        caption="Brought to you by the letter 'g'") +
#'   theme_ipsum_inter()
#'
#' # seminal bar chart
#'
#' update_geom_font_defaults(family=font_inter_medium)
#'
#' count(mpg, class) %>%
#'   ggplot(aes(class, n)) +
#'   geom_col() +
#'   geom_text(aes(label=n), nudge_y=3) +
#'   labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
#'        title="Seminal ggplot2 bar chart example",
#'        subtitle="A plot that is only useful for demonstration purposes",
#'        caption="Brought to you by the letter 'g'") +
#'   theme_ipsum_inter(grid="Y") +
#'   theme(axis.text.y=element_blank())
#' }
theme_ipsum_inter <- function(
  base_family="Inter-Medium",
  base_size = 10,
  plot_title_family="Inter-Bold",
  plot_title_size = 16,
  plot_title_face="bold",
  plot_title_margin = 8,
  subtitle_family="Inter-Light",
  subtitle_size = 12,
  subtitle_face = "plain",
  subtitle_margin = 13,
  strip_text_family = "Inter-SemiBold",
  strip_text_size = 12,
  strip_text_face = "bold",
  caption_family="Inter-Thin",
  caption_size = 9,
  caption_face = "plain",
  caption_margin = 10,
  axis_text_family = "Inter-Light",
  axis_text_face = "plain",
  axis_text_size = 9,
  axis_title_family = base_family,
  axis_title_size = 9,
  axis_title_face = "plain",
  axis_title_just = "rt",
  plot_margin = margin(30, 30, 30, 30),
  grid_col = "#cccccc", grid = TRUE,
  axis_col = "#cccccc", axis = FALSE, ticks = FALSE) {

  ret <- ggplot2::theme_minimal(base_family=base_family, base_size=base_size)

  ret <- ret + theme(legend.background=element_blank())
  ret <- ret + theme(legend.key=element_blank())

  if (inherits(grid, "character") | grid == TRUE) {

    ret <- ret + theme(panel.grid=element_line(color=grid_col, linewidth=0.2))
    ret <- ret + theme(panel.grid.major=element_line(color=grid_col, linewidth=0.2))
    ret <- ret + theme(panel.grid.minor=element_line(color=grid_col, linewidth=0.15))

    if (inherits(grid, "character")) {
      if (regexpr("X", grid)[1] < 0) ret <- ret + theme(panel.grid.major.x=element_blank())
      if (regexpr("Y", grid)[1] < 0) ret <- ret + theme(panel.grid.major.y=element_blank())
      if (regexpr("x", grid)[1] < 0) ret <- ret + theme(panel.grid.minor.x=element_blank())
      if (regexpr("y", grid)[1] < 0) ret <- ret + theme(panel.grid.minor.y=element_blank())
    }

  } else {
    ret <- ret + theme(panel.grid=element_blank())
  }

  if (inherits(axis, "character") | axis == TRUE) {
    ret <- ret + theme(axis.line=element_line(color=axis_col, linewidth=0.15))
    if (inherits(axis, "character")) {
      axis <- tolower(axis)
      if (regexpr("x", axis)[1] < 0) {
        ret <- ret + theme(axis.line.x=element_blank())
      } else {
        ret <- ret + theme(axis.line.x=element_line(color=axis_col, linewidth=0.15))
      }
      if (regexpr("y", axis)[1] < 0) {
        ret <- ret + theme(axis.line.y=element_blank())
      } else {
        ret <- ret + theme(axis.line.y=element_line(color=axis_col, linewidth=0.15))
      }
    } else {
      ret <- ret + theme(axis.line.x=element_line(color=axis_col, linewidth=0.15))
      ret <- ret + theme(axis.line.y=element_line(color=axis_col, linewidth=0.15))
    }
  } else {
    ret <- ret + theme(axis.line=element_blank())
  }

  if (!ticks) {
    ret <- ret + theme(axis.ticks = element_blank())
    ret <- ret + theme(axis.ticks.x = element_blank())
    ret <- ret + theme(axis.ticks.y = element_blank())
  } else {
    ret <- ret + theme(axis.ticks = element_line(linewidth=0.15))
    ret <- ret + theme(axis.ticks.x = element_line(linewidth=0.15))
    ret <- ret + theme(axis.ticks.y = element_line(linewidth=0.15))
    ret <- ret + theme(axis.ticks.length = grid::unit(5, "pt"))
  }

  xj <- switch(tolower(substr(axis_title_just, 1, 1)), b=0, l=0, m=0.5, c=0.5, r=1, t=1)
  yj <- switch(tolower(substr(axis_title_just, 2, 2)), b=0, l=0, m=0.5, c=0.5, r=1, t=1)

  ret <- ret + theme(axis.text.x=element_text(size=axis_text_size, margin=margin(t=0)))
  ret <- ret + theme(axis.text.y=element_text(size=axis_text_size, margin=margin(r=0)))
  ret <- ret + theme(axis.title=element_text(size=axis_title_size, family=axis_title_family))
  ret <- ret + theme(axis.title.x=element_text(hjust=xj, size=axis_title_size,
                                               family=axis_title_family, face=axis_title_face))
  ret <- ret + theme(axis.title.y=element_text(hjust=yj, size=axis_title_size,
                                               family=axis_title_family, face=axis_title_face))
  ret <- ret + theme(axis.title.y.right=element_text(hjust=yj, size=axis_title_size, angle=90,
                                                     family=axis_title_family, face=axis_title_face))
  ret <- ret + theme(strip.text=element_text(hjust=0, size=strip_text_size,
                                             face=strip_text_face, family=strip_text_family))
  ret <- ret + theme(panel.spacing=grid::unit(2, "lines"))
  ret <- ret + theme(plot.title=element_text(hjust=0, size=plot_title_size,
                                             margin=margin(b=plot_title_margin),
                                             family=plot_title_family, face=plot_title_face))
  ret <- ret + theme(plot.subtitle=element_text(hjust=0, size=subtitle_size,
                                                margin=margin(b=subtitle_margin),
                                                family=subtitle_family, face=subtitle_face))
  ret <- ret + theme(plot.caption=element_text(hjust=1, size=caption_size,
                                               margin=margin(t=caption_margin),
                                               family=caption_family, face=caption_face))
  ret <- ret + theme(plot.margin=plot_margin)

  ret

}

#' Import Inter font for use in charts
#'
#' Inter is Copyright (c) 2016-2024 The Inter Project Authors
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @export
import_inter <- function() {

  message(
    "You can find Inter at https://github.com/rsms/inter. Please install them ",
    "and run extrafont::font_import()"
  )

}


#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_thin` == "`Inter-Thin`"
#' @format length 1 character vector
#' @export
font_inter_thin <- "Inter-Thin"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_thin_italic` == "`Inter-ThinItalic`"
#' @format length 1 character vector
#' @export
font_inter_thin_italic <- "Inter-ThinItalic"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_medium` == "`Inter-Medium`"
#' @format length 1 character vector
#' @export
font_inter_medium <- "Inter-Medium"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_medium_italic` == "`Inter-MediumItalic`"
#' @format length 1 character vector
#' @export
font_inter_medium_italic <- "Inter-MediumItalic"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_semibold` == "`Inter-SemiBold`"
#' @format length 1 character vector
#' @export
font_inter_semibold <- "Inter-SemiBold"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_bold` == "`Inter-Bold`"
#' @format length 1 character vector
#' @export
font_inter_bold <- "Inter-Bold"

#' @rdname Inter
#' @md
#' @title Inter font name R variable aliases
#' @description `font_inter_italic` == "`Inter-Italic`"
#' @format length 1 character vector
#' @export
font_inter_italic <- "Inter-Italic"
