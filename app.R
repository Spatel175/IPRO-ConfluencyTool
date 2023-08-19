library(imager)
library(dplyr)
library(shiny)
library(shinyjs)

# Define UI for application
ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  titlePanel("Confluency Analysis App"),
  sidebarLayout(
    sidebarPanel(
      fileInput("image_file", "Select an image file."),
      helpText("Invert image before processing"),
      checkboxInput("invert_colors", "Invert Image Colors"),
      helpText("Adjust the alpha value to control the edge detection sensitivity. Lower value means higher sensitivity and more run time."),
      sliderInput("alpha_value", "Alpha Value:", min = 0, max = 1, value = 0.4, step = 0.01),
      actionButton("analyze_button", "Analyze")
    ),
    mainPanel(
      conditionalPanel(
        condition = "!is.null(loaded_image())",
        plotOutput("loaded_image_plot")
      ),
      conditionalPanel(
        condition = "input.analyze_button > 0",
        plotOutput("before_plot"),
        plotOutput("after_plot"),
        verbatimTextOutput("result_summary"),
        verbatimTextOutput("result_alpha_value"),
        verbatimTextOutput("covered_pixels"),
        p("Note: Please confirm the coverage by dividing the covered pixels by image area (height x width in pixels). Image properties may be corrupted.")
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  loaded_image <- reactiveVal(NULL)
  image_filename <- reactiveVal(NULL)
  
  observeEvent(input$image_file, {
    img_path <- input$image_file$datapath
    img_filename <- input$image_file$name
    img <- load.image(img_path)
    
    # Invert image colors if checkbox is selected
    if (input$invert_colors) {
      img <- 255 - img
    }
    
    loaded_image(img)
    image_filename(img_filename)
  })
  
  output$loaded_image_plot <- renderPlot({
    if (!is.null(loaded_image())) {
      plot(loaded_image(), main = "Loaded Image")
    }
  })
  
  observeEvent(input$invert_colors, {
    img <- loaded_image()
    if (!is.null(img)) {
      if (input$invert_colors) {
        img <- 255 - img
      }
      loaded_image(img)
    }
  })
  
  observeEvent(input$analyze_button, {
    shinyjs::disable("analyze_button")  # Disable the button
    
    img <- loaded_image()
    alpha_value <- input$alpha_value  # Get user input alpha value
    
    pxc <- cannyEdges(img, alpha = alpha_value, sigma = 1)
    px1 <- fill(pxc, 28)
    covered_pixels <- sum(table(px1)[-1])
    cell_assay <- (covered_pixels / (width(img) * height(img))) * 100
    
    # Display results in the UI
    output$image_results <- renderUI({
      titlePanel(if (!is.null(image_filename())) {
        paste("Image Analysis -", image_filename())
      } else {
        "Image Analysis"
      })
      
      HTML(paste("Cell coverage:", cell_assay, "%<br>"))
    })
    
    output$before_plot <- renderPlot({
      plot(colorise(img, grow(pxc, 3), "red", alpha = 1), main = "CannyEdge Detection Algorithm",  ylab = "", yaxt='n')
    })
    
    output$after_plot <- renderPlot({
      plot(px1, main = "After filling-in", ylab="", yaxt="n")
    })
    
    output$result_summary <- renderPrint({
      paste("Cell coverage:", round(cell_assay,digits = 4), "%")
    })
    output$result_alpha_value <- renderPrint({
      paste("Alpha Value:", alpha_value)
    })
    output$covered_pixels <- renderPrint({
      paste("Covered Pixels:", covered_pixels)
    })
    
    shinyjs::enable("analyze_button")  # Enable the button after analysis
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
