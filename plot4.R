#R Script for generating plot4.png
#This script assumes that the data file is already
#in the working directory and uncompressed.

#First, read the data into R and fix the Date variable
powerConsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")

#Now subset the data for February 1st and 2nd, 2007 and create DateTime variable
powerSubset <- powerConsumption[powerConsumption$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
powerSubset$DateTime <- strptime(paste(powerSubset$Date, powerSubset$Time), format = "%Y-%m-%d %H:%M:%S")

#Create plot4.png, starting the png() device with 4 slots
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2,2))

#First, add the first plot, for Global Active Power
plot(powerSubset$DateTime, powerSubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Then, add the second plot; since we used mfrow, it's the Voltage plot
plot(powerSubset$DateTime, powerSubset$Voltage, type= "l", xlab = "DateTime", ylab = "Voltage")

#Now, add the third plot with its lines and legend
plot(powerSubset$DateTime, powerSubset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerSubset$DateTime, powerSubset$Sub_metering_2, type = "l", col = "red")
lines(powerSubset$DateTime, powerSubset$Sub_metering_3, type = "l", col = "slateblue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","slateblue"), bty = "n")

#Finally, add the last plot, for Global_reactive_power
plot(powerSubset$DateTime, powerSubset$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global_reactive_power")

#And finish by using dev.off()
dev.off()

#Script written by Alejandro Cendejas Tena (C) Copyright 2015