Peer-graded Assignment: Getting and Cleaning Data Course Project

Submitted by: Gawin Stoll 
Purpose: analysis on Human Activity recognition dataset, submission for Getting and Cleaning Data course project.

Contents:
ReadMe.txt
Codebook.md
run_analysis.R
tidy_data.txt

CodeBook.md - A code book describing dataset information, description of abbreviations of measurements and features

run_analysis.R - Annotated R code to analyse the Human Activity recognition dataset in order to perform data preparation according to the course project’s description:
   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set.
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data.txt - The tidy_data table is the exported file resulting from the run_analysis.R  script. It has a set of variables for each activity and each subject. It contains 180 obs. of 88 variables. Opened in R using the following code:
data <- read.table("tidy_data.txt", header = TRUE) 
View(data)

