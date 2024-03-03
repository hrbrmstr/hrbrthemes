is_3.5 <- function() {
  compareVersion(as.character(packageVersion("ggplot2")), "3.5.0") >= 0
}
