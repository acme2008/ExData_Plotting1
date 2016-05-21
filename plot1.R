
# We have determined that we only want to read 2880 rows from row 66637.
# Why? The sampling period is 1 minute and the samples start at 17:24 on 16/12/2006. There is one row per sample. Simple maths.

# Step 1: Prepare the environment & set the working directory
rm(list = ls())
setwd("~/DatascienceCoursera/EDA")
if (!require("data.table")) { 
        install.packages("data.table") 
}
require("data.table")

# Step 2: Read the data
epc <- read.table(file = "household_power_consumption.txt", header = FALSE, sep = ";",
                  col.names = c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                  na.strings = "?", nrows = 2880, skip = 66637)
head(epc)

# Step 3: Transform "Date" into a date format
epc[,1] <- as.Date(epc[,1],"%d/%m/%Y")

# Step 4: Open a PNG file
png(file = 'plot1.png',  width = 480, height = 480, units = "px",
    bg = "white")
hist(epc[,3], col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off() ## Close the PNG file