GettingAndCleaningData_Proj1
============================

### Data Source

The data for this analysis was downloaded from  UCI Machine Learning Repository ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Source Data Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Transformations
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#### Step 1 - Merges the training and the test sets to create one data set.
From the downloaded data the following files are read into memory
1. features.txt
2. activity_labels.txt
3. subject_train.txt
4. subject_test.txt
5. x_train.txt
6. x_test.txt
7. y_train.txt
8. y_test.txt

Column names and data sets were merged to create a final data set called `final Data`

#### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
The activityId, SubjectId, and all the columns containing the mean and standard deviation are extracted using the grep command. The subsetted data only contains these columns.

#### Step 3 - Uses descriptive activity names to name the activities in the data set
The Activity Type is extracted from the activity_labels data set that was read in and the numeric values are replaced with textual ones that are easier to read in the `final data` data set.

#### Step 4 - Appropriately labels the data set with descriptive variable names. 
The gsub function is used to clean up the column names.   
1. The `()` is removed from all the column names.   
2. The `t` and `f` letters at the begining of the column name are replaced with `time` and `frequency` respectively.  
3. The `std` and `mean` monikers in the column names are replaced with `StdDev` and `Mean`.  
4. The `mag` moniker in the column names are replaced with the full formn - `Magnitude`.  
5. `BodyBody` appears twice in a column name. It is replace with just `Body`.  

#### Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Data is aggregated by subjectId and ActivityId into a tidy data set that is written to disk in a file called `tidyDataSet.txt`