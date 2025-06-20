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
library(dplyr)
library(lubridate)

## ----plot-utc, fig.width=7, fig.height=3, eval=TRUE---------------------------
## get example data
data(bats)

## subset example date to the year 2018
bats_sub <- subset(bats, format(RECDATETIME, "%Y") == "2019")

## retrieve monitoring location
lon <- attr(bats, "monitoring")$longitude[1]
lat <- attr(bats, "monitoring")$latitude[1]

## plot the data
p <-
  ggplot(bats_sub, aes(x = RECDATETIME)) +
  
    ## annotate sunset until sunrise
    annotate_daylight(lon, lat, c("sunset", "sunrise")) +
  
    ## annotate dusk until dawn
    annotate_daylight(lon, lat, c("dusk", "dawn")) +
  
    ## add hourglass geometry to plot
    geom_hourglass() +
  
    ## add informative labels
    labs(x = "Date", y = "Time of day")
p

## ----plot-cet, fig.width=7, fig.height=3, eval=TRUE, warning=FALSE------------
p %+%
  mutate(bats_sub, RECDATETIME = with_tz(RECDATETIME, "CET"))

