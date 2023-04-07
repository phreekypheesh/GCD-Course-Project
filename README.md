# GCD-Course-Project

Data was retireved from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Folder was unzipped and placed in my working directory. 


X, y, and subject files for test and training data were read in.
X_train and X_test colmns were renamed using the features.txt file to give more descriptive column names. (for example, "tBodyAcc-mean()-X" rather than V1"

All three 'test' files were combined (cbind), and then all three 'train' files were combined. 
The files were 'melted' to produce files that have the columns "Subject","y", "Trial", "activity", and "value"
The test and train files were then merged into one data set.

The file activity_labels.txt was added to the data set to add more descriptive terms than the y column (for example, WALKING rather than '1')

This produced a tidy data set with the following columns:
'Subject' - ID Number of the paricipant (1-30)
'Trial' - Training or Test depending on the source file of the data
'variable' - Description of the measurement taken (i.e. "fBodyGyro-max()-X", "tBodyAcc-energy()-Z", etc)
'value'- numerical measurement of the activity
'Activity_Labels' - Descriptions of the activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS SITTING, STANDING, LAYING)



Next, a data file containing only the mean and standard errors was made by selecting rows of the data set based on the 'activity' column. 



Finally, a second data set was created that contains the average of each variable for each activity and each subject.
The Columns of this data set are 
'variable' - Description of the measurement taken (i.e. "fBodyGyro-max()-X", "tBodyAcc-energy()-Z", etc)
'mean'- average of the variable values
'Subject' - ID Number of the paricipant (1-30)
'Activity_Labels' - Descriptions of the activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS SITTING, STANDING, LAYING)
