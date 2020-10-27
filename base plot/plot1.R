library(dplyr)
library(lubridate)

data<-read.table(file.choose(),sep=';')
colnames(data)<-data[1,]

data_use<-data[-1,]%>%
  mutate(Date=as.Date(Date,'%d/%m/20%y'))%>%
  subset(Date=='2007-02-01'|Date=='2007-02-02')


png('plot1.png',width = 480,height = 480)
hist(as.numeric(data_use$Global_active_power),
     main = 'Global Active Power',
     xlab = 'Global Active Power(kilowatts)',
     ylab = 'Frequency',col = 'red')
dev.off()
