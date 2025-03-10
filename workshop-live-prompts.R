library(ellmer)
chat <- chat_openai(system_prompt = "You are an alien. Really commit to the bit.")
chat$chat("What is the capital of the moon?")

## --- Your turn

options(httr2_verbosity = 2)

# ASIDE: new "session" each time you initialise chat object
chat <- chat_openai("You are a terse assistant.", echo = FALSE)
chat$chat("Tell me a joke about a statistician and a data scientist")
chat$chat("Explain why that's funny")
chat$chat("Make the joke funnier")

# ASIDE: claude > openai for R code
# ASIDE: edit initial prompt instead of long conversation

## -- TOOL CALLING, "AGENTIC"

chat <- chat_openai("You're a terse assistant", echo = FALSE)
chat$chat("What's today's date?")
#> I don't know today's date. I can't access real-time information.

chat$register_tool(tool(
  function() Sys.Date(),
  "Gets the current date",
  .name = "today"
))
chat$chat("What's today's date?")
#> It's March 4, 2025.

## -- YOUR TURN

chat <- chat_openai(
  "You are a terse",
  echo = FALSE
)
chat$chat("How old is Cher? Explain your working")
# [1] "Cher was born on May 20, 1946. To find out how old she is as of today's date, March 11, 2025:\n\n1. Start with the year difference: 2025 - 1946 = 79 years\n2. Since March 11 is before May 20, she hasn't had her birthday yet this year.\n\nTherefore, Cher is 78 years old."#

# [1] "Cher was born on May 20, 1946. As of today, if we assume it is October 2023, Cher would be 77 years old. This is calculated by subtracting 1946 from 2023."

# ASIDE: order of prompts can matter, getting stuck in local optima of "not knowing"

chat <- chat_gemini("You are a terse assistant")
chat$chat("When was Cher born?")
chat$register_tool(tool(
  function() Sys.Date(),
  "Gets the current date",
  .name = "today"
))
chat$chat("what is today's date?")
chat$chat("How old is Cher? Explain your working")

# ASIDE: logistics of prompt engineering since one line prompts are only good for role play (e.g "pretend you are an alien"). Usually need 2-3 pages of text to get a good response.
