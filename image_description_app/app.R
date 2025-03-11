# Load necessary libraries
library(shiny)
library(shinychat)
library(ellmer)

# Define the UI
ui <- fluidPage(
  titlePanel("Image Description with Gemini"),
  sidebarLayout(
    sidebarPanel(
      fileInput("uploaded_image", "Upload an Image:", accept = c("image/png", "image/jpeg")),
      textInput("user_prompt", 
        "Enter your prompt:",
        "Describe this image/diagram/sketchnote"),
      actionButton("submit", "Submit")
    ),
    mainPanel(
      chat_ui("chat"),
      uiOutput("uploaded_image")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  chat <- chat_gemini(system_prompt = "
    You are an image description assistant.
    Return all descriptions as markdown code.
    ")

  observeEvent(input$submit, {
    req(input$uploaded_image)
    req(input$user_prompt)

    # Read the image
    image_path <- input$uploaded_image$datapath

    # Display the image
    output$imageDisplay <- renderUI({
      img(src = image_path, width = "100%")
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

shinyApp(ui, server)
