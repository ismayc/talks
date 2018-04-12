system("/Users/chester/Desktop/infer_workshop/talks/ness-infer/decktape-1.0.0/phantomjs /Users/chester/Desktop/infer_workshop/talks/ness-infer/decktape-1.0.0/decktape.js /Users/chester/Desktop/infer_workshop/talks/ness-infer/slide_deck.html /Users/chester/Desktop/infer_workshop/talks/ness-infer/slide_deck.pdf")

# To R script
knitr::purl("ness-infer/slide_deck.Rmd", "ness-infer/slide_code.R", documentation = 2L)