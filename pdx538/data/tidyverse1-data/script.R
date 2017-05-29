library(readr)
life_exp_df <- read_csv("le_mess.csv")

library(haven)
who_df <- read_dta("who.dta")

library(readxl)
county_pop_df <- read_excel("cc-oregon.xlsx")

library(jsonlite)
edu_county_df <- fromJSON("education.json")

library(haven)
potus12_df <- read_sav("potus12.sav")

library(tidyr)
?gather

life_exp_tidy <- life_exp_df %>% 
  gather(key = "year", value = "life_exp")

(life_exp_tidy <- life_exp_df %>% 
    gather(key = "year", value = "life_exp", -country))

who_tidy <- who_df %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "value")

library(stringr)
library(dplyr)
who_tidy <- who_tidy %>% 
  mutate(key = str_replace(string = key, 
    pattern = "newrel", 
    replacement = "new_rel"))

who_tidy <- who_tidy %>% 
  separate(col = key, into = c("new", "type", "sexage"), sep = "_")

who_tidy <- who_tidy %>% 
  separate(col = sexage, into = c("sex", "age"), sep = 1)

# Make sure to make file public and File, Publish to Web
library(googlesheets)
library(dplyr)
updated_gap <- gs_key("18L5ZiXd1CQ97XWSqb04x1YQ4ncsEOdR7eHzgX0ZIuPA") %>%
  gs_read()
updated_gap <- gs_title("Updated Gapminder") %>% gs_read()
