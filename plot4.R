#setwd("D:/Coursera/Data Science/Exploratory Data Analysis/CourseProject/wk1")
library(sqldf)
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                   header = TRUE, sep = ";")
df[ df == "?" ] = NA        # Replace missing value "?" with NA
df <- na.omit(df)           # Remove records with NA

df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
df <- df[order(df$DateTime),]

par(mfrow=c(2,2))
plot(df$Global_active_power, type="l",
     xaxt="n", xlab="", ylab="Global Active Power", cex.lab=0.6)
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))

plot(df$Voltage, type="l",
     xaxt="n", xlab="datetime", ylab="Voltage", cex.lab=0.6)
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))

plot(df$Sub_metering_1, type="l",
     xaxt="n", xlab="", ylab="Energy sub metering", cex.lab=0.6)
lines(df$Sub_metering_2, type="l", col="red")
lines(df$Sub_metering_3, type="l", col="blue")
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), # puts text in the legend 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       #lwd=c(1,1), # gives the legend lines the correct width
       col=c("black","red","blue"), # gives the legend lines the correct color
       cex=0.2)

plot(df$Global_reactive_power, type="l",
     xaxt="n", xlab="datetime", ylab="Global_reactive_power", cex.lab=0.6)
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()