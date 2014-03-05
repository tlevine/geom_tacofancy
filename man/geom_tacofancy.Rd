\name{geom_tacofancy}
\alias{geom_tacofancy}
\title{Add fancy tacos to a plot.}
\usage{
geom_taco()
}
\arguments{
}
\description{
Map your data onto tacos from tacofancy.
}
\section{Aesthetics}{
fill this in
}
\examples{
p <- ggplot(mpg) +
  aes(label = paste(manufacturer, model), fill = trans, cilantro = TRUE, x = hwy, y = cty) +
  geom_text() + geom_tacofancy()
}
\references{
https://github.com/sinker/tacofancy/
}
\seealso{
\code{\link{geom_taco}}
}

