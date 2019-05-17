#load packages
library(dplyr)

# download and unzip the data file

## file download variables 
fileName <- "UCI HAR Dataset.zip"
URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

## File download. Download to working directory, if nonexistent.
if(!file.exists(fileName)){
    download.file(URL,fileName, mode = "wb") 
}

## Unzip the downloaded file to directory, if nonexistent.
if(!file.exists(dir)){
    unzip("UCI HAR Dataset.zip", files = NULL, exdir=".")
}


# Read Data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("var_name", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "var_name")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "var_name")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# 1. Merges the training and the test sets to create one data set.
## combine the rows of x, of y and of subject datasets and combine the columns the three emerging datasets. 
data_merged_x <- rbind(x_train, x_test)
data_merged_y <- rbind(y_train, y_test)
data_merged_subject <- rbind(subject_train, subject_test)
data_merged <- cbind(data_merged_subject, data_merged_y, data_merged_x)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## use chain operation to select the mean and standard deviations of the activities
MeanStd <- data_merged %>% select(subject, var_name, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
## subset the activity column of MeanStd, re-name with activity_labels and apply to MeanStd.
MeanStd$var_name <- activity_labels[MeanStd$var_name, 2]

# 4. Appropriately labels the data set with descriptive variable names.
## using pattern matching and replacement, substitute "var_name" for "activity" and substitute the abbreviations.
names(MeanStd)[2] = "activity"
names(MeanStd)<-gsub("Acc", "Accelerometer", names(MeanStd))
names(MeanStd)<-gsub("angle", "Angle", names(MeanStd))
names(MeanStd)<-gsub("BodyBody", "Body", names(MeanStd))
names(MeanStd)<-gsub("gravity", "Gravity", names(MeanStd))
names(MeanStd)<-gsub("Gyro", "Gyroscope", names(MeanStd))
names(MeanStd)<-gsub("mag", "Magnitude", names(MeanStd))
names(MeanStd)<-gsub("^t", "Time", names(MeanStd))
names(MeanStd)<-gsub("^f", "Frequency", names(MeanStd))
names(MeanStd)<-gsub("mean()", "Mean", names(MeanStd), ignore.case = TRUE)
names(MeanStd)<-gsub("std()", "SD", names(MeanStd), ignore.case = TRUE)


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## create a new dataset "Data_Clean" by using chain operation that is grouped for each variable for each activity and each subject, while transforming to the mean
## write "Data_Clean" to a table called "tidy_data.txt"
Data_Clean <- MeanStd %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean))
write.table(Data_Clean, "tidy_data.txt", row.name=FALSE)
