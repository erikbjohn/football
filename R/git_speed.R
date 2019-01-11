git_speed <- function(){
  speed_location <- '~/Dropbox/pkg.data/football/clean/speed.rds'
  if(!file.exists(speed_location)){
    l <- list()
    l$dt <- data.table::fread('~/Dropbox/pkg.data/football/raw/speed/football_speeds_2018.csv')
    l$dt_2 <- data.table::fread('~/Dropbox/pkg.data/football/raw/speed/football_speeds_2018_2.csv')
    l$dt_2$V6 <- NULL; l$dt_2$V7 <- NULL
    setnames(l$dt_2, names(l$dt_2), names(l$dt))
    dt <- rbindlist(l, use.names = TRUE, fill=TRUE)
    rm(l)
    dt <- dt[, dt_tstamp:=lubridate::as_datetime(tstamp)]
    dt <- dt[, s_day := lubridate::yday(dt_tstamp)  ]
    dt <- dt[, s_year := lubridate::year(dt_tstamp)]
    saveRDS(dt, speed_location)
  } else {
    dt <- readRDS(speed_location)
  }
  return(dt)
}