# run_analysis.r
# By Jason A. Dilks, 26/OCT/2014
# Written for JHU/Coursera course on Getting and Cleaning Data
# This script assumes that the zip file has been downloaded and unzipped
# with the resulting files placed in a "Data" subdirectory of the user's
# primary working directory.

# Ingest the labels
activitylabels <- read.table(file="./Data/UCI HAR Dataset/activity_labels.txt")
features <- read.table(file="./Data/UCI HAR Dataset/features.txt")

# Ingest the test data
subjecttest <- read.table(file="./Data/UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table(file="./Data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table(file="./Data/UCI HAR Dataset/test/Y_test.txt")

# Ingest the training data
subjecttrain <- read.table(file="./Data/UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table(file="./Data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table(file="./Data/UCI HAR Dataset/train/Y_train.txt")

# Bind the test and training data together into unified data sets
subject <- rbind(subjecttest,subjecttrain)
x <- rbind(xtest,xtrain)
y <- rbind(ytest,ytrain)

# Clean up the environment to free up memory
rm(subjecttest,xtest,ytest)
rm(subjecttrain,xtrain,ytrain)

# Add variable names to x, y and subject
names(x) = features[,2]
names(y) = "activity"
names(subject) = "subject"

# Identify which columns in x we want to extract
columnstoextract <- grep("mean\\(\\)|std\\(\\)",features$V2)

# Clean up the variable names
names(x) = gsub("tBody","timedomainsignalbody",names(x))
names(x) = gsub("fBody","frequencydomainsignalbody",names(x))
names(x) = gsub("Acc","acceleration",names(x))
names(x) = gsub("Mag","magnitude",names(x))
names(x) = gsub("std","standarddeviation",names(x))
names(x) = tolower(names(x))
names(x) = gsub("-","",names(x))
names(x) = gsub("\\(","",names(x))
names(x) = gsub("\\)","",names(x))

# Extract the desired columns
xextracted <- x[,columnstoextract]

# Convert y from numeric into well-described factors
y$activity <- as.factor(y$activity)
levels(y$activity) <- activitylabels[,2]

# Bind all the data together into a single data frame
mergeddata <- cbind(subject,y,xextracted)

# Average each variable for each unique combination of subject and activity
columnindex = ncol(mergeddata)
summarymeans <- aggregate(.~mergeddata$subject+mergeddata$activity,mergeddata[,3:columnindex],FUN=mean)

# Write out the final dataset to a text file for turn-in
write.table(summarymeans,file="./Data/summarymeans.txt",row.name=FALSE)
