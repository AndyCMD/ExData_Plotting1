## This will be an analysis of the electric power consumption
## dataset for the data science class I'm taking
## Plot 1 will comprise a histogram with 12 breaks
## of Global Active Power in kw vs Frequency

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

# Then we can create the plot using png command, followed
# by the hist() function
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(electric$Global_active_power, xlim=c(0,6), col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
