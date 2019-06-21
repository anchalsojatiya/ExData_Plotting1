# loading data table library
library(data.table)
# reading data into dataframe
my_data <- read.delim("household_power_consumption.txt",sep = ";", na.strings="?")
#subsetting data according to date
hpcdata <- subset(my_data, Date == '1/2/2007' | Date == '2/2/2007')
# creating png file/plotting device
png(filename="plot1.png", width=480, height=480, units="px")
#creating histogram
hist(hpcdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# closing plotting device
dev.off()