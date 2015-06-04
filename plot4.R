## This will be an analysis of the electric power consumption
## dataset for the data science class I'm taking
## Plot 4 will be several different plots, using the par()
## command.

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

# We also need to change the variable Global active power
# from a factor to numeric class
electric$Global_active_power <- as.numeric(as.character(electric$Global_active_power))

# Next, because this is a time series, we should use POSIX
# class for the dates, to enable easier plotting. First,
# we paste the date and time, and adjust the format, 
# then change to POSIX using as.POSIXct
electric$DateTime <- paste(electric$Date, electric$Time)
electric$DateTime <- strptime(electric$DateTime, "%Y-%m-%d %H:%M:%S")
electric$posix <- as.POSIXct(electric$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Then, we create the plot using png() and plot(), preceded by the
# par command
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))

# Plot in upper left
plot(electric$posix, electric$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot in lower left
with(electric, plot(posix, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(electric, lines(posix, Sub_metering_2, col="red"))
with(electric, lines(posix, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"), bty="n")

# Plot in upper right
plot(electric$posix, as.numeric(as.character(electric$Voltage)), type = "l", xlab = "datetime", ylab = "Voltage")

# Plot in lower right
plot(electric$posix, as.numeric(as.character(electric$Global_reactive_power)), type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()
