#' Convert duration to human-readable text
#'
#' Takes a numeric value or a \code{difftime} object and converts it into a
#' natural language string (e.g., "2 hours and 15 minutes").
#'
#' The function breaks down the total seconds into years, days, hours, minutes,
#' and seconds, pluralizing units where necessary and applying English
#' grammar rules (including the Oxford comma) for joining multiple units.
#'
#' @param x A numeric vector or \code{difftime} object representing the duration.
#'   If numeric, it is assumed to be in seconds.
#' @param units_max Integer. The maximum number of time units to display.
#'   For example, if \code{units_max = 2}, a duration of "1 day, 2 hours,
#'   and 5 minutes" will be truncated to "1 day and 2 hours". Defaults to 2.
#'
#' @return A character vector of the same length as \code{x}.
#'
#' @examples
#' \dontrun{
#' # Basic usage with numeric seconds
#' humanize_duration(3661) # "1 hour, 1 minute, and 1 second"
#' humanize_duration(3661, units_max = 2) # "1 hour and 1 minute"
#'
#' # Usage with difftime
#' time_diff <- as.difftime(86400 * 2 + 3600, units = "secs")
#' humanize_duration(time_diff) # "2 days and 1 hour"
#'
#' # Handling edge cases
#' humanize_duration(c(0, NA)) # "0 seconds" NA
#' }
#' @export
humanize_duration <- function(x, units_max = 2L) {
  secs <- if (inherits(x, "difftime")) as.numeric(x, units = "secs") else as.numeric(x)
  u <- c(year = 31557600, day = 86400, hour = 3600, minute = 60, second = 1)

  join_en <- function(p) {
    n <- length(p)
    if (n == 1L) return(p)
    if (n == 2L) return(paste(p, collapse = " and "))
    paste0(paste(p[-n], collapse = ", "), ", and ", p[n])
  }

  vapply(secs, function(s) {
    if (is.na(s)) return(NA_character_)
    s <- abs(round(s))
    if (s == 0) return("0 seconds")
    parts <- character()
    for (nm in names(u)) {
      k <- s %/% u[[nm]]
      if (k > 0) {
        parts <- c(parts, sprintf("%d %s%s", k, nm, if (k == 1) "" else "s"))
        s <- s - k * u[[nm]]
        if (length(parts) >= units_max) break
      }
    }
    join_en(parts)
  }, character(1))
}
