plot1 <- function() {

  # set system environment to English for display consistency
  Sys.setenv("LANGUAGE"="En")
  Sys.setlocale("LC_ALL", "English")
  
  # import required libraries
  library(dplyr)
  library(sqldf)
  library(lubridate)

  # read input file and format datetime
  power <- read.csv.sql("household_power_consumption.txt", sep=";", sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
  # cleanup
  closeAllConnections()
  
  pow <- tbl_df(power)
  pow <- pow %>% mutate(datetime = dmy_hms(paste(Date,Time)))
  
  # open output device png file
  pngFile <- png(filename="plot1.png", width=480, height=480, units="px")

  # plot graph
  hist(pow$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main = "Global Active Power", col="red")

  # close output device
  dev.off()

}



