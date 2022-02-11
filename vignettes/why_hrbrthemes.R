## ----echo=FALSE, fig.width=8--------------------------------------------------
library(ggplot2)
library(gridExtra)

ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  labs(x="Weight (tons)", y="Efficiency (MPG)",
       title="Lorem ipsum dolor sit amet",
       subtitle="Mauris ultricies sem volutpat magna venenatis") -> gg

grid.arrange(
  gg + theme_minimal(base_family="serif") + theme(plot.margin=margin(t=20, b=20, l=15, r=30)),
  gg + theme_minimal(base_family="sans") + theme(plot.margin=margin(t=20, b=20, l=30, r=15)),
  ncol=2
)


