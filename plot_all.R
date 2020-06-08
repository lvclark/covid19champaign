# Generate a PNG figure for every county in the US

source("how_bad_is_it.R")
source("allcounties.R")

for(state in names(allcounties)){
  for(county in allcounties[[state]]){
    png(paste0("figures/", state, "_", county, ".png"),
        width = 1000, height = 500, res = 150)
    print(how_bad_is_it("2020-03-15", state, county)[[2]])
    dev.off()
  }
}
