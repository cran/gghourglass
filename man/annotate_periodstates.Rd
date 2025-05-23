% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annotate_periods.R
\name{annotate_periodstates}
\alias{annotate_periodstates}
\title{Annotate a period in an hourglass plot}
\usage{
annotate_periodstates(mapping, data, hour_center = 0, ...)
}
\arguments{
\item{mapping}{A \code{ggplot2::aes()} object that maps the periods. It needs
\code{x}, \code{y}, \code{xend} and \code{yend}, which mark the conrners of the rectangles (i.e. periods)}

\item{data}{A \code{data.frame} containing information about the periods.}

\item{hour_center}{The hour at which the time of day is centred. Default is 0,
meaning midnight. -12 centres around noon of the preceding day, +12 centres
around noon of the next day.}

\item{...}{Passed to layer parameters.}
}
\description{
Adds rectangles to a \code{geom_hourglass()} plot layer. It can be used to
mark specific periods. The example shows how this annotation can be
used to mark the periods when detector (used for the observations) was active.
Note that this may not work correctly when displaying data that uses
datetime objects with daylight saving time. In those cases you could
split the periods into parts with and without daylight saving. Or convert
your data to a timezone without daylight saving time (e.g. UTC).
}
\examples{
library(ggplot2)
library(dplyr)
library(lubridate)

## Extract monitoring periods from 'bats' data
monitoring_periods <-
  attr(bats, "monitoring") |>
  mutate(time_on  = as_datetime(time_on),
         time_off = as_datetime(time_off))

ggplot(bats, aes(x = RECDATETIME, col = SPECDESCSCI)) +

  ## Set background to transparent red to contrast with
  ## monitoring periods
  theme(panel.background = element_rect(fill = "#FF000044")) +
  
  ## Annotate periods in which the detector was active with
  ## white rectangles
  annotate_periodstates(
    aes(x    = start,   xend = end,
        y    = time_on, yend = time_off),
    monitoring_periods,
    fill = "white") +
    
 ## plot observations
  geom_hourglass(hour_center = -6)
}
\author{
Pepijn de Vries
}
