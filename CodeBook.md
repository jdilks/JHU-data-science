Code Book for run_analysis.r
By Jason A. Dilks, 26/OCT/2014

Source Data
===========
The source data that is the target for this script is the "Human Activity Recognition Using Smartphones Dataset".  The data is provided in multiple space-delimited text files, divided up into testing and training subsets, requiring some minor cleanup prior to use in R.
Source attribution:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
activityrecognition@smartlab.ws
www.smartlab.ws


Variables & Transformations Executed at Creation
================================================

The following variables are created in the course of executing the script.  Below are brief descriptions of each variable.

activitylabels:  The numeric codes for the activities and text descriptions of each.  The frame is ingested with no changes from the source dataset.

features:  Text descriptions of each unique "feature", meaning each data element that is being observed in the study.  The frame is ingested with no changes from the source dataset.

subjecttest:  Integers signifying the experient subject associated with each observation recorded in the "test" subset.  The frame is ingested with no changes from the source dataset.

xtest:  Array of numeric values, with each column corresponding to each unique "feature" described above, and each row corresponding to a unique observation recorded in the "test" subset.  The frame is ingested with no changes from the source dataset.

ytest:  Integers signifying the activity the experiment subject was engaging in during each observation in the "test" subset.  The frame is ingested with no changes from the source dataset.

subjecttrain:  Integers signifying the experiment subject associated with each observation recorded in the "train" subset.  The frame is ingested with no changes from the source dataset.

xtrain:  Array of numeric values, with each column corresponding to each unique "feature" described above, and each row corresponding to a unique observation recorded in the "train" subset.  The frame is ingested with no changes from the source dataset.

ytrain:  Integers signifying the activity the experiment subject was engaging in during each observation in the "train" subset.  The frame is ingested with no changes from the source dataset.

subject:  A constructed data frame combining the subject observations from both the "test" (subjecttest) and "train" (subjecttrain) subsets.  The combination is executed using rbind() and does not transform the data in any other way.

x:  A constructed data frame combining the feature observations from both the "test" (xtest) and "train" (xtrain) subsets.  The combination is executed using rbind() and does not transform the data in any other way.

y:  A constructed data frame combining the activity observations from both the "test" (ytest) and "train" (ytrain) subsets.  The combination is executed using rbind() and does not transform the data in any other way.

columnstoextract:  Integer vector consisting of column indices.  Each value is the index of a column that we want to extract and include in our reduced dataset.  The vector is created by running grep() on the "features" data frame to find all values with the unique strings of text signifying that the feature is a mean ("mean()") or a standard deviation ("std()"), returning the index of each positive hit.  The search pattern is a simple regular expression.

xextracted:  A subset of the "x" data frame described above consisting solely of the columns that are means or standard deviations.  No transformation is made to the data - only the selection of specific columns.

mergeddata:  The final constructed data frame combining the subject and activity factors with the numeric variables in the "xextracted" data frame.  The combination is executed using cbind() and does not transform the data in any other way.

columnindex:  This variable is created by counting the number of columns in "mergeddata" using the ncol() function.  This variable is only used to facilitate the creation of the "summarymeans" data frame below.

summarymeans:  This data frame is created by using the aggregate() function to calculate the means of each variable in "mergeddata", broken down by the two factor variables "subject" and "activity".  The resulting data frame has as many rows as there are observed combinations of "subject" and "activity", as well as the same number of columns as the original data set (mergeddata).  The first two columns are the factors with all columns after that as variables.


Other Transformations & Clean-Up Work
=====================================

Source Variable Cleanup:  Following the initial creation of the unified data frames (including both "test" and "train" subsets), I delete via rm the original data frames.  This is done solely to conserve memory.

Adding Names to "x", "y" and "subject" Data Frames:  Using the "names()" function, I updated the variable names for each of the three primariy data frames, "x", "y", and "subject".  For "x", I substituted the text strings provided in the "features" data frame ingested earlier.  For "y" and "subject", I manually set the variables to readable values of "activity" and "subject".

Cleaning Names of the "x" Data Frame:  The feature names provided in the source data were compact and logical, but not necessarily readable.  To cleanup these names, I used the gsub() function to substitute specific instances of unclear text with longer, more descriptive values.  To ensure consistency of the variable names, I forced all names into lower-case using the tolower() function.  Finally, I removed all instances of non-alphanumeric characters from the variable names, including "-", "(", and ")".

Converting "y" into well-described factors:  Since the "y" data frame was ingested as an integer, it was necessary to transform the variable "activity" into a factor variable and to apply the text labels in "activitylabels" as the levels of the factors.  This was accomplished by recasting the "activity" variable as factors via "as.factor()" and then using levels() to assign the text in activitylabels.

