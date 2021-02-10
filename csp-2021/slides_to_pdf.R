pagedown::chrome_print(
  "slide_deck.html", 
  output = "slide_deck.pdf"
)

# To R script
knitr::purl(
  "slide_deck.Rmd", 
  "slide_code.R", 
  documentation = 2L
)
