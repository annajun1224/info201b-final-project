## Welcome

Glad to see you here. On this page, we will guide you through our website.

- Under "Map" section, you would be able to view the fast food distribution across the United States.
- Under "Analysis", you would be able to look at the relationship between fast food distribution and the obesity rate in each state.
- Also, you would be able to look at the ethnic group distribution in each state and which ethnic group has favor towards fast food.

## About our Dataset

- **Fast food restaurant distribution** in the US, provided by Datafiniti, which provides instant access to web data. Datafiniti compiles data from thousands of websites to create standardized databases of business, product, and property information
- **Health data** in the United States (focusing on obesity data), provided by the United States Department of Agriculture Economic Research Service. 
Our project is going to examine the relationship between the distribution of fast food restaurants in the US and obesity rates in the US (by state)

## Target Audience

- **University students**: They do not have much time to prepare their meals, fast food might be the cheapest and fastest alternative.
- **Teenagers below the age of 21**: According to our research, they are the main fast food consumers as fried, salty, high sugar foods seem to be more appealing than healthy alternatives.
- **People who aim to live healthily**: They might be able to access this data and determine states in which they can more easily live healthily.

## Questions To Be Solved

- How much does fast food contribute to obesity?
- Does opening more fast food joints lead to an increase in obesity?
- Do areas with no fast food joints have a low obesity rate?
- Which cities have the least and most obesity rates?
- Which fast food chains seem to be related to higher obesity rates?

## Technical Description

For this project, data will be read in as .csv files. Data wrangling methods, like `select()`, `mutate()`, `filter()`, `inner_join()`, `sample_n()`, `group_by()`, and `summarize()` are required to perform dataset shuffling, merging, and reshaping to fit specific criteria when trying to plot on an interactive map. In addition, the creation of a map through leaflet and the customization of said map to make what is expressed easier to comprehend by users will also be required.

The project would be the form of the _Shiny_ app, the reason being that improves functionality and gives us a chance to work with the Shiny framework. The UI part of the app would be informing people of the relationship between fast food and health. Its visualization would give the clear and the server would help to answer out focusing questions. In addition, we would use some chart to summarize and analyze the data.

The data is in the form of the static `csv` and that would be easily read and converted into data frames by using R commands. An interactive map would show the Fast Food Chain distribution in the US.

### Library used:

We would be using various libraries for this application, `shiny`, `dplyr`, `ggplot2`, `data`, `table`, `tidyr`, etc.

## Disclaimer

- This site is not associated with or endorsed by any restaurant or any government departments.
- The data utilize public information compiled online including the restaurant names with their locations, and public health data including diabetes and obese percentages associated with different counties and states. Data is verified, cleansed, analyzed and aggregated.
- No private information is being used, including restaurant owners information, telephone numbers, and emails. Names, addresses, and website URLs are all publicly listed on the internet.
