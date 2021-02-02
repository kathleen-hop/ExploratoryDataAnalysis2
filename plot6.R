library(ggplot2)
library(dplyr)

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset NEI for Baltimore City & Los Angeles
subNEI <- subset(NEI, fips == "24510" | fips == "06037")

#find data for mobile sources, SCC.Level.Two containing "vehicle"
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
subSCC <- SCC[vehicle, ]

#find vehicle data 
vehicleData <- subNEI[subNEI$SCC %in% subSCC$SCC, ]

#add column for city
vehicleData <- mutate(vehicleData, city = ifelse(fips == "06037", "Los Angeles", ifelse(fips == "24510", "Baltimore City", 0)))

#find year totals
yearTotals <- aggregate(Emissions ~ year + city, vehicleData, sum)

#make plot
png("plot6.png")

g <- ggplot(yearTotals, aes(factor(year), Emissions), fill = city)
g <- g + geom_bar(stat = "identity") + facet_grid(.~city) + labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Total Emissions in Baltimore City vs Los Angeles") + scale_y_continuous(limits = c(0, 8000))

print(g)

dev.off()