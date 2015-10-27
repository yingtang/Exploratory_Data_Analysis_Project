#read in data
energy <- read.csv("newData.txt")

x <- energy$timetemp

y1 <- energy$Sub_metering_1
y2 <- energy$Sub_metering_2
y3 <- energy$Sub_metering_3

#set margin
par(mar=c(4, 4, 2, 2.5))
#set axis label, tick label and line
par(mgp=c(2.1,0.6,0.0))

#Plot three lines into one graph
plot(y1, type="l", ylab="Energy sub metering", xlab='', 
     xaxt='n', cex.lab=0.8, cex.axis=0.8)
with(energy, lines(y2, col="red"))
with(energy, lines(y3, col="blue"))

#label x axis 
axis(side=1,cex.axis=0.8, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))

#write legend
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 2, cex = 0.7)

dev.copy(png,filename="plot3.png", width = 480, height = 480, units = "px");
dev.off()
