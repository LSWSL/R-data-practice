##read the data file by choosing the file in the open window
x_train_data<-read.table(file.choose())
y_train_data<-read.table(file.choose())
subject_train_data<-read.table(file.choose())
x_test_data<-read.table(file.choose())
y_test_data<-read.table(file.choose())
subject_test_data<-read.table(file.choose())


##1.Merges the training and the test sets to create one data set.
subject_data<-rbind(subject_train_data,subject_test_data)
x_data<-rbind(x_train_data,x_test_data)
y_data<-rbind(y_train_data,y_test_data)
data<-cbind(x_data,y_data,subject_data)

##2.Extracts only the measurements on the mean and standard deviation 
##for each measureme

#read the file 'features.txt' to find the item which includ pattern 'mean'
features<-read.table(file.choose())
#extracts the measuremnts on the mean
mdata<-data[,grep(pattern = 'mean',features[[2]])]
#calculating standard deviation for each measurements
std_data_mean<-sapply(mdata,sd)

##3.Uses descriptive activity names to name the activities in the data set

#get activity_labels
activity_labels<-read.table(file.choose())
#rename the colums
colnames(data)[dim(data)[2]-1]<-'activity'
colnames(data)[dim(data)[2]]<-'subject'
#use activity names rename the data
data<-mutate(data,activity=activity_labels[activity,2])

##4.Appropriately labels the data set with descriptive variable names.

#add number to avoid using duplicate names
xdataname<-paste(features[,1],features[,2],sep = '.')
colnames(data)[1:561]<-xdataname

##5.From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
data<-group_by(data,activity,subject)
my_tidy_data<-summarise_each(data,mean)
