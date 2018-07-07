## Exploratory Data Analysis
## 
## Course Project 1 - Plot 4


## Create folder if folder does not exist
if(!file.exists("data")) {
  dir.create("data")
}

## Get file and unzip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/consumption.zip")
unzip("./data/consumption.zip", exdir = "C:/Users/Os/Desktop/Coursera/Course 4/data")

## Create subset of data set
setwd("C:/Users/Os/Desktop/Coursera/Course 4/data")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string="?", stringsAsFactors = FALSE)
subdata <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

## Format Date and Time
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")

## Combine Date and Time
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

## Create plots and save plots as png
par(mfrow = c(2,2))
with(subdata, {
  plot(Global_active_power~Datetime, type = "l", ylab = "Global Active Power", xlab = "")
  plot(Voltage~Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2~Datetime,col="red")
  lines(Sub_metering_3~Datetime,col="blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()