## code to prepare fuel dataset goes here

fuel <- read_csv("data-raw/fuel.csv")

colnames(fuel) <- c('year','mine','p_load','p_haul','a_haul','road','rail','power')

fuel$year <- factor(fuel$year)

# gather data on area
fuel %>%
  gather(area,diesel,-year) -> fuel

usethis::use_data(fuel,overwrite = TRUE)
