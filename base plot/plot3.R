library(dplyr)
library(lubridate)

data<-read.table(file.choose(),sep=';')
colnames(data)<-data[1,]

data_use<-data[-1,]%>%
  mutate(Date=as.Date(Date,'%d/%m/20%y'))%>%
  subset(Date=='2007-02-01'|Date=='2007-02-02')

datatime<-strptime(paste(data_use$Date,data_use$Time, sep=" "), "%Y-%m-%d %H:%M:%S",tz = "GMT")

png('plot3.png',width = 480,height = 480)
plot(datatime,data_use$Sub_metering_1,type = 'l',xlab = '',ylab = 'Energy sub metering')
lines(datatime,data_use$Sub_metering_2,col='red',type = 'l')
lines(datatime,data_use$Sub_metering_3,col='blue',type = 'l')
legend('topright',lty = 1,lwd = 1,col = c('black','red','blue'),
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.off()