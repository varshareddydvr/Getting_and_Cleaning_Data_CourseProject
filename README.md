Getting and Cleaning Data Course Project:
=========================================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The run_analysis.R script performs the following operations:
============================================================

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps required to run the script:
=================================

1. Download the data source, unzipping it and moving it to your local drive. UCI HAR Dataset is the unzipped folder.
2. Place run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
3. run_analysis.R file will install/load the required packages(reshape2 and data.table) automatically.
4. When we run source("run_analysis.R"), then it will generate a new file tidy_data.txt in your working directory.
