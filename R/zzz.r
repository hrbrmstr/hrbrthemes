# Suggestion by @alexwhan

.onAttach <- function(libname, pkgname) {

  if (.Platform$OS.type == "windows")  { # nocov start
    if (interactive()) packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("hrbrthemes.loadfonts", default = FALSE)) {
    if (interactive()) packageStartupMessage("Registering PDF & PostScript fonts with R")
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  }

  fnt <- extrafont::fonttable()
  if (!any(grepl("Arial[ ]Narrow|Roboto[ ]Condensed", fnt$FamilyName))) {
    packageStartupMessage("NOTE: Either Arial Narrow or Roboto Condensed fonts are required to use these themes.")
    packageStartupMessage("      Please use hrbrthemes::import_roboto_condensed() to install Roboto Condensed and")
    packageStartupMessage("      if Arial Narrow is not on your system, please see http://bit.ly/arialnarrow")
  } # nocov end

}
