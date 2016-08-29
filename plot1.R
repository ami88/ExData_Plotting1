# Here I upload all the packages that I think I might need
# For the moment, there is none

# Reading my data
# Quick estimation of size 2075260 rows x 9 cols x 8 bytes:
# ~ 1.5E8 bytes ~ 145 MB
mypath = "/Users/ami/Dropbox/Coursera/ExploDataAnalysis/Tarea1/"
myfile <- paste(mypath,"household_power_consumption.txt", sep="")
initial <- read.table(myfile, nrows=100, sep=";", header=TRUE,na.strings = "?")
classes <- sapply(initial, class)
mydata <- read.table(myfile,colClasses=classes,sep=";", header=TRUE, na.strings = "?")
# I check that I read everything
cat("Dim of my table: ", as.character(dim(mydata)), "\n")
# Dim of my table:  2075259 9
# Seems right
#> names(c)
#[1] "Date"                  "Time"                  "Global_active_power"  
#[4] "Global_reactive_power" "Voltage"               "Global_intensity"     
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

# I select those data in my range of dates
#strptime()
mydate <-  as.Date(mydata$Date, format="%d/%m/%Y")
mydatasel <- mydata[mydate >= as.Date("2007-02-01") & mydate <= as.Date("2007-02-02"),]
cat("Dim of my selection: ", as.character(dim(mydatasel)), "\n")

# I remove all the lines that do have some NA in any of the columns (if there were any)
mydataclean <-  mydatasel[complete.cases(mydatasel),]
cat("Dim of my selection once cleaned: ", as.character(dim(mydataclean)), "\n")

# I do the plot itself
jpeg('plot1.jpg', width = 480, height = 480)
with(mydataclean, hist(Global_active_power, col="red",
                       xlab="Global Active Power (kilowatts)",
                       ylab="Frecuency", main="Global Active Power"))
dev.off()



