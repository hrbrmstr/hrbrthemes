
## `hrbrthemes` : Additional Themes and Theme Components for ‘ggplot2’

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![codecov](https://codecov.io/gh/hrbrmstr/hrbrthemes/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/hrbrthemes)
[![Travis-CI Build
Status](https://travis-ci.org/hrbrmstr/hrbrthemes.svg?branch=master)](https://travis-ci.org/hrbrmstr/hrbrthemes)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/hrbrthemes)](https://cran.r-project.org/package=hrbrthemes)
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/hrbrthemes)
<!-- [![keybase verified](https://img.shields.io/badge/keybase-verified-brightgreen.svg)](https://gist.github.com/hrbrmstr/be2f2c14fd78cac24697) -->

-----

This is a very focused package that provides typography-centric themes
and theme components for ggplot2. It’s a an extract/riff of
[`hrbrmisc`](http://github.com/hrbrmstr/hrbrmisc) created by request.

The core theme: `theme_ipsum` (“ipsum” is Latin for “precise”) uses
Arial Narrow which should be installed on practically any modern system,
so it’s “free”-ish. This font is condensed, has solid default kerning
pairs and geometric numbers. That’s what I consider the “font trifecta”
must-have for charts. An additional quality for fonts for charts is that
they have a diversity of weights. Arial Narrow (the one on most systems,
anyway) does not have said diversity but this quality is not (IMO) a
“must have”.

The following functions are implemented/objects are exported:

Core themes & scales:

  - `theme_ipsum`: Arial Narrow-based theme
  - `theme_ipsum_rc`: Roboto Condensed-based theme
  - `theme_ipsum_ps`: IBM Plex Sans-based theme
  - `scale_x_comma` / `scale_y_comma`: Comma format for axis text and
    better `expand` defaults (you need to set limits)
  - `scale_x_percent` / `scale_y_percent`: Percent format for axis text
    and `expand=c(0,0)` (you need to set limits)
  - `scale_color_ipsum` / `scale_fill_ipsum` / `ipsum_pal`: A muted
    discrete color palette with 9 colors

Utilities:

  - `flush_ticks`: Makes axis text labels flush on the ends
  - `gg_check`: Spell check ggplot2 plot labels
  - `update_geom_font_defaults`: Update matching font defaults for text
    geoms (the default is — unsurprisingly — Arial Narrow)

The following global variables are now in your namespace:

  - `font_an`: a short global alias for “`Arial Narrow`”
  - `font_rc`: a short global alias for “`Roboto Condensed`”
  - `font_rc_light`: a short global alias for “`Roboto Condensed Light`”
  - `font_ps`: a short global alias for “`IBMPlexSans`”
  - `font_ps_light`: a short global alias for “`IBMPlexSans-Light`”

### Installation

``` r
devtools::install_github("hrbrmstr/hrbrthemes")
```

### Usage

``` r
library(hrbrthemes)
library(gcookbook)
library(tidyverse)

# current verison
packageVersion("hrbrthemes")
## [1] '0.4.0'
```

### Base theme (Arial Narrow)

``` r
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Brought to you by the letter 'g'") + 
  theme_ipsum()
```

<img src="README_figs/README-unnamed-chunk-5-1.png" width="672" />

### Roboto Condensed

``` r
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Brought to you by the letter 'g'") + 
  theme_ipsum_rc()
```

<img src="README_figs/README-unnamed-chunk-6-1.png" width="672" />

### IBM Plex Sans

``` r
ggplot(mpg, aes(displ, hwy)) +
  geom_jitter(aes(color=class, fill=class), size=3, shape=21, alpha=1/2) +
  scale_x_continuous(expand=c(0,0), limits=c(1, 8), breaks=1:8) +
  scale_y_continuous(expand=c(0,0), limits=c(10, 50)) +
  scale_color_ipsum() +
  scale_fill_ipsum() +
  facet_wrap(~class, scales="free") +
  labs(
    title="IBM Plex Sans Test",
    subtitle="This is a subtitle to see the how it looks in IBM Plex Sans",
    caption="Source: hrbrthemes & IBM"
  ) +
  theme_ipsum_ps(grid="XY", axis="xy") +
  theme(legend.position="none") -> gg

flush_ticks(gg)
```

<img src="README_figs/README-unnamed-chunk-7-1.png" width="960" />

### Scales (Color/Fill)

``` r
ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(color=factor(carb))) +
  labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Brought to you by the letter 'g'") + 
  scale_color_ipsum() +
  theme_ipsum_rc()
```

<img src="README_figs/README-unnamed-chunk-8-1.png" width="672" />

### Scales (Axis)

``` r
count(mpg, class) %>% 
  mutate(pct=n/sum(n)) %>% 
  ggplot(aes(class, pct)) +
  geom_col() +
  scale_y_percent() +
  labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 column chart example with percents",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Brought to you by the letter 'g'") + 
  theme_ipsum(grid="Y")
```

<img src="README_figs/README-unnamed-chunk-9-1.png" width="672" />

``` r
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + 
  geom_area() +
  scale_fill_ipsum() +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_comma() +
  labs(title="Age distribution of population in the U.S., 1900-2002",
       subtitle="Example data from the R Graphics Cookbook",
       caption="Source: R Graphics Cookbook") +
  theme_ipsum_rc(grid="XY") +
  theme(axis.text.x=element_text(hjust=c(0, 0.5, 0.5, 0.5, 1))) +
  theme(legend.position="bottom")
```

<img src="README_figs/README-unnamed-chunk-10-1.png" width="672" />

``` r
update_geom_font_defaults(font_rc_light)

count(mpg, class) %>% 
  mutate(n=n*2000) %>% 
  arrange(n) %>% 
  mutate(class=factor(class, levels=class)) %>% 
  ggplot(aes(class, n)) +
  geom_col() +
  geom_text(aes(label=scales::comma(n)), hjust=0, nudge_y=2000) +
  scale_y_comma(limits=c(0,150000)) +
  coord_flip() +
  labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 column chart example with commas",
       subtitle="A plot that is only useful for demonstration purposes, esp since you'd never\nreally want direct labels and axis labels",
       caption="Brought to you by the letter 'g'") + 
  theme_ipsum_rc(grid="X")
```

<img src="README_figs/README-unnamed-chunk-11-1.png" width="672" />

### Spellcheck ggplot2 labels

``` r
df <- data.frame(x=c(20, 25, 30), y=c(4, 4, 4), txt=c("One", "Two", "Three"))

ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  labs(x="This is some txt", y="This is more text",
       title="Thisy is a titlle",
       subtitle="This is a subtitley",
       caption="This is a captien") +
  theme_ipsum_rc(grid="XY") -> gg

gg_check(gg)
## Possible misspelled words in [title]: (Thisy, titlle)
## Possible misspelled words in [subtitle]: (subtitley)
## Possible misspelled words in [caption]: (captien)
```

<img src="README_figs/README-unnamed-chunk-12-1.png" width="672" />

### Test Results

``` r
library(hrbrthemes)

date()
## [1] "Wed Nov 15 18:27:09 2017"

devtools::test()
## basic functionality: ..........
## themes:
## .
## .
## 
## DONE ===================================================================================================================
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
