JHU-data-science
================

Repository for R projects created for Coursera courses taken within the JHU Data Sciences program


Repository Files & Functionality
================================
run_analysis.r:  This is a stand-alone script created as a course project in the "Getting and Cleaning Data" course offered by JHU via Coursera.  The script assumes that the user has downloaded the target dataset into a "Data" subdirectory of the user's primary working directory and has unzipped and extracted the files.  The script performs the following tasks:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The data used in this exercise was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was obtained from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file CodeBook.md includes more detaile dinformation on the functioning of the script.
