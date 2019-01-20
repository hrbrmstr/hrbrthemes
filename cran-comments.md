## Test environments

* local OS X install + travis-ci, R 3.5.0 & devel (Travis is currently failing 
  - if folks check - due to a missing CRAN mirror component in RStudio's CRAN
  mirror for Travis)
* ubuntu 14.04 (on travis-ci), R oldrel, current, devel
* win-builder (devel and release)
* rhub::check_for_cran()

## R CMD check results

0 errors | 0 warnings | 0 notes%>%	hrbrthemes exported operators

## Reverse dependencies

- [BAwiR, fontHind, fontMPlus, ggstatsplot, mlr] all OK

---

- new fonts, a new white theme and a new dark theme
- fixed typos in documentation
- resubmitted after errors noted on https://win-builder.r-project.org/incoming_pretest/hrbrthemes_0.6.0_20190120_223916/Windows/00check.log