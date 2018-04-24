context("core theme components work")
test_that("we can do something", {

  library(purrr)

  tmp_x1 <- scale_x_comma()
  tmp_x2 <- scale_x_percent()

  tmp_y1 <- scale_y_comma()
  tmp_y2 <- scale_y_percent()

  fil <- scale_fill_ipsum()
  col <- scale_color_ipsum()

  gg_tmp <- ggplot2::ggplot() +
    ggplot2::labs(x="Thsi", y="This", title="This", subtitle="This", caption="Thsi")

  expect_message(gg_check(gg_tmp), "misspelled")

  gg_tmp <- ggplot2::ggplot() +
    ggplot2::labs(x="Thsi", y="This", title="This", subtitle="This", caption="Thsi") %>%
    gg_check()

  invisible(gg_check(mtcars))

  th <- theme_ipsum(grid="XY", axis="xy")
  expect_that(th$plot.title$family, equals("Arial Narrow"))

  thrc <- theme_ipsum_rc(grid="XY", axis="xy")
  expect_that(thrc$plot.title$family, equals("Roboto Condensed"))

  invisible(scale_x_percent(sec.axis = sec_axis(~.+10)))
  invisible(scale_y_percent(sec.axis = sec_axis(~.+10)))
  invisible(scale_x_comma(sec.axis = sec_axis(~.+10)))
  invisible(scale_y_comma(sec.axis = sec_axis(~.+10)))

  invisible(scale_x_percent(sec.axis = ~.+10))
  invisible(scale_y_percent(sec.axis = ~.+10))
  invisible(scale_x_comma(sec.axis = ~.+10))
  invisible(scale_y_comma(sec.axis = ~.+10))

  invisible(theme_ipsum(grid=FALSE))
  invisible(theme_ipsum_rc(grid=FALSE))
  invisible(theme_ipsum(grid="XY"))
  invisible(theme_ipsum_rc(grid="XY"))
  invisible(theme_ipsum(grid="xy"))
  invisible(theme_ipsum_rc(grid="xy"))

  invisible(theme_ipsum(axis=TRUE))
  invisible(theme_ipsum_rc(axis=TRUE))

  invisible(theme_ipsum(axis=FALSE))
  invisible(theme_ipsum_rc(axis=FALSE))
  invisible(theme_ipsum(axis="xy"))
  invisible(theme_ipsum_rc(axis="xy"))
  invisible(theme_ipsum(axis=""))
  invisible(theme_ipsum_rc(axis=""))

  # invisible(update_geom_font_defaults())
  # invisible(theme_ipsum(ticks=TRUE))
  # invisible(import_roboto_condensed())
  # invisible(theme_ipsum_rc(ticks=TRUE))

  expect_that(tmp_x1$expand, equals(c(0.01,0)))
  expect_that(tmp_x2$expand, equals(c(0.01,0)))
  expect_that(tmp_y1$expand, equals(c(0.01,0)))
  expect_that(tmp_y2$expand, equals(c(0.01,0)))

  expect_that(ipsum_pal()(1), equals("#d18975"))
  expect_that(col$palette(1), equals("#d18975"))
  expect_that(fil$palette(1), equals("#d18975"))

  testthat::skip_on_cran()
  invisible(import_roboto_condensed())

})
