#' Costing - Engie estimates for decarbonisation roadmap
#'
#' This dataset contains yearly forecasted estimates of capital costs and O&M costs for various energy types.
#'
#' @usage data(cost_engie)
#'
#' @format A dataframe with 240 observations and 6 variables:
#' \describe{
#' \item{group}{energy type, one of solar, wind, BESS_Li-ion and diesel.}
#' \item{variable}{variable name used for cost evaluations, one of associated_capacity (total capital costs $/kW) and associated_usage (fixed O&M $/kW/year). Check out raw data for units and source.}
#' \item{year}{year of mine operation}
#' \item{nominal}{nominal value}
#' \item{min}{aggresive estimate}
#' \item{max}{conservative estimate}
#' }
#'
#' @source Engie Assumption Book
#'
"cost_engie"
