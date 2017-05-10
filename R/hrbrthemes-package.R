#' Additional Themes and Theme Components for 'ggplot2'
#'
#' A compilation of extra themes and theme components for 'ggplot2' with an
#' emphasis on typography.
#'
#' The core theme: `theme_ipsum` ("ipsum" is Latin for "precise") uses Arial Narrow
#' which should be installed on practically any modern system, so it's "free"-ish.
#' This font is condensed, has solid default kerning pairs and geometric numbers.
#' That's what I consider the "font trifecta" must-have for charts. An additional
#' quality for fonts for charts is that they have a diversity of weights. Arial
#' Narrow (the one on most systems, anyway) does not have said diversity but this
#' quality is not (IMO) a "must have".
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @name hrbrthemes
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import ggplot2 grid scales extrafont
#' @importFrom magrittr %>%
#' @import rmarkdown knitr htmltools
#' @importFrom tools file_path_sans_ext
NULL

#' hrbrthemes exported operators
#'
#' The following functions are imported and then re-exported
#' from the hrbrthemes package to enable use of the magrittr
#' pipe operator with no additional library calls
#'
#' @name hrbrthemes-exports
NULL

#' @name %>%
#' @export
#' @rdname hrbrthemes-exports
NULL
