## code to prepare Ws dataset goes here

library(imputeTS)
library(tidyverse)
library(magrittr)
devtools::install_github("FergusWillsmoreOZ/bored")

Ws <- readr::read_csv("data-raw/Ws.csv",skip = 11)

colnames(Ws) <- c('dtime',
                  'AvgWs 103.9',
                  'AvgWs 80',
                  'AvgWs 60.1',
                  'AvgWs 39.9'
)

Ws$dtime %<>% lubridate::dmy_hm()

# the number of missing values
Ws %>%
  dplyr::select_if(is.numeric) %>%
  tidyr::gather(variable,value) %>%
  dplyr::group_by(variable) %>%
  dplyr::summarise(na = sum(is.na(value)))

# Pattern of missing data
Ws %>%
  dplyr::select_if(is.numeric) %>%
  purrr::map(function(x) bored::inarow(is.na(x))) %>%
  purrr::map(function(x) dplyr::filter(x,value == TRUE))

# use linear to interpolate missing values - spline behaves weirdly
Ws %<>%
  purrr::map_if(is.numeric,function(x) imputeTS::na_interpolation(x,option = "linear")) %>%
  as.data.frame()

summary(Ws)

Ws[which(Ws$MinWs.80.044<0),]

usethis::use_data(Ws,overwrite = TRUE)
