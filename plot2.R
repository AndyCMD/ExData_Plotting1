## This will be an analysis of the electric power consumption
## dataset for the data science class I'm taking
## Plot 2 will be a line plot of global active power from 2/1-2/2/2007

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

# Then, we create the plot using png() and plot()
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(electric$posix, electric$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
