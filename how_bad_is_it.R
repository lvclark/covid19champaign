library(COVID19)
library(dplyr)

how_bad_is_it <- function(startdate, state = "Illinois", county = "Champaign",
                          plotvar = "confirmed"){
  stdt <- as.Date(startdate) - 1
  covdat <- COVID19::covid19("USA", level = 3, start = stdt) %>%
    filter(administrative_area_level_2 == state, administrative_area_level_3 == county)
  ndates <- nrow(covdat)
  
  par(mfrow = c(length(plotvar), 1))
  for(var in plotvar){
    noncum <- covdat[[var]][2:ndates] - covdat[[var]][1:(ndates - 1)]
    plot(covdat$date[-1], noncum, type = "l", xlab = "Date",
         ylab = "", main = var)
  }
  
  return(covdat)
}

how_bad_is_it(as.Date("2020-05-01"))
