README

Course: Getting and Cleaning Data Course Project 2

The data set used for this project is a recording of 30 subjects performing 6 activities while carrying a smart phone with embedded sensors.

The full description can be found at the following URL

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
The run_analysis.R script performs the following:

High level:

1 - Merges the training and the test sets to create one data set

2 - Extracts only the measurements on the mean and standard deviation for each measurement

3 - Uses descriptive activity names to name the activities in the data set

4 - Appropriately labels the data set with descriptive variable names

5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Detail as commented in the script:

1.	Setup the working directory

2.	If the file does not exist download and unzip it in the working directory from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

3.	Read the training data set including the subject into x_train, y_train and subject_train

4.	Combine all the training data set into single data frame called train_data

5.	Read the test data set including the subject into x_test, y_test and subject_test

6.	Combine all the test data set into single data frame called test_data

7.	Merge the training &  test data set into AllData from step 4 & 6 above

8.	Read the column names from features.txt file

9.	Assign column names activity_num & subject_num  for y_train/test & subject_train/test columns respectively (if not it will have the default name V1 ..)

10.	Set or assign the column names for the merged data on step 7 above. 

11.	Extract the measurements on the mean, standard deviation, _num and assign it to a new data set called measurements. 
	I am also searching for _num to include subject_num and activity_num because that is what I called the subject and the activity at step 9 above
	
12.	Read the actual activity names (descriptive names) from activity_labels.txt to replace the activity_num (which is number)

13.	If package dplyr does not exist then install it (need this to use the group_by and summarise_each functions)

14.	Convert subject_num to factor

15.	Group the subject_num and activity_num

16.	Average all the variables in measurements data set and assigning it to tidy_data

17.	Change activity_num to activity_list as it is no longer a number now

18.	Finally writing tidy_data.txt data
