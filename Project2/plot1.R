#Question 1:Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for 
#each of the years 1999, 2002, 2005, and 2008.
#Answer: Yes. 

#Read in data from the current directory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds") 
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#we use the aggregate function to sum all emissions from each year
emission_USA <- aggregate(NEI$Emissions, by=list(Year=NEI$year), FUN=sum)

#use base plot function to plot the total emission versus yeary
y <- emission_USA$x
x <- emission_USA$Year
plot(x, y, pch=19, xaxt='n', 
     xlab="Year", ylab="Total Emissions (tons)", ylim=c(3e+06, 7.8e+06),
     cex.lab=1.2, main="PM2.5 Emissions across USA", )
axis(side=1,cex.axis=1,2, at=c(x[1], x[2], x[3], x[4]), label=c("1999", "2002", "2005", "2008"))

#add regression line to the plot
fit <- lm(y~x)
abline(fit, col="red")

print(paste0("There is a decrease of ", toString(round(fit$coefficient[2],3)), " tons of PM2.5 per year."))
#save plot 1 to png format
dev.copy(png,filename="plot1.png", width = 480, height = 480, units = "px");
dev.off()