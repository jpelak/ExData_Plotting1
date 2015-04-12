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
png(width=480, height=480, file="plot1.png")

# create a histogram of Global Active Power
hist(powerConsumption$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# write output to file
dev.off()

