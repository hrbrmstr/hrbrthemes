#' ipsum R markdown template for PDF output
#'
#' Template for creating an R markdown documents with an emphasis on typography
#'
#' @param ... Arguments to \code{rmarkdown::pdf_document}
#'
#' @return R Markdown output format to pass to \code{\link[rmarkdown:render]{render}}
#'
#' @export
ipsum_pdf <- function(...) {
  rmarkdown::pdf_document(...)
}