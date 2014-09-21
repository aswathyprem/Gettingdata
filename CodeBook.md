# Introduction

The script run_analysis.R  does the following. 
 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement. 
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive variable names. 
 - From the above data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 # run_analysis.R

The script is parititioned into functions such that each function performs one of the
steps described above. To run whole cleaning procedure, call `clean.data`
function. The script also assumes that `plyr` library is already installed.

# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition is also split into three files that contain
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject

# Getting and cleaning data

If the data is not already available in the `data` directory, it is downloaded
from UCI repository.

The first step of the preprocessing is to merge the training and test
sets. Two sets combined, there are 10,299 instances where each
instance contains 561 features (560 measurements and subject identifier). After
the merge operation the resulting data, the table contains 562 columns (560
measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted
for further processing. Out of 560 measurement features, 33 mean and 33 standard
deviations features are extracted, yielding a data frame with 68 features
(additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 66 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 66 columns.
The tidy data set is exported to `UCI_HAR_tidy.txt` where the first row is the
header containing the names for each column.

#Variables in tidy data set.

subject 	- An identifier of the subject who carried out the experiment
activity 	- Activities performed by wearing the smart phone on the wrist

Mean and standard deviations derived from the main dataset. 

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z

tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z

tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z

tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z

tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z

tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z

tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z

tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z

tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z

tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z

tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()

fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z

fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z

fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y	
fBodyAccJerk-mean()-Z
	
fBodyAccJerk-std()-X	
fBodyAccJerk-std()-Y	
fBodyAccJerk-std()-Z
	
fBodyGyro-mean()-X	
fBodyGyro-mean()-Y	
fBodyGyro-mean()-Z
	
fBodyGyro-std()-X	
fBodyGyro-std()-Y	
fBodyGyro-std()-Z
	
fBodyAccMag-mean()	
fBodyAccMag-std()	



