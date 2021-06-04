## code to prepare the cost_engie dataset goes here

(cost_engie <- readr::read_csv("data-raw/cost_engie.csv"))

cost_engie %>%
  dplyr::select(-units,-source) -> cost_engie

usethis::use_data(cost_engie,overwrite = TRUE)
