##Creating working directory, if non-existent
if(!file.exists("getting_and_cleaning_data_project")){
	dir.create("getting_and_cleaning_data_project")
}

##Sets working directory
setwd(".\\getting_and_cleaning_data_project")

##Downloads data set from the given URL, stores it as data.zip, saves the download date and unzips the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data.zip")
dateDownloaded <- date()
unzip("data.zip")

##Reads the training data, activity labels and subject labels and combines them in "train" dataframe
x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt",stringsAsFactors = FALSE)
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt",stringsAsFactors = FALSE)
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",stringsAsFactors = FALSE)
train <- cbind(subject_train, y_train, x_train)

##Reads the test data, activity labels and subject labels and combines them in "test" dataframe
x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",stringsAsFactors = FALSE)
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt",stringsAsFactors = FALSE)
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",stringsAsFactors = FALSE)
test <- cbind(subject_test, y_test, x_test)

##Merges training and test data
complete_data <- rbind(train, test)
colnames(complete_data)[1:2] <- c("subject","activity_label")

##Reads feature variable labels
features <- read.table(".\\UCI HAR Dataset\\features.txt",stringsAsFactors = FALSE)

##Identifying which variable names are for mean and standard deviation only
std_variables <- grep("std",features[,2])
mean_variables <- grep("mean",features[,2])
mean_and_std_variables <- sort(c(std_variables,mean_variables))

##Extracting only the measurements on the mean and standard deviation for each measurement
library(dplyr)
complete_data <- tbl_df(complete_data)
mean_std_data <- complete_data %>% select(subject, activity_label, num_range("V",mean_and_std_variables))

##Naming the activities in the dataset
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",stringsAsFactors = FALSE)
colnames(activity_labels) <- c("activity_label","activity_name")
mean_std_data_activity_names <- merge(mean_std_data, activity_labels, by.x = "activity_label", by.y = "activity_label", all = TRUE)
mean_std_data_activity_names <- mean_std_data_activity_names %>% select(subject, activity_label, activity_name, num_range("V",mean_and_std_variables))

##Labelling the data set with descriptive variable names
mean_std_data_final <- mean_std_data_activity_names
colnames(mean_std_data_final) <- c("subject","activity_label","activity_name",features[,2][mean_and_std_variables])

##Tidy data set with the average of each variable for each activity and each subject
mean_all_selected_variables <- mean_std_data_final %>% group_by(subject, activity_name) %>% summarise_all(funs(mean))
