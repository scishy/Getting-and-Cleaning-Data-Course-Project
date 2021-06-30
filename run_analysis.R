
#Data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
#full description of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(data.table)
library(dplyr)

#Download and unzip data
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl, destfile = "./data/Dataset.zip")

#unzip files from Dataset
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#2. Read appropriate data files and create data tables

#test data
test_set_x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
test_set_y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

#train data
train_set_x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
train_set_y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

#features and activity labels
features <- read.table("data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")


#change column names of test_set_x and train_set_x to labels in features column 2
colnames(test_set_x) <- features[ , 2]
colnames(train_set_x) <- features[ , 2]


#change column name for test_set_y and train_set_y to activity_id
colnames(test_set_y) <- "activity_id"
colnames(train_set_y) <- "activity_id"

#add column names for subject id's
colnames(subject_test) <- "subject_id"
colnames(subject_train) <- "subject_id"

#add column names to activity_labels
colnames(activity_labels) <- c("activity_id", "activity")

#merging test and train data tables into one
test_data <- cbind(test_set_y, subject_test, test_set_x)
train_data <- cbind(train_set_y, subject_train, train_set_x )
test_and_train <- rbind(test_data, train_data)

#Extract only measurements of mean and standard deviation 
mean_std <- test_and_train %>%
  select(contains(c("activity_id", "subject_id", "mean", "std")))

#add descriptive activity names
test_and_train_mean_std_labeled <- merge(test_and_train_mean_std, activity_labels, by = "activity_id", all.x = TRUE)

#reorder columns
test_and_train_DT <- test_and_train_mean_std_labeled[c(2, 1, 82, 3:81)]%>%
  arrange(subject_id) %>% #update to arrange by subject_id
  data.table()

View(test_and_train_DT)

#create new data table containing average of each variable for each activity 
#select applicable rows and calculate means
mean_activity <- test_and_train_DT %>%  
  select(-contains(c("std", "activity_id"))) %>% 
  group_by(subject_id, activity) %>% summarize_all(funs(mean))

View(mean_activity)

#export to text file
write.table(mean_activity, "./mean_activity.txt", row.names = FALSE)