# server.R
library(dplyr)
library(ggplot2) # for getting midwest dataset
# Read in data
# source('./scripts/build_map.R')
# source('./scripts/build_chart.R')

# # filter the dataset
# simplified = midwest %>%
#     select(state, county, poptotal, popwhite, popblack, popamerindian, popasian, popother)

# pop_by_states = simplified %>%
#     group_by(state) %>%
#     summarize(
#         state_poptotal = sum(poptotal),
#         state_popwhite = sum(popwhite),
#         state_popblack = sum(popblack),
#         state_popamerindian = sum(popamerindian),
#         state_popasian = sum(popasian),
#         state_popother = sum(popother)
#     )
    

# Start shinyServer
shinyServer(function(input, output, session) { 
    # observe({
    #     updateSelectInput(session,
    #         "selected_state",
    #         choices = unique(pop_by_states$state)
    #     )
    # })

    # observe({
    #     updateSelectInput(
    #     session,
    #     "selected_county",
    #     choices = simplified %>%
    #         filter(state == input$selected_state) %>%
    #         select(county) %>%
    #         .[[1]]
    #     )
    # })

    output$homepage <- renderUI({
        HTML(markdown::markdownToHTML(file = "README.md"))
    })
    
    observe({
    stateChoose <- input$stateChoice
    filtered_state <- dataSelection %>%
      filter(State == stateChoose) %>%
      select(County)
    updateSelectInput(session, "countyChoice", label = "County Selection", choices = filtered_state,
                      selected = "")})

    # Render a plotly object that returns your map
    # output$map <- renderPlotly({ 
    #     build_map(pop_by_states, input$popmap, input$colors)
    # })
    
    # output$chart <- renderPlotly({
    #     entry <- simplified %>% filter(state == input$selected_state, county == input$selected_county)
    #     if (nrow(entry) == 0) {
    #         return(build_chart(NULL, "", ""))
    #     }
    #     build_chart(entry, input$selected_state, input$selected_county)
    # })
    
    # output$FastFood_plot <- renderPlot({
    #   p <- ggplot(data = data, mapping = aes_string(x = input$County, y = input$FastFood)) +
    #     geom_point()
    
    
})