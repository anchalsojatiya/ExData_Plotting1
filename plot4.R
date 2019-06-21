# loading data table library
library(data.table)
# reading data into dataframe
my_data <- read.delim("household_power_consumption.txt",sep = ";", na.strings="?")
#subsetting data according to date
hpcdata <- subset(my_data, Date == '1/2/2007' | Date == '2/2/2007')

# Merge date & time into single column
dateTime <- as.POSIXct(paste(hpcdata$Date, hpcdata$Time, sep = ";"), format = "%d/%m/%Y;%H:%M:%S")
hpcdata <- cbind("DateTime" = dateTime, hpcdata)
hpcdata$Date <- NULL
hpcdata$Time <- NULL
remove(dateTime)

# creating png file/plotting device
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

par(mfrow = c(2, 2))

# Add plot 1 to top, left
plot(hpcdata$DateTime, hpcdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Add plot 2 to top, right
plot(hpcdata$DateTime, hpcdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Add plot 3 to bottom, left
plot(hpcdata$DateTime, hpcdata$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(hpcdata$DateTime, hpcdata$Sub_metering_2, type = "l", col = "red")
lines(hpcdata$DateTime, hpcdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = 'n', col = c("black", "red", "blue"))

# Add plot 4 to bottom, right
plot(hpcdata$DateTime, hpcdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", lwd = 0.5)

# closing plotting device
dev.off()