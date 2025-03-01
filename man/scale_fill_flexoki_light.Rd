% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flexoki.R
\name{scale_fill_flexoki_light}
\alias{scale_fill_flexoki_light}
\title{Discrete Fill Scale Using Flexoki Light Colors}
\usage{
scale_fill_flexoki_light(...)
}
\arguments{
\item{...}{Additional arguments passed to scale_fill_manual()}
}
\value{
A discrete ggplot2 fill scale
}
\description{
Discrete Fill Scale Using Flexoki Light Colors
}
\examples{
library(ggplot2)
ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_flexoki_light()
}
