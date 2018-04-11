## ----include=FALSE, purl=TRUE--------------------------------------------
#specify the packages of interest
pkgs <- c("tidyverse", "moderndive", "gapminder",
          "nycflights13", "fivethirtyeight", "janitor",
          "ggplot2movies", "remotes")

# use this function to check if each package is on the local machine
# if a package is installed, it will be loaded
# if any are not, the missing package(s) will be installed and loaded
pkg.check <- function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE, repos = "https://cran.rstudio.com")
        library(x, character.only = TRUE)
    }
}
lapply(pkgs, pkg.check)

if(!require("infer"))
  remotes::install_github("andrewpbray/infer")

## ----echo=FALSE, purl=TRUE-----------------------------------------------
library(tibble)
library(lubridate)
ex1 <- data_frame(
    vec1 = c(1980, 1990, 2000, 2010),
    vec2 = c(1L, 2L, 3L, 4L),
    vec3 = c("low", "low", "high", "high"),
    vec4 = c(TRUE, FALSE, FALSE, FALSE),
    vec5 = ymd(c("2017-05-23", "1776/7/04", "1983-5/31", "1908/04-1"))
  )
ex1

## ---- purl=TRUE----------------------------------------------------------
library(gapminder)
gapminder

## ---- purl=TRUE----------------------------------------------------------
# Base R
asia <- gapminder[gapminder$continent == "Asia", ]
mean(asia$lifeExp)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
library(dplyr)
gapminder %>% filter(continent == "Asia") %>%
  summarize(mean_exp = as.numeric(format(mean(lifeExp), digits = 5))) %>% 
  pull()

## ---- purl=TRUE----------------------------------------------------------
library(gapminder); library(dplyr)
gap_2007 <- gapminder %>% filter(year == 2007)
head(gap_2007, 4)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
set.seed(2018)
gapminder %>% 
  filter(year == 2002 | continent == "Asia") %>% 
  sample_n(8)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
gapminder %>% 
  filter(year == 2002, continent == "Asia") %>% 
  head(8)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
gapminder %>% 
  filter(country %in% c("Argentina", "Belgium", "Mexico"),
         year %in% c(1987, 1992))

## ----echo=FALSE, purl=TRUE-----------------------------------------------
stats_1997 <- gapminder %>% 
  filter(year == 1997) %>% 
  summarize(max_exp = max(lifeExp),
            sd_exp = sd(lifeExp))
stats_1997

## ----echo=FALSE, purl=TRUE-----------------------------------------------
max_exp_1997_by_cont <- gapminder %>% 
  filter(year == 1997) %>% 
  group_by(continent) %>%
  summarize(max_exp = max(lifeExp),
            sd_exp = sd(lifeExp))
max_exp_1997_by_cont

## ---- purl=TRUE----------------------------------------------------------
gap_plus <- gapminder %>% mutate(just_one = 1)
head(gap_plus, 4)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
set.seed(2)

## ---- purl=TRUE----------------------------------------------------------
gap_w_gdp <- gapminder %>% mutate(gdp = pop * gdpPercap)
sample_n(gap_w_gdp, 4)

## ---- purl=TRUE----------------------------------------------------------
gap_weird <- gapminder %>% mutate(pop = pop + 1000)
head(gap_weird, 4)

## ---- purl=TRUE----------------------------------------------------------
gapminder %>% arrange(year, country) %>% head(10)

## ----desc, purl=TRUE-----------------------------------------------------
gapminder %>%
  filter(year > 2000) %>%
  arrange(desc(lifeExp)) %>%
  head(10)

## ----purl=TRUE-----------------------------------------------------------
gapminder %>% group_by(year)

## ----purl=TRUE-----------------------------------------------------------
gapminder %>% arrange(year)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
simple_ex <-
  data_frame(
    A = c(1980, 1990, 2000, 2010),
    B = c(1, 2, 3, 4),
    C = c(3, 2, 1, 2),
    D = c("cold", "cold", "hot", "hot")
  )
simple_ex

## ---- echo=FALSE, fig.height=4.4, purl=TRUE------------------------------
ggplot(data = simple_ex, aes(x = A, y = B)) + 
  geom_point()

## ---- echo=FALSE, fig.height=4.4, purl=TRUE------------------------------
ggplot(data = simple_ex, mapping = aes(x = A, y = B)) + 
  geom_point(mapping = aes(color = D))

## ---- echo=FALSE, fig.height=4.4, purl=TRUE------------------------------
ggplot(data = simple_ex, mapping = aes(x = A, y = B, size = C)) + 
  geom_point()

## ----fig.height=5.5, purl=TRUE-------------------------------------------
library(nycflights13)
ggplot(data = weather, mapping = aes(x = humid)) +
  geom_histogram(bins = 20, color = "black", fill = "darkorange")

## ----fig.height=5.5, purl=TRUE-------------------------------------------
library(nycflights13)
ggplot(data = weather, mapping = aes(x = month, y = humid)) +
  geom_boxplot()

## ----fig.height=5.5, purl=TRUE-------------------------------------------
library(nycflights13)
ggplot(data = weather, mapping = aes(x = factor(month), y = humid)) +
  geom_boxplot()

## ----fig.height=5.5, purl=TRUE-------------------------------------------
library(fivethirtyeight)
ggplot(data = bechdel, mapping = aes(x = clean_test)) +
  geom_bar()

## ---- purl=TRUE----------------------------------------------------------
library(dplyr)
year_bins <- c("'70-'74", "'75-'79", "'80-'84", "'85-'89",
               "'90-'94", "'95-'99", "'00-'04", "'05-'09",
               "'10-'13")
bechdel <- bechdel %>%
  mutate(five_year = cut(year, 
                         breaks = seq(1969, 2014, 5), 
                         labels = year_bins))

## ----fig.width=11, fig.height=5, purl=TRUE-------------------------------
library(fivethirtyeight)
library(ggplot2)
ggplot(data = bechdel,
       mapping = aes(x = five_year, fill = clean_test)) +
  geom_bar()

## ----fig.width=11, fig.height=5, purl=TRUE-------------------------------
library(fivethirtyeight)
library(ggplot2)
ggplot(data = bechdel,
       mapping = aes(x = five_year, fill = clean_test)) +
  geom_bar(position = "dodge")

## ----fig.width=11, fig.height=5, purl=TRUE-------------------------------
library(fivethirtyeight)
library(ggplot2)
ggplot(data = bechdel,
       mapping = aes(x = five_year, fill = clean_test)) +
  geom_bar(position = "fill", color = "black")

## ----echo=FALSE, message=FALSE, warning=FALSE, purl=TRUE-----------------
library(fivethirtyeight)
set.seed(2)
bechdel %>% sample_n(12) %>%
  select(year, title, clean_test, budget_2013) %>%
  arrange(title)

## ----echo=FALSE, message=FALSE, warning=FALSE, purl=TRUE-----------------
dem_score <- read_csv("https://raw.githubusercontent.com/ismayc/talks/master/ness-infer/data/dem_score.csv")
dem_score %>% slice(1:12)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
library(tidyr)
dem_score_tidy <- dem_score %>% 
  gather(-country, key = "year", value = "dem_score") %>% 
  mutate(year = as.integer(year)) 
dem_score_tidy %>% sample_n(10) %>% arrange(country)

## ----purl=TRUE-----------------------------------------------------------
dem_score4 <- dem_score_tidy %>%
  filter(country %in% c("Australia", "Pakistan", "Portugal", "Uruguay"))
ggplot(data = dem_score4, mapping = aes(x = year, y = dem_score)) +
  geom_line(mapping = aes(color = country), size = 2)

## ----echo=FALSE, fig.height=7.5, fig.width=10, purl=TRUE-----------------
library(gapminder)
library(tidyverse)
gapminder_2007 <- gapminder %>% filter(year == 2007)
ggplot(data = gapminder_2007, 
       mapping = aes(x = gdpPercap, y = lifeExp, 
                     size = pop, color = continent)) +
  geom_point()

## ----purl=TRUE-----------------------------------------------------------
library(moderndive)
bowl

## ----purl=TRUE-----------------------------------------------------------
set.seed(1977)
( bowl_sample <- bowl %>% sample_n(size = 50) )

## ----purl=TRUE-----------------------------------------------------------
bowl_sample %>% 
  summarize(prop_red = mean(color == "red")) %>% 
  pull()

## ----purl=TRUE-----------------------------------------------------------
library(moderndive)
rep_bowl_samples <- bowl %>% 
  rep_sample_n(size = 50, reps = 10000)

## ----purl=TRUE-----------------------------------------------------------
bowl_props <- rep_bowl_samples %>% 
  group_by(replicate) %>% 
  summarize(prop_red = mean(color == "red"))

## ----fig.height=4.7, purl=TRUE-------------------------------------------
ggplot(data = bowl_props, mapping = aes(x = prop_red)) +
  geom_histogram(binwidth = 0.02, color = "white")

## ----purl=TRUE-----------------------------------------------------------
bowl_sample %>% count(color)

## ----purl=TRUE-----------------------------------------------------------
library(infer)
bowl_sample %>% 
  specify(formula = color ~ NULL, success = "red")

## ----purl=TRUE-----------------------------------------------------------
library(infer)
( bootstrap_samples <- bowl_sample %>% 
  specify(formula = color ~ NULL, success = "red") %>% 
  generate(reps = 48, type = "bootstrap") )

## ----purl=TRUE-----------------------------------------------------------
bowl_sample %>% 
  specify(formula = color ~ NULL, success = "red") %>% 
  generate(reps = 48, type = "bootstrap") %>% 
  calculate(stat = "prop")

## ----purl=TRUE-----------------------------------------------------------
bootstrap_stats <- bowl_sample %>% 
  specify(formula = color ~ NULL, success = "red") %>% 
  generate(reps = 10000, type = "bootstrap") %>% 
  calculate(stat = "prop")

## ----fig.height=2.7, echo=FALSE, purl=TRUE-------------------------------
ggplot(data = bootstrap_stats, mapping = aes(x = stat)) +
  geom_histogram(binwidth = 0.02, color = "white") +
  geom_vline(xintercept = mean(bootstrap_stats$stat), color = "red",
             size = 2) +
  xlim(0.15, 0.55) +
  geom_vline(xintercept = c(mean(bootstrap_stats$stat) - sd(bootstrap_stats$stat), mean(bootstrap_stats$stat) + sd(bootstrap_stats$stat)), color = "red", size = 1.5)

## ----fig.height=2.7, echo=FALSE, purl=TRUE-------------------------------
ggplot(data = bowl_props, mapping = aes(x = prop_red)) +
  geom_histogram(binwidth = 0.02, color = "white") +
  geom_vline(xintercept = mean(bowl_props$prop_red), color = "red",
             size = 2) +
  xlim(0.15, 0.55) +
  geom_vline(xintercept = c(mean(bowl_props$prop_red) - sd(bowl_props$prop_red), mean(bowl_props$prop_red) + sd(bowl_props$prop_red)), color = "red", size = 1.5)

## ----purl=TRUE-----------------------------------------------------------
group <- c(rep("control", 12), rep("seed", 24), 
            rep("control", 4), rep("seed", 10))
yawn <- c(rep(0, 36), rep(1, 14))
yawn_myth <- data_frame(subj = seq(1, 50), group, yawn) %>% 
  mutate(yawn = factor(yawn))
slice(yawn_myth, c(5, 17, 37, 49))

## ----purl=TRUE-----------------------------------------------------------
library(janitor)
yawn_myth %>% 
  tabyl(group, yawn) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting() %>% 
  adorn_ns()

## ----purl=TRUE-----------------------------------------------------------
yawn_myth %>%
  group_by(group) %>%
  summarize(prop = mean(yawn == 1))

## ----purl=TRUE-----------------------------------------------------------
(obs_diff <- yawn_myth %>%
  group_by(group) %>%
  summarize(prop = mean(yawn == 1)) %>%
  summarize(diff(prop)) %>%
  pull())

## ----echo=FALSE, purl=TRUE-----------------------------------------------
yawn_myth %>% 
  slice(c(1:6, 15:20))
yawn_myth %>% 
  tabyl(group, yawn) %>% 
  adorn_totals(where = c("row", "col"))

## ----echo=FALSE, purl=TRUE-----------------------------------------------
set.seed(2018)
perm1 <- yawn_myth %>% 
  specify(formula = yawn ~ group,
           success = "1") %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1, type = "permute") %>% 
  ungroup() %>% 
  mutate(subj = seq(1,50)) %>% 
  select(subj, group, alt_yawn = yawn) 
perm1 %>% 
  slice(c(1:6, 15:20))
perm1 %>% 
  tabyl(group, alt_yawn) %>% 
  adorn_totals(where = c("row", "col"))

## ----echo=FALSE, purl=TRUE-----------------------------------------------
yawn_universes <- yawn_myth %>% 
  specify(yawn ~ group,
          success = "1") %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "diff in props", 
            order = c("seed", "control"))
yawn_universes

## ----echo=FALSE, purl=TRUE-----------------------------------------------
yawn_universes %>% 
  slice(991:1000)

## ----echo=FALSE, purl=TRUE-----------------------------------------------
set.seed(2)
null_distn <- yawn_myth %>% 
  specify(formula = yawn ~ group,
          success = "1") %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "diff in props", 
            order = c("seed", "control"))
null_plot <- null_distn %>% 
  visualize(obs_stat = obs_diff, direction = "right") +
  labs(x = "Difference in proportions")
null_plot

## ----echo=FALSE, purl=TRUE-----------------------------------------------
null_distn %>% 
  summarize(n_as_big = sum(stat >= obs_diff),
            n_total = n(),
            p_value = mean(stat >= obs_diff))

## ----include=FALSE, purl=TRUE--------------------------------------------
set.seed(8)
null_distn <- yawn_myth %>% 
  specify(formula = yawn ~ group, success = "1") %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "diff in props", order = c("seed", "control"))

## ----purl=TRUE-----------------------------------------------------------
null_distn %>% 
  visualize(obs_stat = obs_diff, direction = "right")

## ----include=FALSE, purl=TRUE--------------------------------------------
theme_set(theme_gray(base_size = 22))
yawn_table <- table(group, yawn)
yz <- prop.test(x = yawn_table, n = nrow(yawn_myth),
          alternative = "greater", correct = FALSE) 
obs_z <- yz %>% 
  broom::tidy(yz) %>% 
  pull(statistic)

## ----include=FALSE, purl=TRUE--------------------------------------------
yawn_myth %>%
  specify(yawn ~ group, success = "1") %>%
  hypothesize(null = "independence") %>% 
  # generate() is not needed since we are not doing simulation
  calculate(stat = "z", order = c("seed", "control")) %>%
  visualize(method = "theoretical", obs_stat = obs_z,
            direction = "right")

## ----echo=FALSE, fig.height=4.5, warning=TRUE, purl=TRUE-----------------
yawn_myth %>%
  specify(yawn ~ group, success = "1") %>%
  hypothesize(null = "independence") %>% 
  # generate() is not needed since we are not doing simulation
  calculate(stat = "z", order = c("seed", "control")) %>%
  visualize(method = "theoretical", obs_stat = obs_z,
            direction = "right")

## ----fig.height=2.8, warning=TRUE, purl=TRUE-----------------------------
yawn_myth %>%
  specify(yawn ~ group, success = "1") %>%
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "z", order = c("seed", "control")) %>% 
  visualize(method = "both", bins = 10, obs_stat = obs_z, 
            direction = "right")

## ---- purl=TRUE----------------------------------------------------------
library(readr)
mazes <- read_csv("http://bit.ly/mazes-gist") %>% 
  clean_names() %>%  #janitor package
  filter(dx %in% c("ASD", "TD"))

