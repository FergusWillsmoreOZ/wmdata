#' Power Inputs from AECOM (pre-RFP)
#'
#' This dataset contains the time series inputs use by AECOM for the power model.
#'
#' @usage data(power_inputs_aecom_preRFP)
#'
#' @format A dataframe with 8760 observations and 4 variables:
#' \describe{
#' \item{wind}{power output of a single V136 4.2MW wind turbine at 125m}
#' \item{solar}{power output of a single 1MWe bifacial single axis tracking solar panel}
#' \item{base}{an approximation of NPI load at 20.1MW during normal operation and 3MW during maintenance}
#' \item{float}{floatation throughput at 1402tph (scaled due to maintenance) with a maintenance regime of 8 hours every 2 weeks}
#' }
#'
#' @source AECOM
#'
#'
"power_inputs_aecom_preRFP"
