# read the power consumption data from file, with the following options:
#     the columns are separated by semicolons (';')
#     the first row should be interpreted as the headers for each column
#     interpeting all 9 columns as character initially
powerConsumption <- read.table("household_power_consumption.txt",
                               sep = ";",
                               header=TRUE,
                               colClasses=c(rep("character", 9)))

# subset to only the dates of interest- February 1+2, 2007
powerConsumption <- powerConsumption[powerConsumption$Date=="1/2/2007" | powerConsumption$Date=='2/2/2007',]

# transform the numeric columns
powerConsumption <- transform(powerConsumption,
                              Global_active_power = as.numeric(Global_active_power),
                              Global_reactive_power = as.numeric(Global_reactive_power),
                              Voltage = as.numeric(Voltage),
                              Global_intensity = as.numeric(Global_intensity),
                              Sub_metering_1 = as.numeric(Sub_metering_1),
                              Sub_metering_2 = as.numeric(Sub_metering_2),
                              Sub_metering_3 = as.numeric(Sub_metering_3))

# create a POSIXlt column from the Date + Time strings
powerConsumption$DateTime <- strptime(paste(powerConsumption$Date, powerConsumption$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# set up the PNG output device
png(width=480, height=480, file="plot4.png")

# set the parameter for multiple base plots 2x2
par(mfcol = c(2, 2))

# create a line plot of Global Active Power vs. Date + Time
plot(powerConsumption$DateTime,
     powerConsumption$Global_active_power,
     type="n",
     xlab="",
     ylab="Global Active Power")
lines(powerConsumption$DateTime,
      powerConsumption$Global_active_power,
      type="l")

# create line plots of Submeterings 1, 2, and 3 vs. Date + Time
plot(powerConsumption$DateTime,
     powerConsumption$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")
lines(powerConsumption$DateTime,
      powerConsumption$Sub_metering_1,
      type="l",
      col="black")
lines(powerConsumption$DateTime,
      powerConsumption$Sub_metering_2,
      type="l",
      col="red")
lines(powerConsumption$DateTime,
      powerConsumption$Sub_metering_3,
      type="l",
      col="blue")
legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n",
       lty=c(1, 1, 1),
       lwd=c(1, 1, 1))

# create a line plot of Voltage vs. Date + Time
plot(powerConsumption$DateTime,
     powerConsumption$Voltage,
     type="n",
     xlab="datetime",
     ylab="Voltage")
lines(powerConsumption$DateTime,
      powerConsumption$Voltage,
      type="l")

# create a line plot of Global Reactive Power vs. Date + Time
plot(powerConsumption$DateTime,
     powerConsumption$Global_reactive_power,
     type="n",
     xlab="datetime",
     ylab="Global_reactive_power")
lines(powerConsumption$DateTime,
      powerConsumption$Global_reactive_power,
      type="l")

# write output to file
dev.off()

