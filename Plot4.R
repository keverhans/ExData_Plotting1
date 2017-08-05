setwd(dir = 'C:/Users/_dejonh/Documents/Forcea/training/Exploratory data analysis/Week 1/assignment')
rm(list=ls())
library(dplyr)
library(lubridate)
## Loading the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "data.zip")
data1 <- read.table(unz("data.zip", "household_power_consumption.txt")
                    ,nrows =1, header=T, sep=";",na.strings = "?")
format(object.size(data1),"auto") # 2.6Kb for 1 row so
(2075259) * 2.6 /1024 # 5 334 064 MB for full dataset
# 5 334 064 MB < 8Gb so ok
rm(data1)
data <- read.table(unz("data.zip", "household_power_consumption.txt")
                   ,header=T, sep=";",na.strings = "?")

format(object.size(data),"auto")

subset <- data %>% filter(Date %in% c('1/2/2007','2/2/2007')) %>% 
    mutate(Date_dt=dmy(Date),Time_tm=hms(Time)
           , DateTime_dtm=dmy_hms(paste(Date,Time))
    )
rm(data)

## Plot 4
# Graphic device
png(file="Plot4.png",width = 480,height = 480)

# drawing
par(mfrow = c(2,2))

# topleft=Plot 2
with(subset,
     plot(DateTime_dtm, Global_active_power
          , type = "l"
          , ylab = "Global Active Power"
          , xlab = ""
          , main = ""
     )
)
# topright 
with(subset,
     plot(DateTime_dtm, Voltage
          , type = "l"
          , xlab = "datetime"
          , main = ""
     )
)
# bottomleft  = plot 3
with(subset, {
    plot(DateTime_dtm, Sub_metering_1
         , type = "n"
         , ylab = "Energy sub metering"
         , xlab = ""
         , main = ""
    )
    points(DateTime_dtm, Sub_metering_1,type="l",col="black")
    points(DateTime_dtm, Sub_metering_2,type="l",col="red")
    points(DateTime_dtm, Sub_metering_3,type="l",col="blue")
    legend("topright",pch="l",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}
)
# bottomright
with(subset, {
    plot(DateTime_dtm, Global_active_power
         , type = "l"
         , ylab = "Global_active_power"
         , xlab = "datetime"
         , main = ""
    )
}
)

# close connection
dev.off()
