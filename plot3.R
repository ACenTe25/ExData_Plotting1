#R Script for generating plot3.png
#This script assumes that the data file is already
#in the working directory and uncompressed.

#First, read the data into R and fix the Date variable
powerConsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")

#Now subset the data for February 1st and 2nd, 2007 and create DateTime variable
powerSubset <- powerConsumption[powerConsumption$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
powerSubset$DateTime <- strptime(paste(powerSubset$Date, powerSubset$Time), format = "%Y-%m-%d %H:%M:%S")

#Create plot3.png
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")

#First, add the first plot
plot(powerSubset$DateTime, powerSubset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Then, add the other lines to the plot
lines(powerSubset$DateTime, powerSubset$Sub_metering_2, type = "l", col = "red")
lines(powerSubset$DateTime, powerSubset$Sub_metering_3, type = "l", col = "slateblue")

#Finally, add the legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","slateblue"))
dev.off()

#Script written by Alejandro Cendejas Tena (C) Copyright 2015