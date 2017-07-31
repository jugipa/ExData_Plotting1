library(data.table)
library(dplyr)
library (stringr)

Sys.setlocale("LC_ALL","English")
## data file download from web site
if (!file.exists("data")) { dir.create("data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", mode="wb")
Datedownloaded <- date()

## unzip file to text 
unzip("./data/household_power_consumption.zip", exdir = "./data")

data1 <- fread("./data/household_power_consumption.txt",header=TRUE, na.strings="?")

# filtering for 2 day 
dt <- filter(data1, data1$Date %in% c("1/2/2007","2/2/2007"))


## Copy my plot to a PNG file
png(filename = "plot3.png", width = 480, height = 480, units = "px", , bg = "transparent") 

## conversion of data format
dt$plotdate <- strptime(paste(dt$Date, dt$Time) , "%d/%m/%Y %H:%M:%S")

# draw line plot chart
with(dt, plot(plotdate, Sub_metering_1, xlab ="", ylab = "Energy sub metering", type="l"))
lines(dt$plotdate,dt$Sub_metering_2, type = "l", col = "red")
lines(dt$plotdate,dt$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## close the PNG device!
dev.off() 