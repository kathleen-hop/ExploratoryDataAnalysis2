#read in data
NEI <- readRDS("summarySCC_PM25.rds")

#subset Baltimore City data
subNEI <- subset(NEI, fips == "24510")

#sum emissions by year
yearTotals <- aggregate(Emissions ~ year, subNEI, sum)

#make plot
png("plot2.png")

barplot(height = (yearTotals$Emissions/10^3), names.arg = yearTotals$year, xlab = "Year", ylab = "PM2.5 Emissions ( 10^3 tons)")
title("Total PM2.5 Emissions in Baltimore City")

dev.off()