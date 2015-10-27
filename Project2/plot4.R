#Question 4, Across the United States, how have emissions from coal 
#combustion-related sources changed from 1999–2008?
#Yes

library(ggplot2)
library(plyr)

#Read in data from the current directory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds") 
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}


#First, we need to dig-in to SCC file to search for 
#the source numbers which consume Coal
#Using View from plyr package to check the SCC file. 

#We can see that "short-name" and "El.sector" might contain Coal, but it does not indicate
#that Coal is their fuel~ it only presents in which industrial sectors 
#they are. 

#A good place to search for Coal-Combustion sources are in SCC.Level.One-Four. 
#we use grepl to check which level are relevant, and we see 
#Level Three and Level Four contains our key word "Coal". 
sum(grepl("Coal", SCC$SCC.Level.One))
sum(grepl("Coal", SCC$SCC.Level.Two))
sum(grepl("Coal", SCC$SCC.Level.Three))
sum(grepl("Coal", SCC$SCC.Level.Four))

#So we focus on level Three and Four in SCC. 
index1 <- grepl("Coal", SCC$SCC.Level.Three)
index2 <- grepl("Coal", SCC$SCC.Level.Four)
#get subsect of SCC which consumes Coal
subSCC <- SCC[index1 & index2, ]
subNEI <- NEI[NEI$SCC %in% subSCC$SCC, ]

Coal_Consumbtion <- aggregate(subNEI$Emissions, by=list(Year=subNEI$year), FUN=sum)

y <- Coal_Consumbtion$x
x <- Coal_Consumbtion$Year
plot(x, y, pch=19, xaxt='n', 
     xlab="Year", 
     ylim=c(3e+5, 5.5e+5), 
     ylab="Total Emissions from Coal Combustion (tons)",
     cex.lab=1.2, 
     main="PM2.5 Emissions from Coal Combustion across USA")
axis(side=1,cex.axis=1,2, at=c(x[1], x[2], x[3], x[4]), label=c("1999", "2002", "2005", "2008"))
abline(lm(y~x), col="red")

dev.copy(png,filename="plot4.png", width = 480, height = 480, units = "px");
dev.off()