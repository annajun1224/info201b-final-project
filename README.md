# info201b-final-project
Final project for Info 201 b

```
Project Proposal

Project Group Members: Junyi Huang, Ivy Zheng, Frank Yu, WenChia Rong
INFO 201 | BA Section | Shiva Rithwick Anem
```


# Project Description

## Here is the dataset that we are going to use:
Fast food restaurant distribution in US, provided by Datafiniti, which provides instant access to web data. Datafiniti compile data from thousands of websites to create standardized databases of business, product, and property information
Health data in the United States (focusing on obesity data), provided by the United States Department of Agriculture Economic Research Service. 
Our project is going to examine the relationship between the distribution of fast food restaurants in the US and obesity rates in US (by state)

## The target audience for the project would be:
University students: They do not have much time to prepare their meals, fast food might be the cheapest and fastest alternative.
Teenagers below the age of 21: According to our research, they are the main fast food consumers as fried, salty, high sugar foods seem to be more appealing than healthy alternatives.
People who aim to live healthy: They might be able to access this data and determine states in which they can more easily live healthy

## What would want to focus on these questions?
Which cities have the least and most obesity rates?
How are different fast food chains distributed across the US? 
Which fast food chains seem to be related to higher obesity rates?
Cities with the most and least of a specific fast food chain per capita


## Technical Description 

For this project, data will be read in as .csv files. Data wrangling methods required are mostly the reshaping of data and possible merging of datasets to fit specific criteria when trying to plot on an interactive map. In addition, the creation of a map through leaflet and the customization of said map to make what is expressed easier to comprehend by users will also be required. 

The project would be the form of the SHINY app, the reason being that improves functionality and gives us a chance to work with the Shiny framework. The UI part of the app would be informing people the relationship between fast food and health. Its visualization would gave the clear and the server would help to answer out focusing questions. In addition, we would use some chart to summarize and analysis the data.

The data is in form of the static csv and that would be easily read and converted into data frames by using R commands. An interactive map would show the Fast Food Chain distribution in US. 

## Library used: 
We would be using various libraries for this application, shiny, dplyr, ggplot2, data, table, tidyr, etc.


## Major challenges:
The major challenges which would come up in this assignment would develop an appropriate and useful visualization of the dataset. 
Work collaboratively with team member because we are working on different version of computer, when we pull those files into our own laptop, formatting might change.
Finding a correct unique ID for the datasets so that we are able to join them into a single larger set for further filtering and such.
Since the datasets themselves are all quite large (many columns and rows), shuffling through them to find useful information may be a challenge as well.










