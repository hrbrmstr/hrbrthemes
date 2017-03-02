#' Spell check ggplot2 plot labels
#'
#' Due to the way ggplot2 objects are created, this has to be used in a
#' standalone context.
#'
#' Current functionality only looks for misspelled words in the labels of ggplot2 objects.
#' When misspelled words are found, a message is printed with the words and the
#' label that they are in. No messages will be printed if there are no misspelled
#' words.
#'
#' @md
#' @param gg ggplot2 object
#' @param dict a dictionary object or string which can be passed to [hunspell::dictionary].
#'     Defaults to `hunspell::dictionary("en_US")`
#' @param ignore character vector with additional approved words added to the dictionary.
#'     Defaults to `hunspell::en_stats`
#' @return the object that was passed in
#' @export
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(x=c(20, 25, 30), y=c(4, 4, 4), txt=c("One", "Two", "Three"))
#'
#' # not piping
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   labs(x="This is some txt", y="This is more text",
#'        title="Thisy is a titlle",
#'        subtitle="This is a subtitley",
#'        caption="This is a captien") -> gg
#'
#' gg_check(gg)
gg_check <- function(gg, dict, ignore) {

  try_require("hunspell", "hunspell")
  try_require("stringi", "stri_extract_all_words")

  if (missing(dict)) dict <- hunspell::dictionary("en_US")
  if (missing(ignore)) ignore <- hunspell::en_stats

  if (inherits(gg, "labels")) {
    lbl <- gg
  } else if ("labels" %in% names(gg)) {
    lbl <- gg$labels
  } else {
    return(gg)
  }

  if (length(lbl) > 0) {

    purrr::walk(names(lbl), function(lab) {

      words <- stringi::stri_extract_all_words(lbl[[lab]])
      words <- unlist(words)
      words <- purrr::discard(hunspell::hunspell(words, "text", dict = dict, ignore = ignore),
                              ~length(.)==0)

      if (length(words) > 0) {
        message(sprintf("Possible misspelled words in [%s]: (%s)",
                        lab, paste0(words, collapse=", ")))
      }

    })

  }

  gg

}
