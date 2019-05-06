# First Shiny Application

library(shiny)

# Define UI for application
ui <- fluidPage(
    titlePanel("First Title"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("This is example help text"),
            selectInput(
                "var",
                label = "Choose a variable to display",
                choices = c("Percent White",
                            "Percent Blue",
                            "Percent Green"),
                selected = "Percent Green"
            ),
            sliderInput(
                "range",
                label = "Range of input",
                min = 0, max = 100, value = c(0,100)
            )
        ),
        
        mainPanel(
            textOutput("selected_var"),
            textOutput("min_max")
        )
    )
    
    
)

# Define server logic 
server <- function(input, output) {
    output$selected_var <- renderText({
        paste("you have selected", input$var)
    })
    
    output$min_max <- renderText({ 
        paste("You have chosen a range that goes from",
              input$range[1], "to", input$range[2])
    })
   
}

# Run the application 
shinyApp(ui = ui, server = server)
