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

## ## HERE ARE THE INSTRUCTIONS FOR PLOT #2:

plotdata <- subset(subsetPowerData, Date >= "2007-02-01" & Date <= "2007-02-02")
plot(plotdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxt="n", xlab='')

## I've removed the usual tick marks with "xaxt" (above), and want to add 3 specific tick marks:
## One at 0 (called "Thu"), one at the point where the Friday dates start (called "Fri")
## and one at the last data point (called "Sat"). I've put these in a vector called "ticks":

thursday <- 0
friday <- dim(subset(plotdata, Date == as.Date("2007-02-02")))[1]
saturday <- dim(plotdata)[1]
ticks <- c(thursday, friday, saturday)

## Will use the "axis" command to label the x-axis with days of the week.
## Syntax of the axis command is here below (for reference):
## axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...) 

axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

## Finally, save file:

dev.copy(png, file="plot2.png")
dev.off()

