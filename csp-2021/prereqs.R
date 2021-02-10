# 1. Ensure you have the current version of R installed
# by running the following in the Console in RStudio
R.version.string

## If the results of the above are less than
## R version 4.0.3, close out of your RStudio and
## go to https://cloud.r-project.org/
## and update your R

# 2. Check you have a recent version of RStudio
# RStudio 1.4.0 or greater recommended
rstudioapi::versionInfo()$version

## If you need to update, check out
## https://rstudio.com/products/rstudio/download/#download

# 3. Install the most recent versions of
# R packages needed for the course
pkgs <- c(
  "tidyverse", "moderndive", "dslabs", 
  "infer", "janitor"
)
install.packages(pkgs, repos = "https://cran.rstudio.org")