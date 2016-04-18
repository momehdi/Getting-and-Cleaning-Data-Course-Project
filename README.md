# Getting-and-Cleaning-Data-Course-Project

The run_analysis.R script downloads accelerometers data from the Samsung Galaxy S smartphone available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Afterwards, the scripts proceeds with the following:
- Loading the labels and features
- Renaming the features that contain the words "mean" and "std" by removing the dashes and parentheses
- Loading the training and test sets.
- Slicing the resulting data frames to include the mean and std variable only.
- Merging the training and the test sets to create one data set.
- Creating a molt data frame from the merged data by stacking all mean and std variables into one column
- Dumping a tidy data into "tidy.txt" set with the average of each variable for each activity and each subject.
