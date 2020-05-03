

library(dplyr)
library(lubridate)



# 1. Load data sets and select 2 dates (2007-02-01 and 2007-02-02) ----------

df <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

df$Date <- as.Date(df$Date, "%d/%m/%Y" )



df$Global_active_power <- as.numeric(df$Global_active_power)
data_graph <- df %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

data_graph$Time <- strptime(data_graph$Time, "%H:%M:%S")





# Start plotting ----------------------------------------------------------



png(file="plot4.png",width=480, height=480)
par(mfrow=c(2,2))


# plot - top left
plot(seq(length(data_graph$Time)), data_graph$Global_active_power, ylab = "Global Active Power (kilowatts)", type = 'l', xlab = "", xaxt = "n")
axis(1, at = c(1, nrow(data_graph)/2, nrow(data_graph)), lab = c("Thu", "Fri", "Sat"))

# plot- top right
plot(seq(length(data_graph$Time)), data_graph$Voltage, ylab = "Voltage", type = 'l', xlab = "datetime", xaxt = "n")
axis(1, at = c(1, nrow(data_graph)/2, nrow(data_graph)), lab = c("Thu", "Fri", "Sat")) 


# plot  - bottom left 
plot(seq(length(data_graph$Time)), data_graph$Sub_metering_1, ylab = "Energy Sub metering", type = 'l', xlab = "", xaxt = "n")
lines(seq(length(data_graph$Time)), data_graph$Sub_metering_2, col="red", pch="*")
lines(seq(length(data_graph$Time)), data_graph$Sub_metering_3, col="blue", pch="*")
legend(800, 35, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty= 1, ncol=1, bty = "n")
axis(1, at = c(1, nrow(data_graph)/2, nrow(data_graph)), lab = c("Thu", "Fri", "Sat"))

# plot  - bottom right 
plot(seq(length(data_graph$Time)), data_graph$Global_reactive_power, ylab = "Global_reactive_power", type = 'l', xlab = "datetime", xaxt = "n")
axis(1, at = c(1, nrow(data_graph)/2, nrow(data_graph)), lab = c("Thu", "Fri", "Sat")) 


dev.off()
