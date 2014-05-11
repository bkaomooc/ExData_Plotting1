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

plot(df$Sub_metering_1, type="l",
     xaxt="n", xlab="", ylab="Energy sub metering")
lines(df$Sub_metering_2, col="red")
lines(df$Sub_metering_3, col="blue")
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), # puts text in the legend 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       #lwd=c(2.5,2.5), # gives the legend lines the correct width
       col=c("black","red","blue"), # gives the legend lines the correct color
       cex=0.55)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()