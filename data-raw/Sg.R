# code to prepare Solar Generation (Sg) dataset goes here

# currently this is clean data
# data was cleaned AND aligned
# data was subjected to additional 8% losses
Sg <- readr::read_csv("data-raw/Sg.csv")

usethis::use_data(Sg,overwrite = TRUE)
