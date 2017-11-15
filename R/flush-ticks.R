#' Makes axis text labels flush on the ends
#'
#' A covenience function intended for basic, fixed-scale plots only (i.e. does not handle
#' free scales in facets).\cr
#' \cr
#' You need to pass in a ggplot2 object to this function. It can't be `+`'d in a chain
#' of geoms, coords, scales, themes, etc. It also builds the plot (but does not display
#' it) so if the plt takes a while (i.e. has lots of data or transforms) this will also
#' take a while.
#'
#' @md
#' @param gg ggplot2 plot object
#' @param flush either "`X`" or "`Y`" or "`XY`" to flush individual or both axes. Default: both.
#' @return ggplot2 object with `theme()` elements added
#' @note Intended for basic, fixed-scale plots only (i.e. does not handle free scales in facets).
#' @export
flush_ticks <- function(gg, flush="XY") {

  if (!inherits(gg, "ggplot")) return(gg)

  flush <- unique(toupper(strsplit("XY", "")[[1]]))
  flush <- flush[flush %in% c("X", "Y")]

  has_x <- any("X" %in% flush)
  has_y <- any("Y" %in% flush)

  gb <- ggplot_build(gg)

  nx <- gb$layout$panel_scales_x[[1]]$break_info()
  nx <- length(nx$labels)

  ny <- gb$layout$panel_scales_y[[1]]$break_info()
  ny <- length(ny$labels)

  mid_x <- if ((nx - 2) > 0) (nx - 2) else 0
  mid_y <- if ((ny - 2) > 0) (ny - 2) else 0

  if (has_x & (nx>1)) gg <- gg + theme(axis.text.x=element_text(hjust=c(0, rep(0.5, mid_x), 1)))
  if (has_y & (ny>1)) gg <- gg + theme(axis.text.y=element_text(vjust=c(0, rep(0.5, mid_y), 1)))

  gg

}