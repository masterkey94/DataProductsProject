# UI.R code file for MPG Predictor using Motor Trend Car Road Tests Data
# Objective of the app is to predict a car's miles per gallon performance based 
# on the transmission type, weight, and horsepower of the car

# UI.R will enable user to input the following:
# - transmission type: automatic or manual
# - weight of car: 1000lbs to 6000lbs
# - horsepower of car: 50hp to 500hp

# Output of the will be the following:
# - predicted miles per gallon performance based on the inputs
# - graph of mpg performance vs. weight for predicted value and mtcars data
# - graph of mpg performance vs. horsepoer for predicted value and mtcars data

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  
  # Application title
  titlePanel("MPG Predictor using Motor Trend Car Road Tests Data"),
  
  # Sidebar with inputs for transmission type, horsepower, and weight of car 
  sidebarPanel(
    h4("Please select the values for the transmission type, horsepower, and weight of the car below."),
    radioButtons("Transmission", "Transmission Type:",
                 c("Automatic" = 0, "Manual" = 1), 
                 selected = 0),
    sliderInput("HP",
                 "Horsepower of Car:",
                 min = 50,
                 max = 500,
                   value = 300),
    sliderInput("Weight",
                 "Weight of Car (lbs.):",
                 min = 1000,
                 max = 6000,
                 value = 3000),
    submitButton("Submit")
  ),
    
    # Output predicted mpg and plots
    mainPanel(
      h4("This tool enables you to predict the miles per gallon based on the transmission type, 
        horsepower, and weight of a car based on the data from the Motor Trend Card Road Test 
        data set 'mtcars'.  Then you can compare the resulting predicted mpg versus mpg data from 
        the 'mtcars' data set by horsepower and weight."),
      h3("Predicted miles per gallon: "),
      h3(uiOutput('Transmission')),
      h3("Plot of Miles Per Gallon vs. Horsepower"),
      plotOutput("HPplot"),
      h3("Plot of Miles Per Gallon vs. Weight"),
      plotOutput("Weightplot")

    )
))
