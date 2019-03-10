# BuildMap file: function that returns a plotly map
library(plotly)
library(stringr)

# BuildMap function: fill this in with a function that returns a map:
# Derived from: https://plot.ly/r/choropleth-maps/

build_map <- function(data, map.var, map.colors) {
  mapping = list(
    "All Races" = "state_poptotal",
    "White" = "state_popwhite",
    "Black" = "state_popblack",
    "American Indian" = "state_popamerindian",
    "Asian" = "state_popasian",
    "Other" = "state_popother"
  )

  mapped.var <- mapping[[map.var]]
  # give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  # Plot
  p <- plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = data[[mapped.var]], text = ~state, locations = ~state,
      color = data[[mapped.var]], colors = map.colors
    ) %>%
    colorbar(title = "Population") %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  p
}
