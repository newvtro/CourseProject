# Hi there. English isn't my mother language so I hope you can understand me
# First we are going to download the Dataset for the project. This may take a while...
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
# Download complete. Now we are going to import the data"
features<-read.table(unz(temp,"UCI HAR Dataset/features.txt")  , quote="\"")
subject_train<-read.table(unz(temp,"UCI HAR Dataset/train/subject_train.txt")  , quote="\"")
X_train<-read.table(unz(temp,"UCI HAR Dataset/train/X_train.txt")  , quote="\"")
y_train<-read.table(unz(temp,"UCI HAR Dataset/train/y_train.txt")  , quote="\"")
subject_test<-read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt")  , quote="\"")
X_test<-read.table(unz(temp,"UCI HAR Dataset/test/X_test.txt")  , quote="\"")
y_test<-read.table(unz(temp,"UCI HAR Dataset/test/y_test.txt")  , quote="\"")
activity_labels<-read.table(unz(temp,"UCI HAR Dataset/activity_labels.txt")  , quote="\"")
unlink(temp)
# First step (Merges the training and the test sets to create one data set)
test<-cbind(subject_test, y_test, X_test)
train<-cbind(subject_train, y_train, X_train)
dataset<-rbind(test,train)
# First step accomplished
#Now we can delete some data.frames
rm(X_test)
rm(X_train)
rm(y_test)
rm(y_train)
rm(subject_test)
rm(subject_train)
rm(test)
rm(train)

# Second step (Extracts only the measurements on the mean and standard deviation for each measurement)
lista<-as.character(features[,2])
index <- grep("mean\\(\\)|std\\(\\)", lista, value=FALSE)
lista<- grep("mean\\(\\)|std\\(\\)", lista, value=TRUE)
dataset<-dataset[,c(1:2,index+2)]
# Second step accomplished

# Third step (Uses descriptive activity names to name the activities in the data set)
dataset$V1.1<-as.factor(dataset$V1.1)
levels(dataset$V1.1)<-as.character(activity_labels[,2])
# Third step accomplished

# Fourth step (Appropriately labels the data set with descriptive variable names)
colnames(dataset)<-c("subject","activity", lista)
# Fourth step accomplished

# Fifth step (Creates a second, independent tidy data set with the average of each variable for each activity and each subject)
nuevo<-dataset[0,]
row<-1
for (i in min(dataset$subject):max(dataset$subject))
{
  for(j in 1:length(levels(dataset$activity)))
  {
    nuevo[row,1]<-i
    nuevo[row,2]<-levels(dataset$activity)[j]
    for (k in 3:ncol(nuevo))
    {
      nuevo[row,k]<-mean(dataset[dataset$activity==nuevo[row,2] & dataset$subject==nuevo[row,1],k])
    }
    row<-row+1
  }
}
write.csv(nuevo, file = "TidyDataset.csv", row.names=FALSE)
# Fifth step accomplished
#output
nuevo
