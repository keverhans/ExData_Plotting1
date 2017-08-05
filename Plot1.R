
## IMPORTANT PLEASE READ
## My language settings are fixed on my work pc 
## so I could not get the date to show up in english
## do = Thu, vr = Fri, za = Sat
## Thanks to take it into account when checking

# rm(list=ls())
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



## Plot 1
# Graphic device
png(file="Plot1.png",width = 480,height = 480)
# drawing
with(subset,
     hist(Global_active_power, col="red",
          , main="Global Active Power"
          , xlab="Global Active Power (Kilowatts)")
)
# close connection
dev.off()

