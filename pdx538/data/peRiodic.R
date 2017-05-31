periodic_table <- readr::read_csv("http://ismayc.github.io/periodic-table-data.csv") %>%
  mutate(block = forcats::fct_relevel(block, "s", "p", "d", "f"))
