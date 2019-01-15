#Setting your working directory
setwd("C:/Users/Reanne Len/Desktop/Exploratory Data Analysis - Week 1")

#Checking the files currently in your working directory
list.files()

#unziping the data downloaded from the link given
#make sure that the zip file is already in your working directory
unzip("exdata_data_household_power_consumption.zip")
list.files()

#Reading the data
hhpowercons <- read.table("household_power_consumption.txt", sep =";", header = TRUE, dec = ".", colClasses = "character" )
View(hhpowercons)

#To know the class of the variables in the dataset
library(dplyr)
sapply(hhpowercons, class)

#converting the Date variable to Date class
#I generated a new variable containing both the date and time
hhpowercons$DT <- paste(hhpowercons$Date, hhpowercons$Time)
hhpowercons$DT <- strptime(hhpowercons$DT,"%d/%m/%Y %H:%M:%S")
hhpowercons$Date <- as.Date(hhpowercons$Date, format = "%d/%m/%Y")

#converting the rest of the variables to numeric class
hhpowercons$Global_active_power <- as.numeric(hhpowercons$Global_active_power)
hhpowercons$Global_reactive_power <- as.numeric(hhpowercons$Global_reactive_power)
hhpowercons$Voltage <- as.numeric(hhpowercons$Voltage)
hhpowercons$Global_intensity <- as.numeric(hhpowercons$Global_intensity)
hhpowercons$Sub_metering_1 <- as.numeric(hhpowercons$Sub_metering_1)
hhpowercons$Sub_metering_2 <- as.numeric(hhpowercons$Sub_metering_2)
hhpowercons$Sub_metering_3 <- as.numeric(hhpowercons$Sub_metering_3)

#checking the class of the variables after converting
sapply(hhpowercons, class)

#Making a subset of the original dataset which only contains the data for the two dates "2007-02-01" and "2007-02-02"
hhpowercons2 <- hhpowercons[hhpowercons$Date >= "2007-02-01" & hhpowercons$Date <= "2007-02-02",]
View(hhpowercons2)

#Creating the plot desired and saving it to PNG file with resolution 480 by 480
png(file = "plot3.png", width = 480, height = 480)
plot(hhpowercons2$DT, hhpowercons2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(hhpowercons2$DT, hhpowercons2$Sub_metering_2, type = "l", col ="red")
lines(hhpowercons2$DT, hhpowercons2$Sub_metering_3, type = "l", col ="blue")
legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

