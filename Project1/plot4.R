energy <- read.csv("newData.txt")

#data for the first plot
x1 <- energy$timetemp
y1 <- energy$Global_active_power

#data for the second plot
y2 <- energy$Voltage

#data for the third plot
y3a <- energy$Sub_metering_1
y3b <- energy$Sub_metering_2
y3c <- energy$Sub_metering_3

#data for the 4th plot
y4 <- energy$Global_reactive_power

#start plotting...
#first, set up the plottig panel
par(mfrow = c(2, 2))  #a 2 x 2 panel

par(mar=c(3.5,3,2,2))

with(energy, {
  #first plot
  plot(y1, xaxt='n', ylab="Global Active Power",
       cex.axis=0.6, xlab='', cex.lab=0.6, type="l")
  #label x axis 
  axis(side=1,cex.axis=0.6, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))
  
  #second plot
  plot(y2, xaxt='n', ylab="Voltage",
       cex.axis=0.6, xlab='datetime', cex.lab=0.6, type="l")
  axis(side=1,cex.axis=0.6, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))
  
  #third plot
  plot(y3a, xaxt='n', ylab="Voltage",
       cex.axis=0.6, xlab='', cex.lab=0.6, type="l")
  with(energy, lines(y3b, col="red"))
  with(energy, lines(y3c, col="blue"))
  legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lwd = 2, cex = 0.3)
  axis(side=1,cex.axis=0.6, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))
  
  #fourth plot
  plot(y4, xaxt='n', ylab="Global_reactive_power",
       cex.axis=0.6, xlab='datetime', cex.lab=0.6, type="l")
  axis(side=1,cex.axis=0.6, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))
  
})

#save plot to plot4.png
dev.copy(png,filename="plot4.png", width = 480, height = 480, units = "px");
dev.off()