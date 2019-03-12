library("dplyr")
library("ggplot2")
library("ggmap")
library("plotly")


# set up and draw the interactive map 
# using packages("plotly")
g <- list(
  scope = "usa",
  projection = list(type = "usa"),
  landcolor = toRGB("gray58"),
  showland = TRUE,
  subunitcolor = toRGB("yellow"),
  countrycolor = toRGB("yellow")
)

map_plot <- plot_geo(shootings_2018, lat = ~ lat, lon = ~ long) %>%
  add_markers(
    mode = "markers",
    hoverinfo = "text",
    text = ~ paste0("location: ", address,", ", city, ", ", state, "\n",
                    "Time: ", as.Date(date, format = "%B %d, %Y"), "\n",
                    "Casualties: ", "\n", "Injured: ", 
                    num_injured, "\n", "Killed: ",
                    num_killed),
    marker = list(
      size = ~ (total_casualities) / 2,
      color = ~ (total_casualities),
      opacity = ~ (total_casualities) / 2,
      colorscale = "Viridis",
      colorbar = list(title = "Casualties")
    )
  ) %>%
  layout(
    title = "Gun shooting in USA during 2018",
    geo = g
  )