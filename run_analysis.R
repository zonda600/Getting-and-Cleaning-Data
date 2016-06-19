library(reshape2)

filename <- "getdata_dataset.zip"

## This code will download the data and unzip the file:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Read the table and associated attributes
ReadTable <- read.table("UCI HAR Dataset/activity_labels.txt")
ReadTable[,2] <- as.character(activityLabels[,2])
Attributes <- read.table("UCI HAR Dataset/features.txt")
Attributes[,2] <- as.character(features[,2])

# Extract the relevant data - only mean and standard deviation
AttributesN <- grep(".*mean.*|.*std.*", features[,2])
AttributeaN.names <- features[featuresWanted,2]
AttributesN.names = gsub('-mean', 'Mean', AttributesN.names)
AttributesN.names = gsub('-std', 'Std', AttributesN.names)
AttributesN.names <- gsub('[-()]', '', AttributesN.names)


# Load datasets
Train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
TrainDetails <- read.table("UCI HAR Dataset/train/Y_train.txt")
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
Train <- cbind(TrainSubjects, TrainDetails, Train)

# merge datasets and add labels
Merged <- rbind(train, test)
colnames(Merged) <- c("subject", "activity", AttributesN.names)

# turn activities & subjects into factors
Merged$activity <- factor(Merged$activity, levels = activityLabels[,1], labels = activityLabels[,2])
Merged$subject <- as.factor(Merged$subject)

Merged.melted <- melt(Merged, id = c("subject", "activity"))
Merged.mean <- dcast(Merged.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)