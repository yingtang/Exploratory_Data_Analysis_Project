#Q5: How have emissions from motor vehicle sources changed from 
#1999–2008 in Baltimore City?
#Yes, there is a decrease. 

#Read in data from the current directory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds") 
}

if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}


#Find mobile vehicle sources
#Here we just need to subset the data that belong to
#ON-ROAD type from NEI data. 

#Slice data which only belongs to city Baltimore by fips number
Baltimore <- NEI[ which(NEI$fips=="24510"),]

#college mobile vehicle data from type == ON ROAD
Baltimore_mobile <- Baltimore[Baltimore$type=="ON-ROAD", ]

#calculate the yearly totla emission 
Emission_Baltimore_Mobile <- aggregate(Baltimore_mobile$Emissions, by=list(Year=Baltimore_mobile$year), FUN=sum)

y <- Emission_Baltimore_Mobile$x
x <- Emission_Baltimore_Mobile$Year

plot(x, y, pch=19, xaxt='n',
     xlab="Year", ylab="Total Emissions from Mobile Vehicles (tons)", 
     ylim = c(50, 400), 
     cex.lab=1.2, main="PM2.5 Emissions from Mobile Vehicles in Baltimore, MD")
axis(side=1,cex.axis=1,2, at=c(x[1], x[2], x[3], x[4]), label=c("1999", "2002", "2005", "2008"))

#add regression line to the plot
fit <- lm(y~x)
abline(fit, col="red")

print(paste0("There is a decrease of ", toString(round(fit$coefficient[2],3)), " tons of PM2.5 emissions from Mobile Vehicles every year."))

#save plot 2 to png format
dev.copy(png,filename="plot5.png", width = 480, height = 480, units = "px");
dev.off()

