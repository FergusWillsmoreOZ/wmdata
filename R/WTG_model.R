#' Wind Turbine Model
#'
#' Mathematical model of a wind turbine.
#'
#' @param speed wind speed (m/s).
#' @param cut_in cut-in speed of turbine (m/s).
#' @param cut_out cut-out speed of turbine (m/s).
#' @param speed_rated rated speed of turbine (m/s).
#' @param power_rated rated power of turbine.
#' @param height_ref reference height of wind speed (m).
#' @param height_hub hub height of turbine (m).
#' @param losses percentage of power lossed due to efficiency (default = 0).
#' @param method the calculation method (one of "log" or "power")
#'
#' @details
#' logarithmic calculation is from Liu, X., 2012. An improved interpolation method for wind power curves. IEEE Transactions on Sustainable Energy, 3(3), pp.528-534.
#'
#' @return The power output of the specified wind turbine.
#' @export
#'
#' @examples
#' WTG_model(10,4,25,15,4.2)
WTG_model <- function(speed,
                      cut_in,
                      cut_out,
                      speed_rated,
                      power_rated,
                      height_ref,
                      height_hub,
                      losses = 0,
                      method = "log"){

  stopifnot(!missing(speed),
            !missing(cut_in),
            !missing(cut_out),
            !missing(speed_rated),
            !missing(power_rated))

  # if missing one of the heights
  if (missing(height_ref) | missing(height_hub)){
    # then assume the heights are equal
    height_ref = 1
    height_hub = 1
  }

  # convert speed at reference height to speed at hub height
  speed <- speed * (height_hub/height_ref)^(1/7)

  # update rated power on losses
  power_rated <- power_rated - losses*power_rated

  if (method == "power"){
    Pw <- ifelse(
      speed >= cut_in & speed <= speed_rated, # within cut_in and cutout
      power_rated*(speed^3 - cut_in^3)/(speed_rated^3 - cut_in^3),
      ifelse(
        speed > speed_rated & speed <= cut_out, # beyond rated but before cutout
        power_rated,
        0 # otherwise
      )
    )
  }

  if (method == "log"){

    # point on curve
    w1 <- 0.55 * power_rated
    v1 <- cut_in +(speed_rated-cut_in)/2
    # parameters for logarithmic wind curve
    wm <- 1.02 * power_rated
    b = log(log(1-w1/wm)/log(1-power_rated/wm)) / log((v1-cut_in)/(speed_rated-cut_in))
    a = -log(1-power_rated/wm)/(speed_rated-cut_in)^b

    Pw <- ifelse(
      speed >= cut_in & speed <= speed_rated, # within cut_in and cutout
      wm - wm * exp(-a*(speed-cut_in)^b),
      ifelse(
        speed > speed_rated & speed <= cut_out, # beyond rated but before cutout
        power_rated,
        0 # otherwise
      )
    )
  }

  return(Pw)
}
