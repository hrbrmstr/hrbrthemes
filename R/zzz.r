.onAttach <- function(libname, pkgname) {

  tw_font_dir <- system.file("fonts", "titillium-web", package="hrbrthemes")
  gs_font_dir <- system.file("fonts", "goldman-sans", package="hrbrthemes")
  es_font_dir <- system.file("fonts", "econ-sans", package="hrbrthemes")
  rc_font_dir <- system.file("fonts", "roboto-condensed", package="hrbrthemes")
  pub_font_dir <- system.file("fonts", "public-sans", package="hrbrthemes")
  ps_font_dir <- system.file("fonts", "plex-sans", package="hrbrthemes")
  th_font_dir <- system.file("fonts", "tinyhand", package="hrbrthemes")


  # if (interactive()) {
  #   packageStartupMessage(paste0("hrbrthemes is under *active* development. ",
  #                                "See https://github.com/hrbrmstr/hrbrthemes for info/news."))
  # }

  # Suggestion by @alexwhan

  # if (.Platform$OS.type == "windows")  { # nocov start
  #   if (interactive()) packageStartupMessage("Registering Windows fonts with R")
  #   extrafont::loadfonts("win", quiet = TRUE)
  # }
  #
  # if (getOption("hrbrthemes.loadfonts", default = FALSE)) {
  #   if (interactive()) packageStartupMessage("Registering PDF & PostScript fonts with R")
  #   extrafont::loadfonts("pdf", quiet = TRUE)
  #   extrafont::loadfonts("postscript", quiet = TRUE)
  # }
  #
  # fnt <- extrafont::fonttable()
  # if (!any(grepl("Arial[ ]Narrow|Roboto[ ]Condensed", fnt$FamilyName))) {
  #   packageStartupMessage("NOTE: Either Arial Narrow or Roboto Condensed fonts are required to use these themes.")
  #   packageStartupMessage("      Please use hrbrthemes::import_roboto_condensed() to install Roboto Condensed and")
  #   packageStartupMessage("      if Arial Narrow is not on your system, please see https://bit.ly/arialnarrow")
  # } # nocov end

}
