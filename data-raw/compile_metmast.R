# Compile metmast data

# Download unified, validated and calibrated data from WindServer:
# https://ws1.windserver.com/windserver/

# load packages
library(tidyverse)
library(magrittr)
devtools::install_github("FergusWillsmoreOZ/bored")

removeWords <- function(str, stopwords) {
  # removes the stopwords from the str string
  x <- unlist(strsplit(str, " "))
  paste(x[!x %in% stopwords], collapse = " ")
}

clean_data_names <- function(names) {

  # define data descriptors
  descriptors <- c("Calibrated","Valid","Unified","Site")

  # remove descriptors
  names %<>% sapply(function(x) removeWords(str = x, stopwords = descriptors))

  # remove units
  names %<>% gsub("\\s*\\([^\\)]+\\)","",.)

  # tidy
  names %<>% trimws() %>% gsub(" ","_",.)

  return(names)
}

path_to_data <- "data-raw/metmast/"

filenames <- list.files(path_to_data) %>% paste0(path_to_data,.)

data <- filenames %>%
  map(function(x) readr::read_csv(file = x,skip = 10)) %>%
  bind_rows()

# rename date variable
data %<>% rename(datetime = `End of Interval`)

# set class as datetime
data$datetime %<>% lubridate::dmy_hm()

# clean the variable names
colnames(data) %<>% clean_data_names()

# get index of duplicate variables
dup_ind <- colnames(data)[duplicated(colnames(data))] %>% sapply(function(x) which(colnames(data) == x)[2])

# drop duplicae variables
data <- data[,-dup_ind]

# index of variables with less than 20% missing
present_ind <- data %>% map(function(x) 100*sum(is.na(x))/length(x)) < 20

# remove variables with over 20% missing data
data[,present_ind] -> data

# linearly interpolate missing data
data %<>% map_df(imputeTS::na_interpolation)

# override Solar observations with average of the two sensors
data %<>%
  rowwise() %>%
  mutate(
    StdSr_2.5m = mean(c(StdSr_2.5m,StdSr_2.5m_SR2)),
    MaxSr_2.5m = mean(c(MaxSr_2.5m,MaxSr_2.5m_SR2)),
    MinSr_2.5m = mean(c(MinSr_2.5m,MinSr_2.5m_SR2)),
    AvgSr = mean(c(AvgSr,AvgSr_SR2))
  )

# remove redundant SR2 observations
data[,!grepl("SR2",colnames(data))] -> data

# reorder columns
data[,c("datetime",colnames(data)[-1] %>% sort())] -> data

metmast <- data
usethis::use_data(metmast,overwrite = TRUE)
