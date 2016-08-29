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
mydateandtime <- as.POSIXct(paste(mydata$Date, mydata$Time), format="%d/%m/%Y %H:%M:%S")
mydatasel <- mydata[mydate >= as.Date("2007-02-01") & mydate <= as.Date("2007-02-02"),]
mydateandtimesel <- mydateandtime[mydate >= as.Date("2007-02-01") & mydate <= as.Date("2007-02-02")]
cat("Dim of my selection: ", as.character(dim(mydatasel)), "\n")

# I remove all the lines that do have some NA in any of the columns (if there were any)
mydataclean <-  mydatasel[complete.cases(mydatasel),]
mydateandtimeclean <- mydateandtimesel[complete.cases(mydatasel)]
cat("Dim of my selection once cleaned: ", as.character(dim(mydataclean)), "\n")

# I do the plot itself
par(mar=c(5.1,4.1,4.1,2.1))
jpeg('plot4.jpg', width = 480, height = 480)
# Create a panel 2x2
# Labels in x axis are in Spanish when running with Rstudio
par(mfrow=c(2,2))
# Plot 1
plot(mydateandtimeclean,mydataclean$Global_active_power, 
     ylab="Global Active Power (KW)", 
     xlab=" ", type="l")

# Plot 2
plot(mydateandtimeclean,as.numeric(as.character(mydataclean$Voltage)), 
     ylab="Voltage", 
     xlab="datetime", type="l")

# Plot 3
# I do not understand 100% why but it reads Sub_metering_1 and Sub_metering_2
# as factor and Sub_metering_3 as numeric. It happens with other variables.
# Anyway, I fix it on the way.
plot(mydateandtimeclean,as.numeric(as.character(mydataclean$Sub_metering_1)), 
                  ylab="Energy sub mettering", 
                  xlab=" ", type="l")
lines(mydateandtimeclean,as.numeric(as.character(mydataclean$Sub_metering_2)),col="red")
lines(mydateandtimeclean,mydataclean$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col=c("black","red", "blue"), bty = "n")

# Plot 4
plot(mydateandtimeclean,as.numeric(as.character(mydataclean$Global_reactive_power)), 
     ylab="Global Reactive Power", 
     xlab="datetime", type="l")


dev.off()
# I come back to the default, just in case
par(mfrow=c(1,1))
