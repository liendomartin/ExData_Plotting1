library("dplyr")
data  <- read.csv("household_power_consumption.txt", sep = ";",
                    header = TRUE , na.strings = "?",
                  )
#Merge Date and Time in one column and correct format
data$newdate <- with(data , strptime(paste(Date, Time), 
                                       format="%d/%m/%Y %H:%M:%S")) 
# subset the dataset, remove the old variables and arrange starting with Date
data1 <- subset(data, newdate >= as.POSIXct('2007-02-01') 
                & newdate <= as.POSIXct('2007-02-02 23:59:00'), 
                select = -c(Date, Time))
data1 <- data1 %>% select(newdate, everything())

#plot1 using Base plotting System and dev.copy
with(data1, hist(Global_active_power, 
                 col = "red",
                 ylim = c(0, 1200),
                 xlab = "Global Active Power (kilowatts)",
                 main = "Global Active Power",
                 ))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
