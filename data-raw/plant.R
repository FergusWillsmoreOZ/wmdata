## code to prepare tecno dataset goes here

plant <- read_csv("data-raw/plant.csv")

usethis::use_data(plant,overwrite = TRUE)
