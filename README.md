Coursera Getting and Cleaning Data Course Project

This repo contains two other files. 
1. run_analysis.R - This is the script which achieves the 5 objectives given in this project.
2. Codebook.md - Explains the data fields in the output file - "tidy_data.txt" uploaded on coursera.

This codebook shall seek to explain the following how my script achieves the 5 objectives listed in this course project.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Merges the training and the test sets to create one data set (lines 15 to 29 in the script)
The given dataset has 2 folders - test and train. Each contains three files, which together make up the complete dataset.
X_test/X_train - contains the measurements.
y_test/y_train - informs us about the activity label.
subject_test/subject_train - it is ID of each subject.
By combining these three data datasets we get the completed test and train datasets which I have merged together by rbind function.

"complete_data" dataframe is the required dataset of point 1.

2. Extracts only the measurements on the mean and standard deviation for each measurement (lines 31 to 42 in the script)
First, the script identifies the variables which contain either "mean" or "std" in their names - signifying they are measurements related to mean or standard deviation.
Second, post identifying their position, the script identifies those specific columns using "select" function of "dplyr" package.

"mean_std_data" dataframe is the required dataset of point 2.

3. Uses descriptive activity names to name the activities in the data set (lines 44 to 48 in the script)
Used the "merge" function.

"mean_std_data_activity_names" dataframe is the required dataset of point 3.

4. Appropriately labels the data set with descriptive variable names (lines 50 to 52 in the script)

"mean_std_data_final" dataframe is the required dataset of point 4.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Used "group_by" and "summarise_all" functions of "dplyr" package.

"mean_all_selected_variables" dataframe is the required dataset of point 5.
