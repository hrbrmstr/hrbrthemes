test_that("omp chart palette mirrors omp's derivation", {
  expect_equal(
    omp_chart_palette(),
    c("#00b4ff", "#ff8500", "#68e371", "#b474f4", "#f05b93", "#00dfe8")
  )
  expect_equal(
    omp_chart_palette(light = TRUE),
    c("#009ddf", "#dc7100", "#2aaf3d", "#9352d0", "#e5508a", "#00a6ad")
  )
})

test_that("chart palette follows the accent and direction", {
  pal <- omp_chart_palette("#5b4bb7")
  expect_length(pal, 6)
  expect_false(identical(pal, omp_chart_palette()))
  expect_equal(pal[1], "#9084ff")

  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(class)) +
    ggplot2::geom_bar(ggplot2::aes(fill = class)) +
    scale_fill_tern(direction = -1)
  expect_equal(ggplot2::ggplot_build(p)$plot$scales$scales[[1]]$palette(6),
               rev(omp_chart_palette()))
})

test_that("tern theme uses the dark-cosmos chrome and Geist", {
  th <- theme_tern()
  expect_s3_class(th, "theme")
  expect_equal(th$text$family, "Geist")
  expect_equal(th$plot.title$family, "Geist SemiBold")
  expect_equal(th$plot.background$fill, tern_dark[["page"]])
  expect_equal(th$panel.background$fill, tern_dark[["page"]])
  expect_equal(ggplot2::calc_element("panel.grid.major.y", th)$colour,
               tern_dark[["shadow"]])
  expect_s3_class(th$panel.grid.major.x, "element_blank")
  expect_s3_class(th$panel.grid.minor.x, "element_blank")
  expect_s3_class(th$axis.line, "element_blank")
  expect_s3_class(th$axis.ticks, "element_blank")
  expect_equal(th$plot.title$colour, tern_dark[["starlight"]])
  expect_equal(th$axis.text$colour, tern_dark[["muted"]])
})

test_that("discrete and continuous scales build", {
  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(class)) +
    ggplot2::geom_bar(ggplot2::aes(fill = class)) +
    scale_fill_tern() +
    theme_tern()
  expect_silent(ggplot2::ggplot_build(p))

  # more groups than series colors still draws
  p2 <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(hwy)) +
    ggplot2::geom_histogram(ggplot2::aes(fill = after_stat(count))) +
    scale_fill_tern_continuous() +
    theme_tern()
  expect_silent(suppressMessages(ggplot2::ggplot_build(p2)))
})

test_that("Geist ships with the package", {
  expect_true(file.exists(system.file("fonts/geist/Geist-Regular.ttf",
                                      package = "hrbrthemes")))
  expect_true(file.exists(system.file("fonts/geist/Geist-SemiBold.ttf",
                                      package = "hrbrthemes")))
  expect_true(file.exists(system.file("fonts/geist/OFL.txt",
                                      package = "hrbrthemes")))
  expect_message(import_geist(), "fonts/geist")
  expect_equal(font_geist, "Geist")
  expect_equal(font_geist_semibold, "Geist SemiBold")
})
