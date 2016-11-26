##
## To construct Plot:
##
## First read in data file.
## 
## Because it is such a large file, I read that it is much faster and more efficient
## to specify specify the number of rows as well as the classes of the columns.
## So I did the initial data load like this:

initial <- read.table("household_power_consumption.txt", header=TRUE, nrows=5)
classes <- sapply(initial, class)
powerData <- read.table("household_power_consumption.txt", header=TRUE, colClasses=classes, nrows=2100000, na.strings="?", sep=";")

## Next, REMOVE any lines with missing items from data set:

good <- complete.cases(powerData)
goodSet <- powerData[good, ]

## Next, need to SUBSET the relevant data set to be used
## The default date format is yyyy-mm-dd, but our data set is in the format dd/mm/yyyy.
## So 2007-02-01 is represented in our set as 1/2/2007

goodSet$Date <- as.Date(goodSet$Date, format="%d/%m/%Y")
subsetPowerData <- subset(goodSet, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## The resulting data set has 2880 items.

#### HERE ARE THE INSTRUCTIONS FOR PLOT #4:

# First set up the plot area for the 4 plots:

par(mfrow = c(2,2))

# Since all the plots show the days of the week on the x-axis,
# set up the data for this:

thursday <- 0
friday <- dim(subset(plotdata, Date == as.Date("2007-02-02")))[1]
saturday <- dim(plotdata)[1]
ticks <- c(thursday, friday, saturday)

## Then draw each graph:

## First, Plot #2:

plotdata <- subset(subsetPowerData, Date >= "2007-02-01" & Date <= "2007-02-02")
plot(plotdata$Global_active_power, type="l", ylab="Global Active Power", xaxt="n", xlab='')
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

## Next, plot Voltage vs. date and time:

## For this, first put date and time together:
plotdata$datetime <- as.POSIXct(paste(plotdata$Date, plotdata$Time), format="%Y-%m-%d %H:%M:%S")
plot(plotdata$Voltage, type="l", ylab="Voltage", xaxt="n", xlab='')
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

# Next, Plot #3:

plot(plotdata$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt="n", xlab='')
lines(plotdata$Sub_metering_2, type="l", col="red")
lines(plotdata$Sub_metering_3, type="l", col="blue")
legend(1000, 40, lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), y.intersp=.8, cex=.8, bty="n")
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

# Next, a graph of Global reactive power vs. datetime:

plot(plotdata$Global_reactive_power, type="l", ylab="Voltage", xaxt="n", xlab='')
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))


## Finally, save file:

dev.copy(png, file="plot4.png")
dev.off()

