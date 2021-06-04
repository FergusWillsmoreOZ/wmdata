## code to prepare the costoz dataset goes here

# developed by SB and maybe TB in Rolling LCOE model
costoz <- readr::read_csv("data-raw/costoz.csv")

usethis::use_data(costoz,overwrite = TRUE)
