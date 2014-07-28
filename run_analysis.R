## create data frame of the test data files
testDataSubject <- read.table("test/subject_test.txt", sep="", col.names=c("subject"));

testDataX <- read.table("test/X_test.txt", sep="");
features <- read.table("features.txt",sep="");
features <- as.factor(features$V2);
colnames(testDataX) <- features;

testDataY <- read.table("test/y_test.txt", sep="", col.names=c("activity"));

testData <- cbind(testDataSubject, testDataY, testDataX);

## create data frame of the train data files
trainDataSubject <- read.table("train/subject_train.txt", sep="", col.names=c("subject"));

trainDataX <- read.table("train/X_train.txt", sep="");
colnames(trainDataX) <- features;

trainDataY <- read.table("train/y_train.txt", sep="", col.names=c("activity"));

trainData <- cbind(trainDataSubject, trainDataY, trainDataX);


## merge the training and test files together
completeData <- rbind(testData, trainData);

## Extracts only the measurements on the mean and standard deviation for each measurement. 
selectedColumnsIndices <- grep("std\\(\\)|mean\\(\\)", features);
selectedData <- completeData[,selectedColumnsIndices];

## Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("activity_labels.txt",sep="");
as.factor(selectedData$activity);
as.factor(selectedData$subject);

levels(selectedData$activity) <- activityLabels$V2

## write tidy dataset to a csv file
write.csv(selectedData, file = "TidyDataset.csv")




## sort the data by user id and activity
##sorteddata <- selectedData[order(selectedData$subject, selectedData$activity)] 

aggdata <-aggregate(selectedData, by=list(selectedData$subject,selectedData$activity), 
                    FUN=mean, na.rm=TRUE)

## write the sorted dataset to a csv file
write.csv(aggdata, file = "sortedDataset.csv")

