# compile lidar dataset

path_to_data <- "data-raw/lidar/"
filename <- list.files(path_to_data) %>% paste0(path_to_data,.)

data <- read.delim(filename,skip = 41) %>% as_tibble()

heights <- read.delim(filename,skip = 39,nrows = 1,header = FALSE)[-1] %>% as.numeric()

create_var_names <- function(heights) {

  general_vars <- c(
    "datetime",
    "TeInt",
    "TeExt",
    "Bp",
    "Rh",
    "wiperCount"
  )

  height_vars_prefix <- c("Ws","DispWs","MinWs","MaxWs","Wd","zWs","zDispWs","CNRdB","MinCNRdB","DoppSpecBroad","DataAvail")

  height_vars <- heights %>% map(function(x) paste0(height_vars,"_",x,"m")) %>% unlist()

  return(c(general_vars,height_vars))

}

ind_999 <- which(data %>% map(function(x) 100*sum(x==999)/length(x)) > 0)
data[,ind_999][data[,ind_999] == 999] <- NA

present_ind <- data %>% map(function(x) 100*sum(is.na(x))/length(x)) < 50
data[,present_ind] -> data
colnames(data) <- create_var_names(heights)

# some large missing data chunks that may need to be dealt with separately
data %<>% map_df(function(x) imputeTS::na_interpolation(x))

lidar <- data

usethis::use_data(lidar)
