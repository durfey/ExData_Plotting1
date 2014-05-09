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


##Plot 1

par(mfrow=c(1,1),bg="transparent")
with(hpc,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))


##Create the png file of plot1

png(file="plot1.png",width=480,height=480)
par(mfrow=c(1,1),bg="transparent")
with(hpc,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()