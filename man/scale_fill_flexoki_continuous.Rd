% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flexoki.R
\name{scale_fill_flexoki_continuous}
\alias{scale_fill_flexoki_continuous}
\title{Continuous Fill Scale Using Flexoki Colors}
\usage{
scale_fill_flexoki_continuous(palette = "red", ...)
}
\arguments{
\item{palette}{Name of the color palette to use ("red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta")}

\item{...}{Additional arguments passed to scale_fill_gradientn()}
}
\value{
A continuous ggplot2 fill scale
}
\description{
Continuous Fill Scale Using Flexoki Colors
}
\examples{
library(ggplot2)
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_tile() +
  scale_fill_flexoki_continuous(palette = "blue")
}
