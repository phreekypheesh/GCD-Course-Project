# Data:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# Merges the training and the test sets to create one data set.
library(dplyr)
wd <- "C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera"
setwd(wd)

x_test_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/test/X_test.txt")
y_test_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/test/y_test.txt")
subject_test_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/test/subject_test.txt")
x_train_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/train/X_train.txt")
y_train_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/train/y_train.txt")
subject_train_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/train/subject_train.txt")

features_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/features.txt")
colnames(x_test_file) <- features_file[,2]
colnames(x_train_file) <- features_file[,2]




test_df <- cbind(subject_test_file, y_test_file)
colnames(test_df) <- c("Subject","y")
test_df <- cbind(test_df , x_test_file)
test_df$Trial <- "test"
head(test_df)
melt_test <- melt(test_df, id = c("Subject","y", "Trial"))
colnames(melt_test) <- c("Subject","y", "Trial", "variable", "value")
head(melt_test)


train_df <- cbind(subject_train_file, y_train_file)
colnames(train_df) <- c("Subject","y")
train_df <- cbind(train_df , x_train_file)
train_df$Trial <- "train"
head(train_df)
melt_train <- melt(train_df, id = c("Subject","y", "Trial"))
colnames(melt_train) <- c("Subject","y", "Trial", "variable", "value")
head(melt_train)



whole_df <- rbind(melt_train, melt_test)
label_file <- read.table("C:/Users/LindseyBehrens/OneDrive - Genective/Documents/R Working/Coursera/UCI HAR Dataset/activity_labels.txt")
colnames(label_file) <- c("y","Activity_Labels")
label_file
whole_df <- merge(whole_df, label_file, by= c("y"))
whole_df <- whole_df[,c(2,3,4,5,6)]
head(whole_df)
write.table(whole_df, "whole_df.txt")


#############################################################################################################################################################
#############################################################################################################################################################
# Extracts only the measurements on the mean() and std() for each measurement. 
head(whole_df)

Vars <- unique(whole_df$variable)
take <- c("mean()", "std()")
List <- list()
for (Name in Vars) {
  search <- sapply(take, grepl, Name)
  if (TRUE %in% search) {
    List <- append(List,Name)
  }
}
List

Mean_SD_df <- subset(whole_df, variable %in% List)
head(Mean_SD_df)

write.table(Mean_SD_df, "Mean_SD_df.txt")



#############################################################################################################################################################
#############################################################################################################################################################
# Uses descriptive activity names to name the activities in the data set



#See Activity_Labels Column. I used the activity_labels.txt file to apply labels
head(Mean_SD_df)
head(whole_df)









#############################################################################################################################################################
#############################################################################################################################################################
# Appropriately labels the data set with descriptive variable names. 



#See activity Column. I used the features.txt file to labels variables
head(Mean_SD_df)
head(whole_df)





#############################################################################################################################################################
#############################################################################################################################################################
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

head(Mean_SD_df)
head(whole_df)


Subs <- unique(whole_df$Subject)
Activities <- unique(whole_df$Activity_Labels)
Averages_List <- list()
temp_list <- list()
for (Sub in Subs) {
  set <- subset(whole_df, Subject = Sub)
  for( Act in Activities) {
    set2 <- subset(set,Activity_Labels = Act )
  mean <- set2 %>% group_by(set$variable) %>%  summarize(mean = mean(value))
  colnames(mean) <- c("variable", "mean")
  mean$Subject <- Sub
  mean$Activity_Labels <- Act
  Averages_List <- rbind(Averages_List, mean)
  }
}
head(Averages_List)

write.table(Averages_List, "Averages.txt")




