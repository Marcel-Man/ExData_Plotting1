plot4 <- function() {
  
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
  pngFile <- png(filename="plot4.png", width=480, height=480, units="px")
  
  # plot graph
  par(mfrow=c(2,2))
  with(pow, plot(datetime, Global_active_power, type="S", xlab="", ylab="Global Active Power"))
  with(pow, plot(datetime, Voltage, type="S"))
  with(pow, plot(datetime, Sub_metering_1 , type="S", xlab="", ylab="Energy sub metering", col="black"))
  with(pow, lines(datetime, Sub_metering_2 , type="S", col="red"))
  with(pow, lines(datetime, Sub_metering_3 , type="S", col="blue"))
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=rep(1,3), bty="n")
  with(pow, plot(datetime, Global_reactive_power, type="S"))
  
  # close output device
  dev.off()
  
}



