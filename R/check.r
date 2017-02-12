#' Spell check ggplot2 plot labels
#'
#' This function can be used in a piping context or standalone. Current
#' functionality only looks for misspelled words in the labels of ggplot2 objects.
#' When misspelled words are found, a message is printed with the words and the
#' label that they are in. No messages will be printed if there are no misspelled
#' words.
#'
#' @md
#' @param gg ggplot2 object
#' @param dict a dictionary object or string which can be passed to [hunspell::dictionary]
#' @param ignore character vector with additional approved words added to the dictionary
#' @return the object that was passed in
#' @export
#' @examples
#' df <- data.frame(x=c(20, 25, 30), y=c(4, 4, 4), txt=c("One", "Two", "Three"))
#'
#' # piping
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   geom_text(data=df, aes(x=x, y=y, label=txt)) +
#'   labs(x="This is some txt", y="This is more text",
#'        title="Thisy is a titlle",
#'        subtitle="This is a subtitley",
#'        caption="This is a captien") %>%
#'   gg_check()
#'
#' # not piping
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   geom_text(data=df, aes(x=x, y=y, label=txt)) +
#'   labs(x="This is some txt", y="This is more text",
#'        title="Thisy is a titlle",
#'        subtitle="This is a subtitley",
#'        caption="This is a captien") -> gg
#'
#' gg_check(gg)
gg_check <- function(gg, dict = hunspell::dictionary("en_US"), ignore = hunspell::en_stats) {

  if (inherits(gg, "labels")) {
    lbl <- gg
  } else if ("labels" %in% names(gg)) {
    lbl <- gg$labels
  } else {
    return(gg)
  }

  if (length(lbl) > 0) {

    purrr::walk(names(lbl), function(lab) {

      words <- stri_extract_all_words(lbl[[lab]])
      words <- unlist(words)
      words <- purrr::discard(hunspell(words, "text"), ~length(.)==0)

      if (length(words) > 0) {
        message(sprintf("Possible misspelled words in [%s]: (%s)",
                        lab, paste0(words, collapse=", ")))
      }

    })

  }

  gg

}
