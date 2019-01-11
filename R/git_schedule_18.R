git_schedule_18 <- function(){
  schedule_18_location <- '~/Dropbox/pkg.data/football/clean/schedule_18.rds'
  if(!file.exists(schedule_18_location)){
    dt <- fread('~/Dropbox/pkg.data/football/raw/schedules/schedule_18.csv', skip=0)
    dt$V5 <- NULL  
    setnames(dt, names(dt), as.character(dt[1]))
    dt <- dt[2:nrow(dt)]
    dt <- dt[, month_day_year := paste0(month_day, '/2018')]
    dt <- dt[16, month_day_year := stringr::str_replace(month_day_year, '\\/2018', '/2019')]
    dt <- dt[, time_central:=stringr::str_replace_all(time_central, '\\.', '')]  
    dt <- dt[, time_central:=stringr::str_replace_all(time_central, '[A-Z]{1,}$|ESPN2', '')]
    dt <- dt[!stringr::str_detect(time_central, 'am|pm'), time_central:=paste0(time_central, 'pm')]
    dt <- dt[!opponent == 'IDLE']
    dt <- dt[, time_central:=stringr::str_trim(time_central)]
    dt <- dt[, str_date_time := paste(month_day_year, time_central)]
    dt <- dt[, dt_datetime := lubridate::mdy_hm(str_date_time)]
    dt$str_date_time <- NULL
    dt <- dt[, home_game := 0]
    dt <- dt[stringr::str_detect(location, 'Tuscaloosa'), home_game:=1]
    dt$location <- NULL
    dt$opponent <- NULL  
    dt$month_day <- NULL
    dt$time_central <- NULL  
    dt <- dt[, s_day := yday(dt_datetime)  ]
    dt <- dt[, s_year := lubridate::year(dt_datetime)]
    saveRDS(dt, schedule_18_location)
  } else {
    dt <- readRDS(schedule_18_location)
  }
  return(dt)
}
