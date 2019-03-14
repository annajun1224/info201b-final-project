# server.R
library(dplyr)
library(ggplot2) # for getting midwest dataset
library(httr)
library(jsonlite)
library(leaflet)
library(RColorBrewer)
library(reshape2)
library(DT)
library(lubridate)
##########################Code for generating the joint data ##########################

joined_data <- read.csv("data/joined_data.csv", stringsAsFactors = F)
joined_data <- joined_data %>%
  mutate(full_address = paste(address, city, County, State)) %>%
  group_by(name) %>%
  mutate(count = n()) %>%
  arrange(-count) %>%
  ungroup()

restaurant_chain_list <- joined_data %>%
  group_by(name) %>% 
  summarize(count=n()) %>%
  arrange(-count, name)

restaurant_choices <- c("All", restaurant_chain_list %>%
                          select(name) %>%
                          .[[1]])

restaurant_location_data <- joined_data %>% select(longitude, latitude, postalCode, name, address, city, County, State) %>%
  mutate(full_address = paste(address, city, County, State, postalCode, sep=", "))

top_five_count <- 0
for (i in 2:6) {
  top_five_count <- top_five_count + joined_data %>% filter(name == restaurant_choices[i]) %>% nrow()
}

countyObese <- read.csv("data/joined_data.csv", stringsAsFactors = F)
restaurantSelections <- countyObese %>%
  select(name) %>%
  unique()

stateSelection <- countyObese %>%
  select(State, name) %>%
  select(State) %>%
  unique()


restaurantByState <- countyObese %>%
  select(State, name) %>%
  filter

# Start shinyServer
shinyServer(function(input, output, session) {
  
  observe({
    selected_chain <- input$restaurant_chain
    if (selected_chain == "") {
      selected_chain = "All"
    }
    
    selected_data <- joined_data
    
    if (selected_chain != "All") {
      selected_data <- selected_data %>% filter(name == selected_chain)  
    }
    
    colorData <- selected_data$name
    pal <- colorFactor(if_else(selected_chain != "All", "#33007b", "viridis"), colorData, ordered = F, na.color = 'Purple')
    
    leafletProxy("map", data = selected_data) %>%
      clearShapes() %>%
      addCircles(~longitude, ~latitude, radius=30000, layerId=~postalCode,
                 stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData), label=~paste(name, full_address, sep=", ")) %>%
      addLegend("bottomleft", pal=pal, values=head(colorData, top_five_count), title="Restaurant Chain (top 5 unordered)",
                layerId="colorLegend")
  })
  
  observe({
    updateSelectInput(
      session,
      "restaurant_chain",
      choices = restaurant_choices
    )
  })
  
  output$map <- renderLeaflet({
    colorData <- joined_data$name
    pal <- colorFactor("viridis", colorData, ordered = F)
    leaflet(data = joined_data) %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = -93.85, lat = 37.45, zoom = 4) %>%
      addCircles(~longitude, ~latitude, radius=20000, layerId=~postalCode,
                 stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData), label=~paste(name, full_address, sep=", ")) %>%
      addLegend("bottomleft", pal=pal, values=head(colorData, top_five_count), title="Restaurant Chain (top 5 unordered)",
                layerId="colorLegend")
  })
  
  output$top_restaurant_list <- renderTable({
    chain_name <- input$restaurant_chain
    result <- restaurant_chain_list
    if (chain_name != "All") {
      result <- result %>% filter(name == chain_name)
    }
    result %>% head(5)
  }, rownames = T, striped = T, hover = T, width = "100%", align = "l")
  
  output$homepage <- renderUI({
    HTML(markdown::markdownToHTML(file = "README.md"))
  })
  
  output$addresses <- renderTable({
    filtered_data <- restaurant_location_data
    if (input$address_filter != "") {
      filtered_data <- filtered_data %>% filter(
        grepl(input$address_filter, full_address, ignore.case = T) | grepl(input$address_filter, name, ignore.case = T))
    }
    if (input$restaurant_chain != "All") {
      filtered_data <- filtered_data %>% filter(name == input$restaurant_chain)
    }
    filtered_data %>% select(name, full_address) %>% head(100)
  }, striped = T, width = "100%", align = "l")
  
  observe({
    filtered_data <- restaurant_location_data
    if (input$address_filter != "") {
      filtered_data <- filtered_data %>% filter(
        grepl(input$address_filter, full_address, ignore.case = T) | grepl(input$address_filter, name, ignore.case = T))
    }
    if (input$restaurant_chain != "All") {
      filtered_data <- filtered_data %>% filter(name == input$restaurant_chain)
    }
    if (nrow(filtered_data) <= 10) {
      leafletProxy("map", data = filtered_data) %>%
        clearMarkers() %>%
        addMarkers(~longitude, ~latitude, layerId=~postalCode, popup=~paste(paste0("<b>",name,"</b>"), full_address, sep="<br/>"))
    } else {
      leafletProxy("map") %>% clearMarkers()
    }
  })
  
  
  observe({
    updateSelectInput(session, 
                      "stateChoice",
                      choices = stateSelection)
  })
  
  observe({
    stateChoose <- input$stateChoice
    filtered_state <- countyObese %>%
      filter(State == stateChoose) %>%
      select(County)
    updateSelectInput(session, 
                      "countyChoice",
                      choices = filtered_state)
  })
  
  output$distribPie <- renderPlotly({
    distribData <- countyObese %>%
      select(State, County, name) %>%
      filter(State == input$stateChoice) %>%
      count(name) %>%
      mutate(ttl = sum(n)) %>%
      filter(n > 2)
    plot <- plot_ly(distribData, 
                    labels = ~name, 
                    values = ~n, 
                    width = 570, 
                    height = 550, 
                    type = "pie",
                    textposition = 'inside',
                    textinfo = 'label+percent',
                    insidetextfont = list(color = '#FFFFFF'),
                    marker = list(colors = colors,
                                  line = list(color = '#FFFFFF', width = 1)),
                    showlegend = F) %>%
      layout(title = 'Fast Food distribution in USA by State')
    plot
  })
  
  output$feedback <- renderText({
    paste("You have selected <b>", input$countyChoice, 
          "</b> county located in the state of <b>", 
          input$stateChoice, "</b>.")
  })
  
  output$data <- renderText({
    used <- countyObese %>%
      filter(State == input$stateChoice, County == input$countyChoice) %>%
      select(pct_obese_14, pct_diabetes_14, poverty_rate, count_change_pct, count_per_10k_pop_14) %>%
      unique()
    paste("Change in fast food chain count in 5 years: <b>", used$count_change_pct, 
          "%</b><br> restaurants per 10k people in 2014: <b>", used$count_per_10k_pop_14, 
          "</b><br> Poverty rate: <b>", used$poverty_rate, "</b>.")
  })
  
  output$racePie <- renderPlotly({
    race <- countyObese %>%
      filter(State == input$stateChoice, County == input$countyChoice) %>%
      select(County, pct_white:pct_other) %>%
      unique()
    colnames(race) <- c("County", "Caucasian", "African American", "Hispanic", "Asian", "Other")
    df <- melt(race, "County")
    plot <- plot_ly(df, labels = ~variable, 
                    values = ~value, 
                    width = 570, 
                    height = 550, 
                    type = "pie",
                    textposition = 'inside',
                    textinfo = 'label+percent',
                    insidetextfont = list(color = '#FFFFFF'),
                    marker = list(colors = colors,
                                  line = list(color = '#FFFFFF', width = 1)),
                    showlegend = F) %>%
      layout(title = 'Race Distribution by County')
    plot
  })
  
  output$chngPlot <- renderPlot({
    filtersd <- countyObese %>%
      filter(State == input$stateChoice, County == input$countyChoice) %>%
      select(County, pct_obese_09, pct_obese_14, pct_diabetes_09, pct_diabetes_14) %>%
      unique()
    colnames(filtersd) <- c("County", "% Obese in 2009", "% Obese in 2014", "% Diabetic in 2009", "% Diabetic in 2014")
    df <- melt(filtersd, "County")
    p <- ggplot(data = df,
                mapping = aes(x = variable, y = value, fill = variable)) +
      geom_bar(stat = "identity") + 
      labs(title = "Changes in Obesity and Diabetic Within a 5 Year Time Frame by County", 
           x = "", y = "percentage") +
      theme(legend.position = "none", plot.title = element_text(hjust = 0.5, size = 20, face = "bold"), axis.text = element_text(size = 15, face = "bold"))
    p
  })
  
  output$CountyInfo <- renderDataTable({
    county_impacted <- countyObese %>%
      group_by(County) %>%
      filter(pct_obese_14 == max(pct_obese_14)) %>%
      arrange(- pct_obese_14) %>%
      head(100) %>%
      select(State, County, poverty_rate, count_change_pct, pct_obese_09, pct_obese_14) %>%
      unique()
    colnames(county_impacted) <- c("State", "County", "Poverty Rates (%)", "Count Change in 5 yrs (%)",  "obese in 2009 (%)", "Obese in 2014 (%)")
    datatable(county_impacted, options = list(pageLength = 10, scrollX = TRUE, scrollY = '450px')) %>% formatStyle(names(county_impacted))
  })
  output$Health_plot <- renderPlot({
    p <- ggplot(data = joined_data, mapping = aes_string(x = input$countyChoice, y = input$pct_obese_14)) +
      geom_point()
  })
  
  output$QA <- renderUI({
    HTML(markdown::markdownToHTML(file = "README1.md"))
  })
  
  output$ContactInformation <- renderUI({
    HTML(markdown::markdownToHTML(file = "contactinfo.md"))
  })
})