library(ggplot2)

#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset NEI for Baltimore City
subNEI <- subset(NEI, fips == "24510")

#find data for mobile sources, SCC.Level.Two containing "vehicle"
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
subSCC <- SCC[vehicle, ]

vehicleData <- subNEI[subNEI$SCC %in% subSCC$SCC, ]

#find total emissions per year
yearTotals <- aggregate(Emissions ~ year, vehicleData, sum)

#make plot
png("plot5.png")

g <- ggplot(yearTotals, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Total Coal Emissions from Motor Vehicles in Baltimore City")

print(g)

dev.off()