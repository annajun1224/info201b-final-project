
library(dplyr)
library(ggplot2)
library(plotly)

shinyServer(function(input, output, session) { 


    output$homepage <- renderUI({
        HTML(markdown::markdownToHTML(file = "README.md"))
    })
    
    observe({
    stateChoose <- input$stateChoice
    filtered_state <- countyObese %>%
      filter(State == stateChoose) %>%
      select(County)
    updateSelectInput(session, 
                      "countyChoice", 
                      label = "County Selection", 
                      choices = filtered_state,
                      selected = "")
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
        select(pct_obese_14, pct_diabetes_14, poverty_rate) %>%
        unique()
      paste("This county has an obesity rate of <b>", used$pct_obese_14, 
            "</b>, a diabetes rate of <b>", used$pct_diabetes_14, 
            "</b> and a poverty rate of <b>", used$poverty_rate, "</b>.")
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
})