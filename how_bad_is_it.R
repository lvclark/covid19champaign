library(COVID19)
library(dplyr)
library(ggplot2)

how_bad_is_it <- function(startdate, state = "Illinois", county = "Champaign",
                          plotvar = "confirmed"){
  stdt <- as.Date(startdate) - 1
  covdat <- COVID19::covid19("USA", level = 3, start = stdt) %>%
    filter(administrative_area_level_2 == state, administrative_area_level_3 == county)
  ndates <- nrow(covdat)
  
  noncum <- covdat[[plotvar]][2:ndates] - covdat[[plotvar]][1:(ndates - 1)]
  p <- ggplot(mapping = aes(x = covdat$date[-1], y = noncum)) +
    geom_line() + geom_smooth() +
    labs(x = "Date", y = "Daily (noncumulative) count") +
    ggtitle(paste0(plotvar, ", ", county, " county, ", state))
  
  return(list(covdat, p))
}

how_bad_is_it(as.Date("2020-04-01"))
