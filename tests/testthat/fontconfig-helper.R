on_appveyor <- function() {
  identical(Sys.getenv("APPVEYOR"), "True")
}
on_cran <- function() {
  !identical(Sys.getenv("NOT_CRAN"), "true")
}

# Use minimal fonts.conf to speed up fc-cache
if (on_appveyor() || on_cran()) {
  gdtools::set_dummy_conf()
}