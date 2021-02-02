library(ggplot2)

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#separate coal combustion data, select entries that contain coal in the Short.Name
coal <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
coalSCC <- SCC[coal, ]

coalData <- NEI[NEI$SCC %in% coalSCC$SCC, ]

#sum emissions by year
yearTotals <- aggregate(Emissions ~ year, coalData, sum)

#make plot
png("plot4.png")

g <- ggplot(yearTotals, aes(year, (Emissions/10^3)))
g <- g + geom_bar(stat = "identity") + labs(x = "Year", y = "PM2.5 Emissions (10^3 tons)", title = "Total Coal Emissions by Year in USA") + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))
print(g)

dev.off()




