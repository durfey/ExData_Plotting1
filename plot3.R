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

##Plot 3

par(mfrow=c(1,1),bg="transparent")
x<-hpc$DateTime
a<-hpc$Sub_metering_1
b<-hpc$Sub_metering_2
c<-hpc$Sub_metering_3
plot(x,a,type="l",ylab="Energy sub metering",xlab="")
lines(x,b,col="red")
lines(x,c,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Create the png file of plot3

png(file="plot3.png")
par(mfrow=c(1,1),bg="transparent")
x<-hpc$DateTime
a<-hpc$Sub_metering_1
b<-hpc$Sub_metering_2
c<-hpc$Sub_metering_3
plot(x,a,type="l",ylab="Energy sub metering",xlab="")
lines(x,b,col="red")
lines(x,c,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
