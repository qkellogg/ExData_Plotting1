## Read in data
power.all<-read.table(file="household_power_consumption.txt",header=TRUE,sep=";",
                      nrows=2075259,colClasses="character",na.strings="?")
##
## Subset data for Feb 1 and 2, 2007
power<-subset(power.all,(power.all$Date=="1/2/2007"|power.all$Date=="2/2/2007"))
##
## Combine date and time columns
power$DateTime<-paste(power$Date,power$Time,sep=" ")
power$DateTime<-strptime(power$DateTime,format="%d/%m/%Y %H:%M:%S")
for (i in 3:9){
        power[,i]<-as.numeric(power[,i])
}
## Create a histogram of Global Active Power 
png(filename="plot1.png",width=480,height=480)
hist(power$Global_active_power,main="Global Active Power",col="red",
     xlab="Global Active Power (kilowatts)")
dev.off()