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

##Plot 2

par(mfrow=c(1,1),bg="transparent")
with(hpc,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

##Create the png file of plot2

png(file="plot2.png")
par(mfrow=c(1,1),bg="transparent")
with(hpc,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()