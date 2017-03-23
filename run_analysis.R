library(dplyr)
library(data.table)

## After unzipping the file into working directory, read the training and test dataset

x_train <- fread("UCI HAR Dataset/train/X_train.txt")
y_train <- fread("UCI HAR Dataset/train/y_train.txt")
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt")

train <- cbind(subject_train, y_train, x_train)

x_test <- fread("UCI HAR Dataset/test/X_test.txt")
y_test <- fread("UCI HAR Dataset/test/y_test.txt")
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(subject_test, y_test, x_test)

## merge training and test set

fullset <- rbind(train, test)

## read the features data

features <- fread("UCI HAR Dataset/features.txt")

## get index for features with mean and standard deviation
index_subfeatures <- grep("-(mean|std)\\(\\)", features$V2)

## name the first two columns of the fullset
names(fullset)[1] <- "subject"
names(fullset)[2] <- "activity"

## read the activity labels data
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
names(activity_labels)[1] <- "activity"

## check number of columns in full set
ncol(fullset)

## use descriptive activity name to name the activities in the dataset
fullset$activity <- merge(fullset, activity_labels, by = "activity")[,564]


## select only features with mean and standard deviation

fullset <- select(fullset, subject, activity, index_subfeatures + 2)

## check number of columns for full set 
ncol(fullset)

## There are 66 features which starts from column 3. Now name the variables with the correct features

names(fullset)[3:68] <- features$V2[index_subfeatures]

## Some amendments on the variable names
names(fullset) <- gsub("mean\\(\\)", "mean", names(fullset))
names(fullset) <- gsub("std\\(\\)", "std", names(fullset))

## Creates second dataset with average of each variable for each activity and each subject

secondset <- fullset %>% group_by(subject, activity) %>% summarise_each(funs(mean))


