# hrbrthemes 0.8.0

- Changes to conform to forthcoming {ggplot2} release

# hrbrthemes 0.7.2

- Further enhancements to the `scale_[xy]_… functions` to support passing in
  of all the `…_format()` params to make them more flexible

# hrbrthemes 0.7.1

- Small modification to percent scales to account for 
  changes in {ggplot2}
- Additional precision in setting various theme elements

# hrbrthemes 0.7.0

- fix CRAN check errors

# hrbrthemes 0.6.0

- new themes & fonts
- doc fixes

# hrbrthemes 0.5.0

## New Stuff

* `flush_ticks()` for easier alignment of x/y axis labels
* `ipsum_pdf` R Markdown format for using hrbrthemes in PDFs
* `theme_ipsum_tw()` (+ fonts) a Titillium Web-based theme
* Updated theme\_modern\_rc()

# hrbrthemes 0.3.2

## New Stuff

* IBM Plex Sans font + theme
* New "dark" RC theme mostly for RStudio plotting

## Changed Stuff

* Removed `purrr` dependency
* Tweaked `scale_`s with `expand=c(0.01,0)`
* Secondary axis support (by Dan Wilson)
* Updated tests

# hrbrthemes 0.2.0

## Changed Stuff

* Added `vdiffr` tests for the two core themes.
* Moved `hunspell` and `stringi` to `Suggests` and added namespace tests to `gg_check()`.
* Added `dict` and `ignore` parameters (with defaults) to `gg_check()` (@karldw) [PR #3].
* Fixed typos (@benmarwick) [PR #1].
* Spelling in vignette fixed (@zx8754) [Issue #6].
* New lighter grid color default `#cccccc` [Issue #7].
* Added font auto-loading (@alexwhan) [Issue #12].
* Made base font 0.5 pts larger


# hrbrthemes 0.1.0

## New Stuff

* Initial release with 'Roboto Condensed' and 'Arial Narrow' fonts based 'ggplot2' themes.
* Muted discrete color palette with 9 colors.
* 'ggplot2' scales for percentage and comma.
