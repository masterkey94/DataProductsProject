# Server.R code file for MPG Predictor using Motor Trend Car Road Tests Data
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

# Load needed libraries
library(shiny)
library(ggplot2)

data(mtcars)

# Fit a linear model on mtcars with am, hp, and wt as predictors
modelfit <- lm(mpg ~ am + hp + wt, data = mtcars)

# Define server logic required to predict mpg
shinyServer(function(input, output) {

    # create data frame with user inputted values for transmission, horsepower, weight from UI
    Data = reactive({
      newmpgdata <- data.frame(am = as.numeric(input$Transmission), hp = input$HP, wt = input$Weight/1000)
        return(list(newmpgdata = newmpgdata))
    })
    
    # create plot data
    plotdata <- data.frame(type = "mtcars Data", hp = mtcars$hp, wt = mtcars$wt, mpg = mtcars$mpg)
    Update = reactive({
      newrow = data.frame(type = "Prediction", 
                          hp = input$HP, 
                          wt = input$Weight/1000, 
                          mpg = predict(modelfit, Data()$newmpgdata))
      plotdata = rbind(plotdata, newrow)
      return(list(plotdata = plotdata))
    })
    
    # output predicted mpg
    output$Transmission <- renderText(round(predict(modelfit, Data()$newmpgdata),2))

    # output plot of weight vs. mpg
    output$Weightplot<- renderPlot({
      p <- ggplot(Update()$plotdata, aes(wt, mpg)) 
      p <- p + geom_point(aes(color = as.factor(type)), size = 5)
      p <- p + labs(x = "Weight ('000s lbs.)", y = "Miles Per Gallon", color = "Data Type")
      p <- p + geom_smooth(method = "lm")
      print(p)
    })

    # output plot of hp vs. mpg
    output$HPplot<- renderPlot({
      p <- ggplot(Update()$plotdata, aes(hp, mpg)) + geom_point(aes(color = as.factor(type)), size = 5)
      p <- p + labs(x = "Horsepower", y = "Miles Per Gallon", color = "Data Type")
      p <- p + geom_smooth(method = "lm")
      print(p)
    })    
    
})
