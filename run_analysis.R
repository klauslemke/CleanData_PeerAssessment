# Set working directory to UCI HAR Dataset
# setwd("C:/COURSERA/Data Science II/UCI HAR Dataset")
## within this working directory are train and test folders
### within each of those folders is an Inertial Signals folder

# car package includes recode
library(car)

# Read the training and test set components
## subject_{set} lists the subject identifiers 
subject_train <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/train/subject_train.txt", quote="\"")
names(subject_train)[1] <- "subject_id"
subject_test <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/test/subject_test.txt", quote="\"")
names(subject_test)[1] <- "subject_id"

## X_{set} contains 561 features
X_train <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/test/X_test.txt", quote="\"")
## features contains the variable names
features <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/features.txt", quote="\"")
names(X_train) <- as.vector(t(features[2]))
names(X_test) <- as.vector(t(features[2]))

## y_{set} contains coded activities
y_train <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/train/y_train.txt", quote="\"")
names(y_train)[1] <- "activity_cd"
y_train$activity <- Recode(y_train$activity_cd, "1='WALKING'; 2='WALKING-UPSTAIRS'; 3='WALKING-DOWNSTAIRS'; 4='SITTING'; 5='STANDING'; 6='LAYING'")
y_test <- read.table("C:/COURSERA/Data Science II/UCI HAR Dataset/test/y_test.txt", quote="\"")
names(y_test)[1] <- "activity_cd"
y_test$activity <- Recode(y_test$activity_cd, "1='WALKING'; 2='WALKING-UPSTAIRS'; 3='WALKING-DOWNSTAIRS'; 4='SITTING'; 5='STANDING'; 6='LAYING'")

# Combine the components into complete sets 
activity_train <- cbind(subject_train, y_train, X_train)
activity_test <- cbind(subject_test, y_test, X_test)

# Merge the training and the test sets to create one data set
activity_data <- rbind(activity_train, activity_test)
# names(activity_data)

# Extract only the measurements on the mean and standard deviation for each measurement 
activity_measures <- activity_data[
    regexpr("subject", names(activity_data)) > 0 |
    regexpr("activity", names(activity_data)) > 0 |
    regexpr("mean", names(activity_data)) > 0 |
    regexpr("Mean", names(activity_data)) > 0 | 
    regexpr("std", names(activity_data)) > 0]
# names(activity_measures)

## Use descriptive activity names to name the activities in the data set
## Appropriately label the data set with descriptive activity names 

# Create a tidy data set with the average of each variable for each activity and each subject
summary(activity_measures)