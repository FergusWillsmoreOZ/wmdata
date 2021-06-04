## code to prepare the conprod_12 dataset goes here

conprod_12 <- readr::read_csv("data-raw/conprod_12.csv")

usethis::use_data(conprod_12,overwrite = TRUE)
