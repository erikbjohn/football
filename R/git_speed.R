git_speed <- function(){
  speed_location <- '~/Dropbox/pkg.data/football/clean/speed.rds'
  if(!file.exists(speed_location)){
    l <- list()
    #l$dt <- data.table::fread('~/Dropbox/pkg.data/football/raw/speed/football_speeds_2018.csv')
    l$dt_2 <- data.table::fread('~/Dropbox/pkg.data/football/raw/speed/football_speeds_2018_2.csv')
    setnames(l$dt_2, 'V1', 'tmc')
    setnames(l$dt_2, 'V2', 'cross_street')
    setnames(l$dt_2, 'V3', 'road_name')
    setnames(l$dt_2, 'V4', 'road_number')
    setnames(l$dt_2, 'V5', 'road_direction')
    setnames(l$dt_2, 'V6', 'tmc_length_miles') 
    setnames(l$dt_2, 'V7', 'tmc_order')
    setnames(l$dt_2, 'V8', 'tstamp')
    setnames(l$dt_2, 'V9', 'free_flow_speed') 
    setnames(l$dt_2, 'V10', 'actual_speed')
    setnames(l$dt_2, 'V11', 'confidence')
    #setnames(l$dt_2, names(l$dt_2), names(l$dt))
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