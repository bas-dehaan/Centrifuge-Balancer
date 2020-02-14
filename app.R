#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histograms
ui <- fluidPage(

    # Application title
    titlePanel("Centrifuge Balancer"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("cupjes",
                        "Aantal cupjes:",
                        min = 1,
                        max = 12,
                        value = 6)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        cupjes <- seq(min(x), max(x), length.out = input$cupjes + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = cupjes, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
