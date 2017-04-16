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

#Plot 3 using Base Plotting System and png function
png(filename = "plot3.png", width = 480, height = 480)
with(data1,{
      plot(newdate,Sub_metering_1,
           col = "black",
           type = "l",
           xlab = "",
           ylab = "Energy sub metering")
      lines(newdate, Sub_metering_2, col = "red")
      lines(newdate, Sub_metering_3, col = "blue")
      }) 
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = , lwd = 2.5,, bty="o", xjust=1,yjust = 1
       )
dev.off()
      
      