pagedown::chrome_print(
  "csp-2021/slide_deck.html", 
  output = "csp-2021/slide_deck.pdf"
)

# To R script
knitr::purl(
  "csp-2021/slide_deck.Rmd", 
  "csp-2021/slide_code.R", 
  documentation = 2L
)
