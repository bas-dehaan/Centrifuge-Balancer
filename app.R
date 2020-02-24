# 
# Author: B.M. de Haan
# Github: https://github.com/bas-dehaan/Centrifuge-Balancer/
#

library(shiny)


# Define UI for the application 
ui = fluidPage(

    # Application title
    titlePanel("Centrifuge Balancer"),
    helpText("Based on an Eppendorf Mini Spin centrifuge"),

    # Sidebar with a slider input for number of tubes 
    sidebarLayout(
        sidebarPanel(
            sliderInput("tubes",
                        "Number of tubes:",
                        min = 1,
                        max = 12,
                        value = 6)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("tube_number"),
            textOutput("stable_number"),
            imageOutput("stable_img")
        )
    )
)

server = function(input, output) {
    
    # Display the number of tubes with the correct spelling
    output$tube_number = renderText({
        if(input$tubes==1){
            paste("You have selected", input$tubes, "tube")
        }else{
            paste("You have selected", input$tubes, "tubes")
        }
    })
    
    # Display the hole-numbers to make a stable configuration
    output$stable_number = renderText({
        if(input$tubes==2){
            print("Use holes 1 and 7 to balance")
        }else if(input$tubes==3){
            print("Use holes 1, 5 and 9 to balance")
        }else if(input$tubes==4){
            print("Use holes 1, 4, 7 and 10 to balance")
        }else if(input$tubes==5){
            print("Use holes 1, 4, 5, 9 and 10 to balance")
        }else if(input$tubes==6){
            print("Use holes 1, 3, 5, 7, 9 and 11 to balance")
        }else if(input$tubes==7){
            print("Use holes 1, 2, 5, 6, 8, 9 and 12 to balance")
        }else if(input$tubes==8){
            print("Use holes 1, 2, 4, 5, 7, 8, 10 and 11 to balance")
        }else if(input$tubes==9){
            print("Use holes 1, 2, 4, 5, 6, 8, 9, 10 and 12 to balance")
        }else if(input$tubes==10){
            print("Use holes 1, 2, 3, 5, 6, 7, 8, 9, 11 and 12 to balance")
        }else if(input$tubes==12){
            print("Use holes all to balance")
        }else{
            print("Impossible to balance")
        }
    })
    output$stable_img = renderImage({
        # Select the image corresponding to the input$tubes in the ./images directory
        image_file_path = normalizePath(file.path('./images/', paste0('Centrifuge-', input$tubes, '.jpg')))
        
        # Return a list containing the filename and alt text
        list(src = image_file_path,
             alt = paste("Graphical view of Centrifuge", input$tubes))
        
    }, deleteFile = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)
