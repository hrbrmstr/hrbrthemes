on_appveyor <- function() {
  identical(Sys.getenv("APPVEYOR"), "True")
}

on_cran <- function() {
  !identical(Sys.getenv("NOT_CRAN"), "true")
}
