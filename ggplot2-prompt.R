library(ellmer)

iris_glimpse <- paste0(capture.output(dplyr::glimpse(iris)), collapse = "\n")
diamonds_glimpse <- paste0(capture.output(dplyr::glimpse(ggplot2::diamonds)), collapse = "\n")

prompt <- interpolate_file("ggplot2-prompt.md", glimpse = diamonds_glimpse)
cat(prompt)

chat <- chat_gemini()
chat$chat(prompt)

## -- ASIDE: what do you put into system prompt vs. user chat prompt?;
# - HW: don't know?; system prompt is "stronger" -- trunk of tree
# HW: openAI has hierarchy of prompts -- that even the system prompt underneath
# MOW: system prompt forgetten? -- HW: newer models are trying to prevent loss of system prompt
