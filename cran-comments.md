## Test environments

* local OS X install + travis-ci, R 3.5.0 & devel (Travis is currently failing 
  - if folks check - due to a missing CRAN mirror component in RStudio's CRAN
  mirror for Travis)
* ubuntu 14.04 (on travis-ci), R oldrel, current, devel
* win-builder (devel and release)
* rhub::check_for_cran()

## R CMD check results

0 errors | 0 warnings | 0 notes

r-hub CRAN check notes "Author field differs from that derived from Authors@R"
due to the ORCID id auto-expansion to a URL.

* This is an update and CRAN-fix release.

## Reverse dependencies

- BAwiR - ok
- fontHind - ok
- fontMPlus - ok

---

- new fonts and R markdown theme added
- some new utilities for ggplot2 themes
- fixed CRAN check errors on ubuntu (at least that's what all the 
  third-party testing sites tell me since it does not toss that
  error on them)
