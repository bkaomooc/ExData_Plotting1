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

plot(df$Global_active_power[order(df$DateTime)], type="l",
     xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
axis(1, labels=c("Thr", "Fri", "Sat"), at = c(1, 1440, 2880))

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()