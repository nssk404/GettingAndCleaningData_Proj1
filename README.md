GettingAndCleaningData_Proj1
============================

Course Project for Getting and Cleaning Data

### Overview
The code in this repo collects the data from the UCI Machine Learning Repository and cleans it up to provide a tidy data set that is ready for anaylsis. The data can be found from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### What was done in the cleanup 

The run_analysis.R script does the following things.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Running the Script
The R Script will download the data in the current directory to a data.zip file. Unzip the file and read the data from there.

### Additional Information
Additional information about the variables, data and transformations in the CodeBook.MD file.