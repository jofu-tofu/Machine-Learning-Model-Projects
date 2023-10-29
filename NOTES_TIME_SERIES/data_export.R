library(fpp3)
library(dplyr)
library(purrr)
library(fma)
library(tsibble)
ts2csv <- function(objname, pname) {
    dir.create(paste0('./data/', pname), showWarnings = FALSE)
    fname <- paste0('./data/', pname, '/', objname, '.csv')
    x = get(objname)
    tryCatch({
        readr::write_csv(x, fname)
        print(fname)
    }, warning = function(w) {
    }, error = function(e) {
        print(paste0(fname, " <-- error"))
    }, finally = {
    })
}
x = as.data.frame(data(package="fpp3")[3])
for (objname in x$results.Item) {
  print(objname)
  ts2csv(objname, pname)
}
y = get('us_gasoline')
readr::write_csv(y , "./")
for (pname in list("fpp3", "tsibbledata", "tsibble", "fma")) {
  x <- as.data.frame(data(package=pname)[3])
  for (objname in x$results.Item) {
    ts2csv(objname, pname)
  }
}
readr::write_csv(as_tibble(fma::sheep), './data/fma/sheep.csv')
readr::write_csv(as_tibble(fma::bicoal), './data/fma/bicoal.csv')
