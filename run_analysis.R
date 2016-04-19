fileName <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(fileName))
{
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(url, fileName, mode='wb')
    unzip(fileName)
}


labels <- read.table("UCI HAR Dataset/activity_labels.txt")

features <- read.table("UCI HAR Dataset/features.txt")
features <- features$V2

meanStdIndices <- grep("*mean*|*std*", features)
meanStdFeatures <- features[meanStdIndices]
meanStdFeatures <- gsub('mean','Mean', meanStdFeatures)
meanStdFeatures <- gsub('std','Std',meanStdFeatures)
meanStdFeatures <- gsub('[()-]','',meanStdFeatures)

train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- train[meanStdIndices]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- test[meanStdIndices]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjects, testActivities, test)

combinedData <- rbind(trainData,testData)
colnames(combinedData) <- c("subject", "activity", meanStdFeatures)
combinedData$activity <- factor(combinedData$activity, levels = labels[,1], labels = labels[,2])
combinedData$subject <- as.factor(combinedData$subject)

combinedData <- melt(combinedData, id = c("subject", "activity"))
combinedData <- dcast(combinedData, subject + activity ~ variable, mean)

write.table(combinedData, "tidy.txt")
