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

# Step 3: Transform "Date" & "Time" into a date/time format
datetime <- strptime(paste(epc[,1],epc[,2], sep = " "),"%d/%m/%Y %H:%M:%S")
epc <- cbind(epc,datetime)

# Step 4: Open a PNG file
par(mfrow = c(2,2), mar = c(5,5,5,2), oma = c(3,3,3,2))
plot(epc$Global_active_power~epc$datetime,type="l", ylab="Global Active Power", xlab="")
plot(epc$Voltage~epc$datetime, type="l", ylab = "Voltage", xlab = "datetime")
with(epc, {
        plot(Sub_metering_1~datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
plot(epc$Global_reactive_power~epc$datetime, type="l", ylab = "Global_reactive_power", xlab = "datetime")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off() ## Close the PNG file