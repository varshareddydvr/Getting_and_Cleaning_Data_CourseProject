
# installing or loading the required packages to run the script
if (!require("reshape2")) {
  install.packages("reshape2")
}

if (!require("data.table")) {
  install.packages("data.table")
}

require("data.table")
require("reshape2")

##zip file is downloaded, saved under working directory and unzipped
# Loading activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# Loading column names of data 
features <- read.table("UCI HAR Dataset/features.txt")[,2]

# Extracting only the measurements on the mean and standard deviation for each measurement
extract_features <- grepl("mean\\(\\)|std\\(\\)", features)

# Load and process X_train & y_train data.
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

names(Xtrain) <- features

# Load and process test data.
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

names(Xtest) <- features

# Extract only the measurements on the mean and standard deviation for each measurement.
Xtrain <- Xtrain[,extract_features]
Xtest <- Xtest[,extract_features]

# Using descriptive activity names to name the activities in the data set
Ytrain[,2] <- activity_labels[Ytrain[,1]]
Ytest[,2] <- activity_labels[Ytest[,1]]

# Appropriately labeling the data set with descriptive variable names.
names(Ytrain) <- c("ActivityID", "ActivityLabel")
names(SubjectTrain) <- "Subject"
names(Ytest) <- c("ActivityID", "ActivityLabel")
names(SubjectTest) <- "Subject"

# Bind data
train_data <- cbind(as.data.table(SubjectTrain), Ytrain, Xtrain)
test_data <- cbind(as.data.table(SubjectTest), Ytest, Xtest)

# Merging the training and the test sets to create one data set.
data <- rbind(test_data, train_data)

# Melt the data into a form suitable for easy casting
labels   = c("Subject", "ActivityID", "ActivityLabel")
data_labels = setdiff(colnames(data), labels)
melt_data      = melt(data, id = labels, measure.vars = data_labels)

# From the tidy data set, creating a data set with the average of each variable for each activity and each subject
tidy_data   <- dcast(melt_data, Subject + ActivityLabel ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
