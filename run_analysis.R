###############################################################
## Getting and Cleaning Data Course Project 2
## Oct 25, 2014
###############################################################
## This R script
## 1.Merges the training and the test sets to create one data set
## 2.Extracts only the measurements on the mean and standard deviation for each measurement
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# setting my working directory
setwd("C:/Users/Firew/Desktop/coursera/DataCleaning")

# the data for the project path
path <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# if the file does not exist dwonload it and unzip it
# when unzipped it creates UCI HAR Dataset dir with the requred files
if (!file.exists("UCI HAR Dataset")){
download.file(path, destfile = 'project2_data.zip')
unzip ('project2_data.zip') }

# reading the train data set with the subject id
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

# cobinning all the training data set into single data frame
train_data <- cbind(x_train,y_train,subject_train)

# reading the test data set with the subject id
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# cobinning all the test data set into single data frame
test_data <- cbind(x_test,y_test,subject_test)

# row bindding the training and the test sets to create single data set
AllData <- rbind(test_data,train_data)

# reading the column names
features <- read.table("./UCI HAR Dataset/features.txt",as.is=TRUE)

# assigning activity_num for y_train/test and subject_num for subject_train/test columns
ColNm <- c(features[,2],'activity_num','subject_num')
# setting the column names for the merged data
colnames(AllData) <- ColNm

# extracting only measurements on the mean and standard deviation and assign it to a new data set
# I am also searching for _num to include subject_num and activity_num
# because that is what I called the subject and the activity
mean_std_col <- grep("mean|std|_num", colnames(AllData))
measurements <- AllData[,mean_std_col]

# reading the actual activity names (descriptive names) to replace the activity_num (which is number) 
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",as.is=TRUE)
measurements$activity_num <- factor(measurements$activity_num,levels=activities[,1],labels=activities[,2])

# need package called dplyr to use the group_by and summarise_each functions
#install.packages("dplyr") if not installed
if (!require("dplyr")) {install.packages("dplyr")}
library(dplyr)

# convrt subject_num to factor
measurements$subject_num <- as.factor(measurements$subject_num)

# group the subject_num and activity_num
measurements <- group_by(measurements,subject_num,activity_num)

# avaraging all the variables in measurements data set and assigning it to tidy_data
tidy_data <- summarise_each(measurements,funs(mean))

# changing activity_num to activity_list as it is no longer a number
colnames(tidy_data)<-gsub("activity_num","activity_list",colnames(tidy_data))

#writting tidy_data.txt data
write.table(tidy_data,"tidy_data.txt",row.name=FALSE )
