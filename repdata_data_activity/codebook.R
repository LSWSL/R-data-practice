library(dplyr)
library(ggplot2)


activity<-read.csv(file.choose())
activity<-group_by(activity,date)
steps<-summarise(activity,steps=sum(steps,na.rm=T))
hist(steps$steps,main = 'total steps',xlab = 'steps')
sts1<-summarise(steps,mean=mean(steps),median=median(steps))

activity<-group_by(activity,interval)
avg_step<-summarise(activity,steps=mean(steps,na.rm = T))
avg_step<-avg_step%>%mutate(steps=as.integer(steps))
plot(avg_step$interval,avg_step$steps,type = 'l',ylab = 'average of steps',xlab = 'interval')

sum(is.na(activity))

activity2<-activity

for(i in avg_step$interval){
activity2[activity2$interval==i&is.na(activity2$steps),]$steps<-avg_step$steps[avg_step$interval==i]
}
sum(is.na(activity2))

activity2<-group_by(activity2,date)
steps<-summarise(activity2,steps=sum(steps,na.rm=T))
hist(steps$steps,main = 'total steps',xlab = 'steps')
summarise(steps,mean=mean(steps),median=median(steps))

activity2<-mutate(activity2,weekdays=weekdays(as.Date(date)))
activity2<-mutate(activity2,weekdays=recode(weekdays(as.Date(date)),
                  '星期六'='weekend','星期日'='weekend',.default = 'weekday'))

activity2<-group_by(activity2,weekdays,interval)
st2<-summarise(activity2,steps=mean(steps))
g<-ggplot(st2,aes(x=interval,y=steps))
g+geom_line()+facet_grid(weekdays~.)

