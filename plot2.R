plot2 <- function() {
  
  # set system environment to English for display consistency
  Sys.setenv("LANGUAGE"="En")
  Sys.setlocale("LC_ALL", "English")
  
  # import required libraries
  library(dplyr)
  library(sqldf)
  library(lubridate)
  
  # read input file and format datetime
  power <- read.csv.sql("household_power_consumption.txt", sep=";", sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
  pow <- tbl_df(power)
  pow <- pow %>% mutate(datetime = dmy_hms(paste(Date,Time)))
  
  # open output device png file
  pngFile <- png(filename="plot2.png", width=480, height=480, units="px")
  
  # plot graph
  with(pow, plot(datetime, Global_active_power, type="S", xlab="", ylab="Global Active Power (kilowatts)"))
  
  # close output device
  dev.off()
  
  # cleanup
  closeAllConnections()
}



