# Load necessary libraries
library(shiny)
library(shinychat)
library(ellmer)

# Define the UI
ui <- fluidPage(
  titlePanel("Image Description with Gemini"),
  sidebarLayout(
    sidebarPanel(
      fileInput("image", "Upload an Image:", accept = c("image/png", "image/jpeg")),
      textInput("user_prompt", "Enter your prompt:", ""),
      actionButton("submit", "Submit")
    ),
    mainPanel(
      chat_ui("chat"),
      uiOutput("imageDisplay")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  chat <- chat_gemini(system_prompt = "You are an image description assistant.")

  observeEvent(input$submit, {
    req(input$image)
    req(input$user_prompt)

    # Read the image
    image_path <- input$image$datapath

    # Display the image
    output$imageDisplay <- renderUI({
      img(src = input$image$datapath, width = "100%")
    })

    # Pass image and prompt to Gemini
    stream <- chat$stream_async(
      content_image_file(image_path),
      input$user_prompt
    )

    # Display chat output
    chat_append("chat", stream)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
