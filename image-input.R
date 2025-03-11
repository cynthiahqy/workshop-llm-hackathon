library(ellmer)

chat <- chat_gemini()

image_path <- "images/diagram_PRITS-framework.png"

chat$chat(
  content_image_file(image_path),
  "Describe this diagram"
)

chat <- chat_gemini()
image_path <- "images/how-to-pitch_worklife-adam-grant.png"
chat$chat(
  content_image_file(image_path),
  # "Describe this diagram",
  "Describe this image"
)

chat$chat(
  content_image_file("holly-mandarich-3p9zaNwUtv8-unsplash.jpg"),
  "Describe this photo"
)
chat$chat("Where in the world do you think it is?")
