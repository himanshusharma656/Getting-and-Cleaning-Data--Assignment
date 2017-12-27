#########################Loading Data set############################################
features=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/features.txt",header = F,sep=' ',colClasses = c("integer","character"))[,2]
activity=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/activity_labels.txt",header = F,sep=' ',colClasses = c("integer","character"),col.names = c("Label","activity"))

#Load Train Data
subject_train=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/train/subject_train.txt",sep = '\t',header = F,col.names = "subject")
x_train=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/train/X_train.txt",sep = '',header = F)
names(x_train)=features
y_train=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/train/y_train.txt",sep = '',header = F,col.names = "Label")
#################

###Load Additional Data

names=list.files("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/train/Inertial Signals")
names_2=unlist(strsplit(names,"_train.txt"))
names_3=unlist(strsplit(names,".txt"))

for(i in 1:length(names))
{
  a=read.csv(names[i],sep="",header = F)
  names(a)=paste(names_2[i],1:128,sep="")
  assign(names_3[i],a)
}
#####################

#Load Test Data
subject_test=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/test/subject_test.txt",sep = '\t',header = F,col.names = "subject")
x_test=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/test/X_test.txt",sep = '',header = F)
names(x_test)=features
y_test=read.csv("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/test/y_test.txt",sep = '',header = F,col.names = "Label")
###############

####Load Test Data
names=list.files("C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/test/Inertial Signals")
names_2=unlist(strsplit(names,"_test.txt"))
names_3=unlist(strsplit(names,".txt"))

for(i in 1:length(names))
{
  a=read.csv(names[i],sep="",header = F)
  names(a)=paste(names_2[i],1:128,sep="")
  assign(names_3[i],a)
}
###################
#########################################################################################

###########################Merge All the data sets#################################################
list=ls()

#############################Train########################################################
train=y_train
for(i in sort(list[grep("_train",list)],decreasing = T)[-1])
{
  train=data.frame(train,get(i))
}
#train=merge(train,activity,by="Label")
########################################################################################

#############################Test########################################################
test=y_test
for(i in sort(list[grep("_test",list)],decreasing = T)[-1])
{
  test=data.frame(test,get(i))
}
#test=merge(test,activity,by="Label")
########################################################################################


#Merges the training and the test sets to create one data set.
##########################################Merge Both dataset###########################
dataset=rbind(train,test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std=grep("mean|std",tolower(names(dataset)))
names(dataset)[mean_std]

mean_std_data=dataset[,mean_std]


#3.Uses descriptive activity names to name the activities in the data set

dataset2=merge(dataset,activity,by="Label")

#4.Appropriately labels the data set with descriptive variable names. 

#Columns are named with their descriptive names just after reading or while reading a file

#5.creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.

aggregated=dataset2%>%select(-Label)%>%group_by(activity,subject)%>%summarise_all(mean)


#Write
write.table(aggregated,"C:/Users/himanshu.sharma/Desktop/TALL ka goal/UCI HAR Dataset/tidy dataset.txt",row.names = F)



