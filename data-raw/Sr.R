## code to prepare Sr dataset goes here

Sr <- readr::read_csv("data-raw/Sr.csv",skip = 9)

colnames(Sr) <- c('dtime','AvgSr','AvgSr2','StdSr','StdSr2','MaxSr','MaxSr2','MinSr','MinSr2')

Sr$dtime %<>% lubridate::dmy_hm()

# the number of missing values
Sr %>%
  dplyr::select_if(is.numeric) %>%
  tidyr::gather(variable,value) %>%
  dplyr::group_by(variable) %>%
  dplyr::summarise(na = sum(is.na(value)))

# Pattern of missing data
Sr_miss <- Sr %>%
  dplyr::select_if(is.numeric) %>%
  purrr::map(function(x) bored::inarow(is.na(x))) %>%
  purrr::map(function(x) dplyr::filter(x,value == TRUE))

## inspect interpolation
# miss_ind <- Sr_miss$AvgSr %>% apply(1,function(x) x[3]:x[4])

# interp_val <- Sr %>%
#   purrr::map_if(is.numeric,function(x) imputeTS::na_interpolation(x,option = "linear")) %>%
#   as.data.frame()

# use spline to interpolate missing values
Sr %<>%
  purrr::map_if(is.numeric,function(x) imputeTS::na_interpolation(x,option = "linear")) %>%
  as.data.frame()

usethis::use_data(Sr,overwrite = TRUE)
