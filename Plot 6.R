
library(ggplot2)
#Get the path of working directory
path <- getwd()

#Download the zip file there
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = paste(path, "pollutiondata.zip",sep = "/"))

#read the data into R
scc_pm25 <- readRDS("summarySCC_PM25.RDS")
sourceCode <- readRDS("Source_Classification_Code.RDS")
#Find the sources related to coal and combustion
vehmatches  <- grepl("vehicle", sourceCode$SCC.Level.Two, ignore.case=TRUE)
filteredcodes <- sourceCode[vehmatches,]
shortcodes <- scc_pm25[(scc_pm25$SCC %in% filteredcodes$SCC)& (scc_pm25$fips == "24510"),]
#Aggregate the Emissions data by Year
yearbytotal <- aggregate(Emissions ~ year, shortcodes,FUN = "sum")

#Plot the Total Emissions by Year
png("plot6.png",width = 480, height = 480)
g <- ggplot(yearbytotal,aes(year,Emissions),fill = city)
g +  geom_bar(stat  = "identity")+ facet_grid(city~., scales="free")+ xlab( "year") + ylab ( "Total Emissions") + ggtitle("Total Emissions from coal sources")
dev.off()
