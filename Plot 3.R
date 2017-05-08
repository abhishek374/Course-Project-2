
#Get the path of working directory
path <- getwd()

#Download the zip file there
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = paste(path, "pollutiondata.zip",sep = "/"))

#read the data into R
scc_pm25 <- readRDS("summarySCC_PM25.RDS")

Subsetdata <- subset(scc_pm25,scc_pm25$fips == "24510")

#Aggregate the Emissions data by Year
year_typebytotal <- aggregate(Emissions ~ year + type, scc_pm25,FUN = "sum")

#Plot the Total Emissions by Year
png("plot3.png",width = 480, height = 480)
g <- ggplot(year_typebytotal,aes(year,Emissions,color = type))
g +  geom_line() + xlab( "year") + ylab ( "Total Emissions") + ggtitle("Total Emissions in Baltimore")
dev.off()
