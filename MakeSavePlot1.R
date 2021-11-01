# Download and unzip data
if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}
unzip("data.zip") # This creates the file "household_power_consumption.txt"
#Read the data in to R

data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#create a variable, combine Date and Time.
#change the  factor Date and Time values in to yyyy-mm-dd hh:mm:ss
data$DateTime<-paste(data$Date, data$Time)

#change DateTime to yyyy-mm-dd hh:mm:ss
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#work with the data for dates 2007-02-01 and 2007-02-02
day1<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
day2<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
data2<-data[day1:day2,]

## Make and save plot1
png("plot1.png", width=480, height=480)
hist(as.numeric(as.character(data2$Global_active_power)),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()