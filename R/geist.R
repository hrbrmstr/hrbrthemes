#' Import Geist font for use in charts
#'
#' Geist is Copyright (c) 2023 Vercel, Inc. and is licensed under the SIL Open
#' Font License, 1.1. It is the first family in omp's chart font stack and the
#' default for [theme_tern()].
#'
#' The package ships Geist TTFs in `inst/fonts/geist`; install them on your
#' system before using [theme_tern()].
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @export
import_geist <- function() {

  geist_font_dir <- system.file("fonts", "geist", package = "hrbrthemes")

  message(
    sprintf(
      "You will need to install these fonts on your system as well.\n\nYou can find them in [%s]",
      geist_font_dir
    )
  )

}

#' @rdname Geist
#' @md
#' @title Geist font name R variable aliases
#' @description
#' `font_geist` == "`Geist`"
#'
#' `font_geist_bold` == "`Geist Bold`"
#'
#' `font_geist_italic` == "`Geist Italic`"
#'
#' `font_geist_medium` == "`Geist Medium`"
#'
#' `font_geist_medium_italic` == "`Geist Medium Italic`"
#'
#' `font_geist_semibold` == "`Geist SemiBold`"
#' @format length 1 character vector
#' @export
font_geist <- "Geist"

#' @rdname Geist
#' @export
font_geist_bold <- "Geist Bold"

#' @rdname Geist
#' @export
font_geist_italic <- "Geist Italic"

#' @rdname Geist
#' @export
font_geist_medium <- "Geist Medium"

#' @rdname Geist
#' @export
font_geist_medium_italic <- "Geist Medium Italic"

#' @rdname Geist
#' @export
font_geist_semibold <- "Geist SemiBold"
