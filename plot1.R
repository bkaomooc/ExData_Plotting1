#setwd("D:/Coursera/Data Science/Exploratory Data Analysis/CourseProject/wk1")
library(sqldf)
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                   header = TRUE, sep = ";")
df[ df == "?" ] = NA        # Replace missing value "?" with NA
df <- na.omit(df)           # Remove records with NA

hist(df$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()