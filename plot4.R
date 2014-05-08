##Read and prepare applicable data

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

##Create the png file of plot4

png(file="plot4.png")
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