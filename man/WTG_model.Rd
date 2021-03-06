% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WTG_model.R
\name{WTG_model}
\alias{WTG_model}
\title{Wind Turbine Model}
\usage{
WTG_model(
  speed,
  cut_in,
  cut_out,
  speed_rated,
  power_rated,
  height_ref,
  height_hub,
  losses = 0,
  method = "log"
)
}
\arguments{
\item{speed}{wind speed (m/s).}

\item{cut_in}{cut-in speed of turbine (m/s).}

\item{cut_out}{cut-out speed of turbine (m/s).}

\item{speed_rated}{rated speed of turbine (m/s).}

\item{power_rated}{rated power of turbine.}

\item{height_ref}{reference height of wind speed (m).}

\item{height_hub}{hub height of turbine (m).}

\item{losses}{percentage of power lossed due to efficiency (default = 0).}

\item{method}{the calculation method (one of "log" or "power")}
}
\value{
The power output of the specified wind turbine.
}
\description{
Mathematical model of a wind turbine.
}
\details{
logarithmic calculation is from Liu, X., 2012. An improved interpolation method for wind power curves. IEEE Transactions on Sustainable Energy, 3(3), pp.528-534.
}
\examples{
WTG_model(10,4,25,15,4.2)
}
