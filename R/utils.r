# Most (if not all) from github.com/rstudio/rmarkdown

from_rmarkdown <- function (implicit_figures = TRUE, extensions = NULL) {
  extensions <- paste0(extensions, collapse = "")
  extensions <- gsub(" ", "", extensions)
  if (!implicit_figures && !grepl("implicit_figures", extensions))
    extensions <- paste0("-implicit_figures", extensions)
  rmarkdown_format(extensions)
}

from_rst <-function (extensions = NULL) {
    format <- c("rst")
    addExtension <- function(extension) {
        if (length(grep(extension, extensions)) == 0)
            format <<- c(format, paste0("+", extension))
    }
    addExtension("autolink_bare_uris")
    addExtension("ascii_identifiers")
    addExtension("tex_math_single_backslash")
    format <- c(format, extensions, recursive = TRUE)
    paste(format, collapse = "")
}

pandoc_html_highlight_args <- function (highlight, template, self_contained,
                                        files_dir, output_dir)  {
  args <- c()
  if (is.null(highlight)) {
    args <- c(args, "--no-highlight")
  }
  else if (!identical(template, "default")) {
    if (identical(highlight, "default"))
      highlight <- "pygments"
    args <- c(args, "--highlight-style", highlight)
  }
  else {
    highlight <- match.arg(highlight, html_highlighters())
    if (highlight %in% c("default", "textmate")) {
      highlight_path <- system.file("rmd/h/highlight", package = "rmarkdown")
      if (self_contained)
        highlight_path <- pandoc_path_arg(highlight_path)
      else {
        highlight_path <- normalized_relative_to(output_dir,
                                                 render_supporting_files(highlight_path, files_dir))
      }
      args <- c(args, "--no-highlight")
      args <- c(args, "--variable", paste("highlightjs=",
                                          highlight_path, sep = ""))
      if (identical(highlight, "textmate")) {
        args <- c(args, "--variable", paste("highlightjs-theme=",
                                            highlight, sep = ""))
      }
    }
    else {
      args <- c(args, "--highlight-style", highlight)
    }
  }
  args

}

html_highlighters <- function () { c(highlighters(), "textmate") }
highlighters <- function ()  {
  c("default", "tango", "pygments", "kate", "monochrome", "espresso",
    "zenburn", "haddock")
}

normalized_relative_to <- function (dir, file) {
  relative_to(normalizePath(dir, winslash = "/", mustWork = FALSE),
              normalizePath(file, winslash = "/", mustWork = FALSE))
}

normalize_path <- function (path) {
  if (is.null(path))
    NULL
  else normalizePath(path, winslash = "/", mustWork = FALSE)
}