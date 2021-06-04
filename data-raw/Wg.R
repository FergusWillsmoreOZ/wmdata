## code to prepare Wind Generation (Wg) dataset goes here

# currently this is clean data
# data was cleaned AND aligned
# data was subjected to additional 14% losses
Wg <- readr::read_csv("data-raw/Wg.csv")

usethis::use_data(Wg,overwrite = TRUE)
