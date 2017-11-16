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
#' If `clipr` is installed and `cat` is `TRUE` then the `theme(...)` statements will
#' be copied to the clipboard as well as displayed (via `cat()`) in the console.
#'
#' @md
#' @param gg ggplot2 plot object
#' @param flush either "`X`" or "`Y`" or "`XY`" to flush individual or both axes. Default: both.
#' @param plot if `FALSE` then the ggplot object will be returned _invisibly_
#' @param cat if `TRUE` then display `theme()` statements and copy them to the clipboard
#' @return ggplot2 object with `theme()` elements added
#' @note Intended for basic, fixed-scale plots only (i.e. does not handle free scales in facets).
#'       Also, the clipboard operations will only occur if `clipr` is installed.
#' @export
flush_ticks <- function(gg, flush="XY", plot=TRUE, cat=TRUE) {

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

  stmts <- NULL

  if (has_x & (nx>1)) {
    gg <- gg + theme(axis.text.x=element_text(hjust=c(0, rep(0.5, mid_x), 1)))
    if (cat) {
       stmts <- c(NULL, sprintf("theme(axis.text.x=element_text(hjust=c(0, rep(0.5, %s), 1)))", mid_x))
    }
  }

  if (has_y & (ny>1)) {
    gg <- gg + theme(axis.text.y=element_text(vjust=c(0, rep(0.5, mid_y), 1)))
    stmts <- c(stmts, sprintf("theme(axis.text.y=element_text(vjust=c(0, rep(0.5, %s), 1)))", mid_y))
  }

  if (cat) {
    stmts <- paste0(stmts, collapse=" +\n")
    if (requireNamespace("clipr", quietly = TRUE)) clipr::write_clip(stmts)
    cat(stmts, sep="\n")
  }

  if (plot) gg else invisible(gg)

}
