#R Script for generating plot2.png
#This script assumes that the data file is already
#in the working directory and uncompressed.

#First, read the data into R and fix the Date variable
powerConsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")

#Now subset the data for February 1st and 2nd, 2007 and create DateTime variable
powerSubset <- powerConsumption[powerConsumption$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
powerSubset$DateTime <- strptime(paste(powerSubset$Date, powerSubset$Time), format = "%Y-%m-%d %H:%M:%S")

#Create plot2.png
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(powerSubset$DateTime, powerSubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

#Script written by Alejandro Cendejas Tena (C) Copyright 2015