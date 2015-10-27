#Question 2, Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) 
#from 1999 to 2008? Use the base plotting system to make a plot answering 
#this question.
#Answer: Yes

#Load data from the current directory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds") 
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#collect data which only belongs to city Baltimore by fips number
Baltimore <- NEI[ which(NEI$fips=="24510"),]

#we use the aggregate function to sum all emissions from each year
emission_Baltimore <- aggregate(Baltimore$Emissions, by=list(Year=Baltimore$year), FUN=sum)

#use base plot function to plot the total emission versus yeary
y <- emission_Baltimore$x
x <- emission_Baltimore$Year
plot(x, y, pch=19, xaxt='n',
     xlab="Year", ylab="Total Emissions (tons)", 
     ylim=c(1700, 3400),
     cex.lab=1.2, main="PM2.5 Emissions in Baltimore, MD")
axis(side=1,cex.axis=1,2, at=c(x[1], x[2], x[3], x[4]), label=c("1999", "2002", "2005", "2008"))

#add regression line to the plot
fit <- lm(y~x)
abline(fit, col="red")

print(paste0("There is a decrease of ", toString(round(fit$coefficient[2],3)), " tons of PM2.5 per year."))
#save plot 2 to png format
dev.copy(png,filename="plot2.png", width = 480, height = 480, units = "px");
dev.off()