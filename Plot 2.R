
#Get the path of working directory
path <- getwd()

#Download the zip file there
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = paste(path, "pollutiondata.zip",sep = "/"))

#read the data into R
scc_pm25 <- readRDS("summarySCC_PM25.RDS")

Subsetdata <- subset(scc_pm25,scc_pm25$fips == "24510")

#Aggregate the Emissions data by Year
yearbytotal <- aggregate(Emissions ~ year, scc_pm25,FUN = "sum")

#Plot the Total Emissions by Year
png("plot2.png",width = 480, height = 480)

barplot(yearbytotal$Emissions,names = yearbytotal$year, xlab = "Years",ylab = "Total Emissions",main = "Total Emissions by Year")

dev.off()
