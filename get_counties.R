library(USAboundaries)

allstates <- sort(us_states()$state_name)

allcounties <- sapply(allstates, function(x) sort(us_counties(resolution = "low", states = x)$name))

dump("allcounties", file = "allcounties.R")
