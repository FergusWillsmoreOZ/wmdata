#' PV model
#'
#' Calculates the power output of a PV module from solar radiation and air temperature. You can also change the STCs in order to alter the capacity factors.
#'
#' @param Pmax rated capacity.
#' @param Sr solar radiation.
#' @param Te air temperature in degrees celsius.
#' @param eff conversion efficiency.
#'
#' @return the power output of a PV module.
#' @export
#'
#' @examples
#' PV_model(1,800,35,0.8)
PV_model <- function(Pmax,Sr,Te,eff,stc_rad = 1000,stc_temp = 25){
  stopifnot(length(Sr)==length(Te))
  stopifnot(eff <= 1, eff >= 0)
  stopifnot(Pmax >= 0)
  return(
    pmax(0,pmin(Pmax * eff,Pmax * eff * (Sr/stc_rad) * (1 - 0.005 * (Te - stc_temp))))
    )
}
