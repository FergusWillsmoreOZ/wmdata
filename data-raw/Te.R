# code to prepare the Te dataset goes here

(Te <- readr::read_csv("data-raw/Te.csv", skip = 7))

colnames(Te) <- c("dtime","AvgTe 97","AvgTe 5")

Te$dtime %<>% lubridate::dmy_hm()

# the number of missing values
Te %>%
  dplyr::select_if(is.numeric) %>%
  tidyr::gather(variable,value) %>%
  dplyr::group_by(variable) %>%
  dplyr::summarise(na = sum(is.na(value)))

# Pattern of missing data
Te %>%
  dplyr::select_if(is.numeric) %>%
  purrr::map(function(x) bored::inarow(is.na(x))) %>%
  purrr::map(function(x) dplyr::filter(x,value == TRUE))

# use spline to interpolate missing values
Te %<>%
  purrr::map_if(is.numeric,function(x) imputeTS::na_interpolation(x,option = "spline")) %>%
  as.data.frame()

usethis::use_data(Te,overwrite = TRUE)
