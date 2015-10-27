#Question 3, Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
#Answer: NON-ROAD, NONPOINT, ON-ROAD have seen decrease, while POINT
#has seen a slight increase. 

library(ggplot2)
library(reshape2)
library(plyr)

#Read in data from the current directory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds") 
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#collect data which only belongs to city Baltimore by fips number
Baltimore <- NEI[ which(NEI$fips=="24510"),]



# #calculate total emissions per year from different types
# names <- levels(factor(Baltimore$type))
# new_names=vector()
# for (i in names){
#   data_tmp <- Baltimore[which(Baltimore$type==i), ]
#   
#   if (i=="ON-ROAD"){
#     n = "ONROAD"
#     new_names <- append(new_names, n)
#   }
#   else if (i=="NON-ROAD"){
#     n="NONROAD"
#     new_names <- append(new_names, n)
#   }
#   else{
#     n=i
#     new_names <- append(new_names, n)
#   }
#   
#   assign(paste('Data_', n, sep=''), aggregate(data_tmp$Emissions, by=list(Year=data_tmp$year), FUN=sum))
# }
# 
# Baltimore_type <- Reduce(function(x, y) merge(x, y, by="Year"), 
#                          list(Data_NONROAD, Data_NONPOINT, Data_ONROAD, Data_POINT))
# 
# 
# 
# new_names <- append("Year", new_names)
# colnames(Baltimore_type) = new_names
# 
# #use ggplot2 plot function to plot the total emission versus year
# #with different types
# #reshape the data for plotting,  
# m <- melt(Baltimore_type, id.vars="Year")
# 
# #JUST REALIZED THAT ALL ABOVE CODE CAN BE REPLACED BY THIS SINGLE LINE BELOW!
# #BY THIS SINGLE LINE!!!!!!!!!

m <- ddply(Baltimore, .(year, type), summarize, emission_sum = sum(Emissions))

g <- ggplot(m, aes(year,emission_sum)) + 
  geom_point() + 
  geom_smooth(method="lm", col="red") + 
  facet_wrap(~type) +
  labs(title="PM2.5 Emissions in Baltimore, MD by Source Type") +
  ylab("Total Emissions (tons)")

print(g)

dev.copy(png,filename="plot3.png", width = 480, height = 480, units = "px");
dev.off()