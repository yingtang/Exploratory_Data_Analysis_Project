#read in data
energy <- read.csv("newData.txt")

y <- energy$Global_active_power
x <- energy$timetemp

#set margin
par(mar=c(4, 4, 2, 2.5))
#set axis label, tick label and line
par(mgp=c(2.1,0.6,0.0))

#plot y as a line plot, with not x tick label
#plot(y, xaxt='n', ylab="Global Active Power(Kilowatts)", 
#     cex.axis=0.8, xlab='', cex.lab=0.8, type="l")
#label x axis 
#axis(side=1,cex.axis=0.8, at=c(x[1], x[1440], x[2881]), label=c("Thu", "Fri", "Sat"))

#a better way to plot x axis with correct labels
plot(as.POSIXct(x), y, type="l", ylab="Global Active Power(Kilowatts)", cex.axis=0.8, xlab='', cex.lab=0.8)

dev.copy(png,filename="plot2.png", width = 480, height = 480, units = "px");
dev.off()
