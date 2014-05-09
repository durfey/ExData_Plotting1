##First, we read and prepare the applicable data.
##
##Due to the project instructions, we will assume that the file "household_power_consumption.txt"
##is already in the users working directory.
##However, we could download & unzip the file automatically using the following:
##      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
##              destfile="h.zip")
##      unzip("h.zip")
##
##I use the 'fread' function of reading the file here, which requires the data.table package.
##If that package is not already installed/loaded, it can be done so with the following:
##      install.packages("data.table")
##      library(data.table)

findRows<-fread("household_power_consumption.txt", header = TRUE, select = 1)
all<-(which(findRows$Date %in% c("1/2/2007", "2/2/2007")) )
skipLines<- min(all)
keepRows<- length(all)
hpcDT<- fread("household_power_consumption.txt", skip = (skipLines) , nrows = keepRows, header = "auto")
rm(findRows)

colNamesTemp<-fread("household_power_consumption.txt", header = TRUE, nrows=1)
setnames(hpcDT,colnames(colNamesTemp))
rm(colNamesTemp)

hpc<-data.frame(hpcDT)
b<-strptime(paste(hpc$Date, hpc$Time,sep=" "),format = "%d/%m/%Y %H:%M:%S")
hpc$DateTime<-b


##Plot 4

par(mfrow = c(2,2),bg="transparent")
x<-hpc$DateTime
y<-hpc$Global_active_power
y2<-hpc$Voltage
y3<-hpc$Global_reactive_power
a<-hpc$Sub_metering_1
b<-hpc$Sub_metering_2
c<-hpc$Sub_metering_3
plot(x,y,type="l",xlab="",ylab="Global Active Power")
plot(x,y2,type="l",xlab="datetime",ylab="Voltage")
plot(x,a,type="l",ylab="Energy sub metering",xlab="")
lines(x,b,col="red")
lines(x,c,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(x,y3,type="l",xlab="datetime",ylab="Global_reactive_power")


##Creation of the png file of plot4
##Note: I purposefully made the background transparent, since the figures added
##by the instructor are also transparent. (I mention this just because there has
##been some contention in the forums about this aspect.)

png(file="plot4.png",width=480,height=480)
par(mfrow = c(2,2),bg="transparent")
x<-hpc$DateTime
y<-hpc$Global_active_power
y2<-hpc$Voltage
y3<-hpc$Global_reactive_power
a<-hpc$Sub_metering_1
b<-hpc$Sub_metering_2
c<-hpc$Sub_metering_3
plot(x,y,type="l",xlab="",ylab="Global Active Power")
plot(x,y2,type="l",xlab="datetime",ylab="Voltage")
plot(x,a,type="l",ylab="Energy sub metering",xlab="")
lines(x,b,col="red")
lines(x,c,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(x,y3,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()