#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("~/Documents/ShinyApplications/census-app/helpers.R")
counties <- readRDS("~/Documents/ShinyApplications/census-app/data/counties.rds")
library(maps)
library(mapproj)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Census Visualization"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            helpText("Create demographic maps with info from 2010 US Census"),
            selectInput(inputId = "var",
                        label = "Choose a variable to display",
                        choices = c("Percent White", "Percent Black",
                                    "Percent Hispanic", "Percent Asian"),
                        selected = "Percent Asian"),
            sliderInput(inputId = "range",
                        label = "Range of Interest",
                        min = 0,
                        max = 100,
                        value = c(0,100))
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput(outputId = "map")
        )
    )
)

# Define server logic required to draw a the percent map
server <- function(input, output) {
    output$map <- renderPlot({
        data <- switch(input$var, 
                       "Percent White" = counties$white,
                       "Percent Black" = counties$black,
                       "Percent Hispanic" = counties$hispanic,
                       "Percent Asian" = counties$asian)
        
        color <- switch(input$var, 
                        "Percent White" = "darkgreen",
                        "Percent Black" = "black",
                        "Percent Hispanic" = "darkorange",
                        "Percent Asian" = "darkviolet")
        
        legend <- switch(input$var, 
                         "Percent White" = "% White",
                         "Percent Black" = "% Black",
                         "Percent Hispanic" = "% Hispanic",
                         "Percent Asian" = "% Asian")
        
        percent_map(var = data, color = color, legend, input$range[1], input$range[2])
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
