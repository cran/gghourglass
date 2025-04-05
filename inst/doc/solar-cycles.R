## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/timezones-",
  fig.ext = "png",
  dev = "png")
tryCatch({
  Sys.setlocale("LC_ALL", "English")
})
library(ggplot2)
theme_set(theme_light())

## ----setup, message=FALSE, warning=FALSE--------------------------------------
## load required namespaces for this vignette
library(ggplot2)
library(gghourglass)

## ----plot-night, fig.width=7, fig.height=3, eval=TRUE-------------------------
## get example data
data(bats)

## subset example date to the year 2018
bats_sub <- subset(bats, format(RECDATETIME, "%Y") == "2019")

## retrieve monitoring location
lon <- attr(bats, "monitoring")$longitude[1]
lat <- attr(bats, "monitoring")$latitude[1]

## plot the data
p <- ggplot(bats_sub, aes(x = RECDATETIME)) +

    ## add hourglass geometry to plot
    geom_hourglass() +
  
    ## add informative labels
    labs(x = "Date", y = "Time of day")

## decorate the plot with night time ribbon
p + annotate_daylight(lon, lat, c("sunset", "sunrise"), fill = "darkblue")

## ----plot-day, fig.width=7, fig.height=3, eval=TRUE---------------------------
p + annotate_daylight(lon, lat, c("sunrise", "sunset"), fill = "orange")

## ----solar-events, echo=FALSE, results='asis'---------------------------------
" * " |>
  paste0(
    formals(suncalc::getSunlightTimes)$keep |>
      eval()) |>
  paste0(collapse = "\n") |>
  cat()

