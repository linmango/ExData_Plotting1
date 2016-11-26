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

## HERE ARE THE INSTRUCTIONS FOR PLOT #1:

hist(subsetPowerData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()




