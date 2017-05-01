# Run_Analysis - Tidy Data Set

### Data Sets
The run_analysis script takes in the following text data sets:

* features
* activity_labels
* subject_train
* x_train
* y_train

### Merge data

The x_train and y_train data sets are then merged. A new data set is then create with only retains the variables containing mean and standard deviation.


### Data has been grouped by subject and activity group.

### The tidy data contains 180 rows and 21 column.
1. activityId	
2. subjectId	
3. TimeBodyAccMagnitudeMean	
4. TimeBodyAccMagnitudeStdDev	
5. TimeGravityAccMagnitudeMean	
6. TimeGravityAccMagnitudeStdDev	
7. TimeBodyAccJerkMagnitudeMean	
8. TimeBodyAccJerkMagnitudeStdDev	
9. TimeBodyGyroMagnitudeMean	
10. TimeBodyGyroMagnitudeStdDev	
11. TimeBodyGyroJerkMagnitudeMean	
12. TimeBodyGyroJerkMagnitudeStdDev	
13. FreqBodyAccMagnitudeMean	
14. FreqBodyAccMagnitudeStdDev	
15. FreqBodyAccJerkMagnitudeMean	
16. FreqBodyAccJerkMagnitudeStdDev	
17. FreqBodyGyroMagnitudeMean	
18. FreqBodyGyroMagnitudeStdDev	
19. FreqBodyGyroJerkMagnitudeMean	
20. FreqBodyGyroJerkMagnitudeStdDev	
21. activityType

### variable units
Activity variable is factor type.
Subject variable is integer type.
All the other variables are numeric type.
