library(dplyr)
library(lubridate)

data<-read.table(file.choose(),sep=';')
colnames(data)<-data[1,]

data_use<-data[-1,]%>%
  mutate(Date=as.Date(Date,'%d/%m/20%y'))%>%
  subset(Date=='2007-02-01'|Date=='2007-02-02')

datatime<-strptime(paste(data_use$Date,data_use$Time, sep=" "), "%Y-%m-%d %H:%M:%S",tz = "GMT")

png('plot2.png',width = 480,height = 480)
plot(datatime,data_use$Global_active_power,
     xlab = '',ylab = 'Global Active Power(kilowatts)',type = 'l')
dev.off()