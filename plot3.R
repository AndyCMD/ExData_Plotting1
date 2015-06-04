## This will be an analysis of the electric power consumption
## dataset for the data science class I'm taking
## Plot 3 will be a line plots of energy submonitoring variables
## 1, 2, and 3, from 2/1-2/2/2007

# First, we need to read in the data using read.table
electrc <- read.table("household_power_consumption.txt", sep=";", header=T)

# Then, we need to convert the dates and times from 
# characters to date and time format
electrc$Date <- as.character(electrc$Date)
electrc$Date <- as.Date(electrc$Date, format = "%d/%m/%Y")
electrc$Time <- as.character(electrc$Time)
electrc$Time <- strptime(electrc$Time, format = "%H:%M:%S")
electrc$Time <- format(electrc$Time, "%H:%M:%S")

# Next, we need to select for data from 2/1/2007 - 2/2/2007
electrc1 <- electrc[electrc$Date >= as.Date("2007-02-01"),]
electric <- electrc1[electrc1$Date <= as.Date("2007-02-02"),]

# Next, because this is a time series, we should use POSIX
# class for the dates, to enable easier plotting. First,
# we paste the date and time, and adjust the format, 
# then change to POSIX using as.POSIXct
electric$DateTime <- paste(electric$Date, electric$Time)
electric$DateTime <- strptime(electric$DateTime, "%Y-%m-%d %H:%M:%S")
electric$posix <- as.POSIXct(electric$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Finally, make sure the Sub metering variables are numeric
electric$Sub_metering_1 <- as.numeric(as.character(electric$Sub_metering_1))
electric$Sub_metering_2 <- as.numeric(as.character(electric$Sub_metering_2))
electric$Sub_metering_3 <- as.numeric(as.character(electric$Sub_metering_3))

# Then, we create the plot using png() and plot(), adding the
# other lines using lines() function
png(file = "plot3.png", width = 480, height = 480, units = "px")
with(electric, plot(posix, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(electric, lines(posix, Sub_metering_2, col="red"))
with(electric, lines(posix, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"))
dev.off()
