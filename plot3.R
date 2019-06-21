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
png(filename="plot3.png", width=480, height=480, units="px")
plot(hpcdata$DateTime,hpcdata$Sub_metering_1,type = "l", col = "black",xlab="", ylab = "Global Active Power (kilowatts)")
lines(hpcdata$DateTime, hpcdata$Sub_metering_2,type = "l", col = "red")
lines(hpcdata$DateTime, hpcdata$Sub_metering_3,type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))
# closing plotting device
dev.off()