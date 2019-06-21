# loading data table library
library(data.table)
# reading data into dataframe
my_data <- read.delim("household_power_consumption.txt",sep = ";", na.strings="?")
#subsetting data according to date
hpcdata <- subset(my_data, Date == '1/2/2007' | Date == '2/2/2007')
# creating png file/plotting device
png(filename="plot2.png", width=480, height=480, units="px")
# Merge date & time into single column
dateTime <- as.POSIXct(paste(hpcdata$Date, hpcdata$Time, sep = ";"), format = "%d/%m/%Y;%H:%M:%S")
hpcdata <- cbind("DateTime" = dateTime, hpcdata)
hpcdata$Date <- NULL
hpcdata$Time <- NULL
remove(dateTime)
plot(hpcdata$Date, hpcdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
# closing plotting device
dev.off()