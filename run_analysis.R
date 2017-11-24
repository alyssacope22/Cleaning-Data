## Dowloading and Unzipping Dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

path_rf <- file.path("./data" , "UCI HAR Dataset")

## Step 1: Merge  the training and  test sets to create one data set

require(plyr)

xtrain<-read.table(file.path(path_rf,"train","X_train.txt"),
                   header = FALSE)
ytrain<-read.table(file.path(path_rf,"train","Y_train.txt" ),
                   header = FALSE)
sub_train<-read.table(file.path(path_rf,"train","subject_train.txt" ),
                      header = FALSE)

xtest<-read.table(file.path(path_rf,"test","X_test.txt"),
                  header = FALSE)
ytest<-read.table(file.path(path_rf,"test","Y_test.txt"),
                  header = FALSE)
sub_test<-read.table(file.path(path_rf,"test","subject_test.txt" ),
                     header = FALSE)

# Create X data set
xdata<-rbind(xtrain,xtest)

# Create Y data set
ydata<-rbind(ytrain,ytest)

# Create subject data set
subdata<-rbind(sub_train,sub_test)


#######################################################################

## Step 2: Further Merge and Give Names to Variables
names(subdata)<-c("subject")
names(ydata)<-c("activity")

xfeats<-read.table(file.path(path_rf,"features.txt"),head=F)
names(xdata)<-xfeats$V2

combine<-cbind(subdata,ydata)
data<-cbind(xdata,combine)

########################################################################

## Step 3: Extracts mean and std for each measurement

subfeat<-xfeats$V2[grep("mean\\(\\)|std\\(\\)",xfeats$V2)]

# subset the data frame

subnames<-c(as.character(subfeat),"subject","activity")
data<-subset(data,select=subnames)

str(data)

#########################################################################

## Step 4: Use descriptive activity names for activities data set

activitylabels<-read.table(file.path(path_rf,"activity_labels.txt"),
                           header=F)

data$activity<-factor(data$activity,levels=activitylabels[,1],
                      labels=activitylabels[,2])
data$subject<-as.factor(data$subject)

#########################################################################

## Step 5: Melt data, add labels, and write table

require(reshape2)

data.melt<-melt(data,id=c("subject","activity"))
data.mean<-dcast(data.melt,subject+activity~variable,mean)

View(data.mean)

write.table(data.mean,"tidy.txt",row.names=F,quote=F)
