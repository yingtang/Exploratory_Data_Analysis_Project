#read in data
energy <- read.csv("newData.txt")

#set margin 
par(mar=c(3,3,2,1))

#set axis label, tick label and lines
par(mgp=c(1.8,0.6,0.0))

#plot the histogram of "global active power"
hist(energy$Global_active_power, col="red", 
     cex.axis=0.65, cex.lab=0.65, cex.main=0.75, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

#save plot to png format
dev.copy(png,filename="plot1.png", width = 480, height = 480, units = "px");
dev.off()


