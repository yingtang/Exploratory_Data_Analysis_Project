#load data to R
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?", ""))

#extract data from 2007-02-01 and 2007-02-02
tmp1 <- data[data$Date=="1/2/2007", ]
tmp2 <- data[data$Date=="2/2/2007", ]
tmp3 <- data[data$Date=="3/2/2007", ]

#merge power consumption info of these two days
#update data to release some memory
#add the first row of the data from 2007-02-03 for the Sat labeling
energy <- rbind(tmp1, tmp2, tmp3[1,])  

#convert date and time format
energy$Date <- as.Date(energy$Date, format="%d/%m/%Y")
energy$timetemp <- paste(energy$Date, energy$Time)
energy$Time <- strptime(energy$timetemp, format = "%Y-%m-%d %H:%M:%S")

write.csv(energy, file = "newData.txt")


