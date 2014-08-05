## Read in data
power.all<-read.table(file="household_power_consumption.txt",header=TRUE,sep=";",
                      nrows=2075259,colClasses="character",na.strings="?")
##
## Subset data for Feb 1 and 2, 2007
power<-subset(power.all,(power.all$Date=="1/2/2007"|power.all$Date=="2/2/2007"))
##
## Combine date and time columns and convert to POSIXlt class
power$DateTime<-paste(power$Date,power$Time,sep=" ")
power$DateTime<-strptime(power$DateTime,format="%d/%m/%Y %H:%M:%S")
## Convert columns 3 through 9 to numeric class
for (i in 3:9){
        power[,i]<-as.numeric(power[,i])
}
## 
png(filename="plot4.png",width=480,height=480)
## Set up 2 X 2 grid
par(mfrow=c(2,2))
##
## Global Active Power with Date/Time
with(power,plot(DateTime,Global_active_power,xlab="",
                ylab="Global Active Power",type="n"))
lines(power$DateTime,power$Global_active_power)
##
## Voltage with Date/Time
with(power,plot(DateTime,Voltage,xlab="datetime",ylab="Voltage",type="n"))
lines(power$DateTime,power$Voltage)
##
## Sub metering with Date/Time
with(power,plot(DateTime,Sub_metering_1,xlab="",
                ylab="Energy sub metering",type="n"))
lines(power$DateTime,power$Sub_metering_1,col="black")
lines(power$DateTime,power$Sub_metering_2,col="red")
lines(power$DateTime,power$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),bty="n")
##
## Global reactive power with Date/Time
with(power,plot(DateTime,Global_reactive_power,xlab="datetime",type="n"))
lines(power$DateTime,power$Global_reactive_power)
dev.off()