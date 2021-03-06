library(data.table)
library(dplyr)

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
png(filename = "plot1.png", width = 480, height = 480, units = "px", , bg = "transparent") 

# draw histogram chart
hist(dt$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Aactive Power (kilowatts)")

## close the PNG device!
dev.off() 
