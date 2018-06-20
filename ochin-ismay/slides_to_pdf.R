system("/Users/chester/Desktop/old/talks/ochin-ismay/decktape-1.0.0/phantomjs /Users/chester/Desktop/old/talks/ochin-ismay/decktape-1.0.0/decktape.js /Users/chester/Desktop/old/talks/ochin-ismay/slide_deck.html /Users/chester/Desktop/old/talks/ochin-ismay/slide_deck.pdf")

# To R script
knitr::purl("ness-infer/slide_deck.Rmd", "ness-infer/slide_code.R", documentation = 2L)
