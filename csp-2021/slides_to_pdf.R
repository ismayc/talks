system("/Users/chester/Desktop/talks/csp-2021/decktape-1.0.0/phantomjs /Users/chester/Desktop/talks/csp-2021/decktape-1.0.0/decktape.js /Users/chester/Desktop/talks/csp-2021/slide_deck.html /Users/chester/Desktop/talks/csp-2021/slide_deck.pdf")

# To R script
knitr::purl("slide_deck.Rmd", "slide_code.R", documentation = 2L)
