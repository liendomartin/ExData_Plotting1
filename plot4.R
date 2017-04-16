library(dplyr)
data  <- read.csv("household_power_consumption.txt", sep = ";",
                  header = TRUE , na.strings = "?")
#Merge Date and Time in one column and correct format
data$newdate <- with(data , strptime(paste(Date, Time), 
                                     format="%d/%m/%Y %H:%M:%S")) 
# subset the dataset, remove the old variables and arrange starting with Date
data1 <- subset(data, newdate >= as.POSIXct('2007-02-01') 
                & newdate <= as.POSIXct('2007-02-02 23:59:00'), 
                select = -c(Date, Time))
data1 <- data1 %>% select(newdate, everything())

#plot4 using Base plotting System and png function
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data1, {
      plot(newdate, Global_active_power,
           ylab = "Global Active Power",
           xlab = "", 
           type = "l")
      plot(newdate, Voltage,
           ylab = "Voltage",
           xlab = "datetime",
           type = "l")
      plot(newdate, Sub_metering_1,
                col = "black",
                type = "l",
                xlab = "",
                ylab = "Energy sub metering")
           lines(newdate, Sub_metering_2, col = "red")
           lines(newdate, Sub_metering_3, col = "blue")
      legend("topright", col = c("black", "red", "blue"),
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             lty = , lwd = 2.5,, bty="n", xjust=1,yjust = 1,
      )
      plot(newdate, Global_reactive_power,
           xlab = "datetime",
           type = "l")
      
      
})
dev.off()
#lty = c(1,1), lwd = c(1,1),cex=0.75, bty="n", xjust=1,yjust = 1,
#seg.len=0.5
