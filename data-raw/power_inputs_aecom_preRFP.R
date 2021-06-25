# code to prepare inputs for power modelling to align with aecom

aecom <- readr::read_csv("data-raw/aecom-wind-solar.csv")

aecom$base[aecom$base == 20] <- 20.1
aecom$float[aecom$float == 1500] <- 1402

power_inputs_aecom_preRFP <- aecom # rename

usethis::use_data(power_inputs_aecom_preRFP,overwrite = T)
