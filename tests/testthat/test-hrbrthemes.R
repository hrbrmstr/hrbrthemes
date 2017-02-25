context("basic functionality")
test_that("we can do something", {

  tmp_x1 <- scale_x_comma()
  tmp_x2 <- scale_x_percent()

  tmp_y1 <- scale_y_comma()
  tmp_y2 <- scale_y_percent()

  fil <- scale_fill_ipsum()
  col <- scale_color_ipsum()

  gg_tmp <- ggplot2::ggplot() +
    ggplot2::labs(x="Thsi", y="This", title="This", subtitle="This", caption="Thsi")

  expect_message(gg_check(gg_tmp), "misspelled")

  expect_that(tmp_x1$expand, equals(c(0,0)))
  expect_that(tmp_x2$expand, equals(c(0,0)))
  expect_that(tmp_y1$expand, equals(c(0,0)))
  expect_that(tmp_y2$expand, equals(c(0,0)))

  expect_that(ipsum_pal()(1), equals("#d18975"))
  expect_that(col$palette(1), equals("#d18975"))
  expect_that(fil$palette(1), equals("#d18975"))

})

