#Q6: Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, California 
#(fips == "06037"). Which city has seen greater changes over time in 
#motor vehicle emissions?
#Answer: LA has a slightly bigger change than Baltimore based on the slope of the linear regression


library(ggplot2)
library(plyr)

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

#collect data which only belongs to city Baltimore and LAby fips number
Bal_LA <- rbind(NEI [NEI$fips=="24510",], NEI [NEI$fips=="06037",] )

#Slice mobile vehicle data from type == ON ROAD
Bal_LA_MV <- Bal_LA[ Bal_LA$type=='ON-ROAD', ]

#calculate yearly total emission by city fips
m <- ddply(Bal_LA_MV, .(year, fips), summarize, emission_sum = sum(Emissions))

g <- ggplot(m, aes(year,emission_sum)) + 
  geom_point() + 
  geom_smooth(method='lm', col="red") + 
  facet_wrap(~fips) +
  labs(title="PM2.5 Emissions from Mobile Vehicles in Baltimore, MD and Los Angeles, CA") +
  ylab("Total Emissions (tons)")

print(g)
#save plot 6 to png format
dev.copy(png,filename="plot6.png", width = 480, height = 480, units = "px");
dev.off()

