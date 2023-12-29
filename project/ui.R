#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Iris Species Predictor"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            width = 4,
            sliderInput("sepal_l",
                        "Sepal Length:",
                        min = 2,
                        max = 10,
                        value = 5.8,
                        step=0.001),
            sliderInput("sepal_w",
                        "Sepal Width:",
                        min = 1,
                        max = 5,
                        value = 3,
                        step=0.001),
            sliderInput("petal_l",
                        "Petal Length:",
                        min = 0,
                        max = 8,
                        value = 3.7,
                        step=0.001),
            sliderInput("petal_w",
                        "Petal Width:",
                        min = 0,
                        max = 3,
                        value = 1.2,
                        step=0.001),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4(textOutput("prediction_text")),
            h5(textOutput("votes_text")),
            fluidRow(
                column(6, plotlyOutput("sepal_plot")),
                column(6, plotlyOutput("petal_plot"))
            )
        )
    )
)
