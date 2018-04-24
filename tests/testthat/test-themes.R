context("themes")
test_that("themes are correct", {

  testthat::skip_on_cran()
  testthat::skip_on_appveyor()
  testthat::skip_on_travis()

  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a)

  vdiffr::expect_doppelganger("theme_ipsum", plot + theme_ipsum())
  vdiffr::expect_doppelganger("theme_ipsum_rc", plot + theme_ipsum_rc())

})