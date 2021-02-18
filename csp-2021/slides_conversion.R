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

# Create zip file
utils::zip(
  zipfile = "materials.zip",
  files = c("prereqs.R",
            "slide_code.R",
            "slide_deck.pdf",
            "tidyverse-tools.Rproj")
  )
