library(ggplot2)

#read in data
NEI <- readRDS("summarySCC_PM25.rds")

#separate Baltimore City data
subNEI <- subset(NEI, NEI$fips == "24510")

#sum emissions by year and type
yearTotals <- aggregate(Emissions ~ year + type, subNEI, sum)

#make plot
png("plot3.png", width = 700)

g <- ggplot(yearTotals, aes(year, Emissions, fill = type))
g <- g + geom_bar(stat = "identity") + facet_grid(.~type) + labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Total Emissions by Type in Baltimore City") + theme(legend.position = "none") + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(g)

dev.off()



