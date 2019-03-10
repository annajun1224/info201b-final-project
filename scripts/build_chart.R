# Build Scatter file: function that returns a plotly Scatter plot
library(plotly)
library(stringr)

### Build Scatter ###
build_chart <- function(entry, chart.state, chart.county) {
  mapping = list(
    "White" = "popwhite",
    "Black" = "popblack",
    "American Indian" = "popamerindian",
    "Asian" = "popasian",
    "Other" = "popother"
  )
  xValues <- names(mapping)
  if (is.null(entry)) {
    return(plot_ly(
      x = xValues,
      y = c(0,0,0,0,0),
      name = paste("Demographics of ", chart.county, ", ", chart.state, sep=""),
      type = "bar"
    ))
  }
  yValues <- unlist(entry[unlist(mapping, use.names = F)], use.names = F)
  p <- plot_ly(
    x = xValues,
    y = yValues,
    name = paste("Demographics of ", chart.county, ", ", chart.state, sep=""),
    type = "bar"
  )
  p
}