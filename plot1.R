#read in data
NEI <- readRDS("summarySCC_PM25.rds")

#sum emissions by year
yearTotals <- aggregate(Emissions ~ year, NEI, sum)

#make plot
png("plot1.png")

barplot(height = (yearTotals$Emissions)/10^6, names.arg = yearTotals$year, xlab = "Year", ylab = "PM2.5 Emissions (10^6 tons)")
title("Total PM2.5 Emissions in USA")

dev.off()

