## code to prepare cost_wsp dataset goes here

(cost_wsp <- readr::read_csv("data-raw/cost_wsp.csv"))

# rearrange and tidy the dataframe
cost_wsp %>%
  dplyr::group_by(group,variable) %>%
  dplyr::summarise(value = sum(value)) %>%
  tidyr::spread(variable,value) -> cost_wsp

# update NA values to zero
cost_wsp[is.na(cost_wsp)] <- 0

usethis::use_data(cost_wsp,overwrite = TRUE)
