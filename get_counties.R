library(USAboundaries)

allstates <- sort(us_states()$state_name)

allcounties <- sapply(allstates, function(x) sort(us_counties(resolution = "low", states = x)$name))

allcounties[["New Mexico"]][8] <- "Dona Ana" # remove special character to match database

allcounties <- allcounties[names(allcounties) != "Puerto Rico"]

dump("allcounties", file = "allcounties.R")
