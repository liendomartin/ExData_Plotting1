data  <- read.csv("household_power_consumption.txt", sep = ";",
                  header = TRUE , na.strings = "?")
#Merge Date and Time in one column and correct format
data$newdate <- with(data , strptime(paste(Date, Time), 
                                       format="%d/%m/%Y %H:%M:%S")) 
# subset the dataset, remove the old variables and arrange starting with Date
data1 <- subset(data, newdate >= as.POSIXct('2007-02-01') 
                & newdate <= as.POSIXct('2007-02-02 23:59:00'), 
                select = -c(Date, Time))
data1 <- data1 %>% select(c(newdate), everything())

#Plot2 using Base Plotting System and dev.copy
data1$Global_active_power <- as.numeric(data1$Global_active_power)
with(data1, plot(newdate, Global_active_power,
                 type = "l",
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "Plot2.png", width = 480, height = 480)
dev.off()
