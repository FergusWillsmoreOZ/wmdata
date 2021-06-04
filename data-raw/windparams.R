## code to prepare tecno dataset goes here

windparams <- read_csv("data-raw/windparams.csv")

windparams[order(windparams$name),] -> windparams

usethis::use_data(windparams,overwrite = TRUE)
