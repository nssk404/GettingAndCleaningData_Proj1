#--------------------------------------------------------------------------------------------------------------------------
#
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
#--------------------------------------------------------------------------------------------------------------------------

# Download the data into a folder called data in the current Directory. Download the data and unzip it
dir.create("data", showWarnings = FALSE)
setwd("data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")

# set the working directory to the unzipped data folder
setwd("UCI HAR Dataset")

# Read data 
features <- read.table('./features.txt',header=FALSE)
activityLabels <- read.table('./activity_labels.txt',header=FALSE)

subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)
subjectTest <- read.table('./test/subject_test.txt',header=FALSE)

xTrain <- read.table('./train/x_train.txt',header=FALSE)
xTest <- read.table('./test/x_test.txt',header=FALSE) 

yTrain <- read.table('./train/y_train.txt',header=FALSE)
yTest <- read.table('./test/y_test.txt',header=FALSE)


# Assigin column names to the data imported above
colnames(activityLabels) <- c('activityId','activityLabels')
colnames(subjectTrain) <-  colnames(subjectTest) <- "subjectId"

colnames(xTrain) <- colnames(xTest) <- features[,2]
colnames(yTrain) <- colnames(yTest) <- "activityId"

# 1. Merge the training and the test sets to create one data set.
trainingData <- cbind(yTrain, subjectTrain, xTrain)
testData <- cbind(yTest, subjectTest, xTest)
finalData = rbind(trainingData,testData);

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

columnNames <- colnames(finalData)

# pattern for columns To Extract
pat <- c("activity", "subject", "-mean()", "-std()")
satisfiesPattern <- sapply(pat, function(x) grepl(x, columnNames, ignore.case = F, fixed = T))
toExtract <- satisfiesPattern[,1] | satisfiesPattern[,2] | satisfiesPattern[,3] | satisfiesPattern[,4]

containsAxis <- grepl("-X", columnNames) | grepl("-Y", columnNames) | grepl("-Z", columnNames)

finalData <- finalData[toExtract & !containsAxis]

# 3. Use descriptive activity names to name the activities in the data set
finalData$activityId <- sapply(finalData$activityId, function(x) activityLabels$activityLabels[x])

# 4. Appropriately label the data set with descriptive activity names. 
columnNames <- colnames(finalData)
columnNames <- gsub("\\()","", columnNames)          # remove ()
columnNames <- gsub("^(t)","time", columnNames)      # replace 't' at the begining of the var name with time
columnNames <- gsub("^(f)","frequency", columnNames) # replace 't' at the begining of the var name with time
columnNames <- gsub("-std$","StdDev", columnNames)   # replace '-std' with StdDev
columnNames <- gsub("-mean","Mean", columnNames)     # replace '-mean' with Mean
columnNames <- gsub("BodyBody","Body", columnNames)  # remove extra "Body" in columnNames
columnNames <- gsub("Mag","Magnitude", columnNames)  # replace Mag with Magnitude

colnames(finalData) <- columnNames 

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidyDataSet <- aggregate(
                finalData[,c(3:ncol(finalData))], # exclude the activityId and subjectId    
                by = list(activityId = finalData$activityId, subjectId = finalData$subjectId),
                mean
                )
# Export the tidyData set 
write.table(tidyDataSet, 'tidyDataSet.txt', row.names=TRUE, sep='\t');
