library(data.table, dplyr, stringr)

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

## conversion of data format
dt$plotdate <- strptime(paste(dt$Date, dt$Time) , "%d/%m/%Y %H:%M:%S")

## Copy my plot to a PNG file
png(filename = "plot4.png", width = 504, height = 504, units = "px", , bg = "transparent") 

## Multiple Base Plots
par(mfcol = c(2, 2), mar = c(4, 4, 3, 1), oma = c(1, 1, 1, 1))

# plot1
with(dt, plot(plotdate, Global_active_power, type = "l", xlab ="", ylab = "Global Aactive Power"))

# plot2
with(dt, plot(plotdate, Sub_metering_1, xlab ="", ylab = "Energy sub metering", type="l"))
lines(dt$plotdate,dt$Sub_metering_2, type = "l", col = "red")
lines(dt$plotdate,dt$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n")

# plot3
with(dt, plot(plotdate, Voltage, type = "l", xlab ="datetime", ylab = "Voltage"))

# plot4
with(dt, plot(plotdate, Global_reactive_power, type = "h", xlab ="datetime", ylab = "Global_reactive_power"))

## close the PNG device!
dev.off() 