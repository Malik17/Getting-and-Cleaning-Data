## Course Project Code Book

Source of the original https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following to clean up the data:

Merges the training and test sets to create one data set

Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. 

Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

The script also appropriately labels the data set with descriptive names

Finally, the script creates an independent tidy data set with the average of each measurement for each activity and each subject. The result is a data frame, where the first column contains subject IDs, the second column contains activity names, and then the averages for each of the 66 attributes.
