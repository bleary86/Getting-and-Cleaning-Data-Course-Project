## Coursera Getting and Cleaning Data Course Project
## Brendan Leary
## 2017-05-01


# Download the below dataset: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# This script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject. 


# 1. Merges the training and the test sets to create one data set.

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("C://Users//bleary//Documents//CourseraAssignments//Getting-and-Cleansing-Data//UCI HAR Dataset");

# Read in the data
features     = read.table('./features.txt',header=FALSE); #imports features.txt
activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt

# Assigin column names to the data imported
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

# Megre the data sets
trainingData = cbind(yTrain,subjectTrain,xTrain);

# Read in the test data
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

# Assign column names to the test data
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";


# Create the final test set by merging the data sets
testData = cbind(yTest,subjectTest,xTest);


# Combine dat sets to create a final data set
finalData = rbind(trainingData,testData);

# Create a vector for the column names
colNames  = colnames(finalData); 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() to filter
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames)
                 & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames)
                 & !grepl("-std()..-",colNames));

# Subset data based on only columns to keep
finalData = finalData[logicalVector==TRUE];

# 3. Uses descriptive activity names to name the activities in the data set

# Merge the data sets to include descriptive activity names
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Updating to include the new column names
colNames  = colnames(finalData); 

# 4. Appropriately labels the data set with descriptive variable names.

# Appropriately labeling variable names
for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("\\()","",colNames[i])
        colNames[i] = gsub("-std$","StdDev",colNames[i])
        colNames[i] = gsub("-mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","Time",colNames[i])
        colNames[i] = gsub("^(f)","Freq",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
        colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
        colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
        colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
        colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Updating names to the finalData set
colnames(finalData) = colNames;

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject. 

# Create a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];

# Changing finalDataNoActivityType table to include just the desired data
tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],
                        by=list(activityId=finalDataNoActivityType$activityId,
                                subjectId = finalDataNoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive activity names
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Creating secdonf independent tidy data set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');