#' Costing - Oz estimates
#'
#' This dataset contains costs associated with the power generation equipment.
#'
#' @usage data(Wg)
#'
#' @format A dataframe with 5 observations and 9 variables:
#' \describe{
#' \item{group}{one of solar, wind, diesel, BESS, or other}
#' \item{particular}{additional information if required}
#' \item{fixed_capacity}{fixed costs of installation}
#' \item{associated_capacity}{Costs associated with the number of MW of installed capacity}
#' \item{fixed_usage}{fixed costs for O&M per annum}
#' \item{associated_usage}{costs associated with the number of MWh per annum}
#' \item{associated_fuel}{$/MWh cost associated with fuel: associated_fuel = fuel price ($/L) * fuel efficiency (L/MWh).}
#' \item{susex}{per annum cost of sustaining generation assets}
#' }
#'
#' @source Estimates developed for Rolling LCOE
#'
"costoz"
