## code to prepare Ws dataset goes here

Ws <- readr::read_csv("data-raw/Ws.csv",skip = 9)

colnames(Ws) <- c('dtime',
                  'AvgWs 103.9 044',
                  'AvgWs 103.9 224',
                  'AvgWs 80 044',
                  'AvgWs 60.1 044',
                  'AvgWs 39.9 044',
                  'StdWs 103.9 044',
                  'StdWs 103.9 244',
                  'StdWs 80 044',
                  'StdWs 60.1 044',
                  'StdWs 39.9 044',
                  'MaxWs 103.9 044',
                  'MaxWs 103.9 224',
                  'MaxWs 80 044',
                  'MaxWs 60.1 044',
                  'MaxWs 39.9 044',
                  'MinWs 103.9 044',
                  'MinWs 103.9 224',
                  'MinWs 80 044',
                  'MinWs 60.1 044',
                  'MinWs 39.9 044'
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

# use spline to interpolate missing values
Ws %<>%
  purrr::map_if(is.numeric,function(x) imputeTS::na_interpolation(x,option = "linear")) %>%
  as.data.frame()

summary(Ws)

Ws[which(Ws$MinWs.80.044<0),]

usethis::use_data(Ws,overwrite = TRUE)
