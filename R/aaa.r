try_require <- function(package, fun) {
  if (requireNamespace(package, quietly = TRUE)) {
    library(package, character.only = TRUE)
    return(invisible())
  }

  stop("Package `", package, "` required for `", fun , "`.\n", # nocov start
    "Please install and try again.", call. = FALSE) # nocov end
}

#from extrafonts
.onAttach <- function(libname, pkgname) {
  if (.Platform$OS.type == "windows") {
    loadfonts("win", quiet = TRUE)
    packageStartupMessage("Registering fonts with R")
  }
}