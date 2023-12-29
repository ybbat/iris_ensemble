#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(caretEnsemble)
library(plotly)

models <- readRDS("model.rds")

data(iris)

# Define server logic required to draw a histogram
function(input, output, session) {
    data <- reactive({
        df <- data.frame(
            Sepal.Length = input$sepal_l,
            Sepal.Width = input$sepal_w,
            Petal.Length = input$petal_l,
            Petal.Width = input$petal_w
        )
        p <- predict(models, newdata=df)
        df["pred"] <- p
        df
    })

    output$prediction_text <- renderText({
        p <- data()$pred
        paste("Predicted Species:", max(p))
    })

    output$votes_text <- renderText({
        p <- data()$pred
        votes <- paste(colnames(p), " (", as.character(p), ")", sep="")
        string_votes <- paste0(votes, collapse=", ")
        paste("Votes: ", string_votes)
    })

    output$sepal_plot <- renderPlotly({
        selection <- data()
        plot_ly(
            data=iris,
            x = ~Sepal.Width,
            y = ~Sepal.Length,
            color = ~Species,
            type = "scatter",
            mode = "markers"
        ) %>% add_markers(
            x=selection$Sepal.Width,
            y=selection$Sepal.Length,
            text="Selection",
            inherit=FALSE,
            showlegend=FALSE
        ) %>% layout(
                title = "Sepal Dimensions",
                xaxis = list(title = "Sepal Width"),
                yaxis = list(title = "Sepal Length")
            )
    })

    output$petal_plot <- renderPlotly({
        selection <- data()
        plot_ly(
            data=iris,
            x = ~Petal.Width,
            y = ~Petal.Length,
            color = ~Species,
            type = "scatter",
            mode = "markers"
        ) %>%add_markers(
            x=selection$Petal.Width,
            y=selection$Petal.Length,
            text="Selection",
            inherit=FALSE,
            showlegend=FALSE
        ) %>% layout(
                title = "Petal Dimensions",
                xaxis = list(title = "Petal Width"),
                yaxis = list(title = "Petal Length")
            )
    })
}
