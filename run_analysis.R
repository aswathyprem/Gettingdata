# This R script gets and performs some cleaning on human activity data, built
# from recordings of subjects performing daily activities while carrying
# smartphone. The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(plyr)

download = function() {
  if (!file.exists("data")) {
    message("Creating data directory")
    dir.create("data")
  }
  if (!file.exists("data/UCI HAR Dataset")) {
    # download the data
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile="data/UCI_HAR_data.zip"
    message("Downloading data")
    download.file(fileURL, destfile=zipfile, method="curl")
    unzip(zipfile, exdir="data")
  }
}

merge.datasets = function() {
  "Merge training and test datasets"
  
  # Read data
  training.x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
  training.y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
  training.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
  test.x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
  test.y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
  test.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
  
  # Merge
  merged.data.x <- rbind(training.x, test.x)
  merged.data.y <- rbind(training.y, test.y)
  merged.data.subject <- rbind(training.subject, test.subject)
  
  # merge train and test datasets and return
  list(x=merged.data.x, y=merged.data.y, subject=merged.data.subject)
}

extract.mean.std = function(df) {
  # Given the dataset (x values), extract only the measurements on the mean
  # and standard deviation for each measurement.
  
  features <- read.table("data/UCI HAR Dataset/features.txt")
  
  mean <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
  std.deviation <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
  
  
  new.df <- df[, (mean | std.deviation)]
  colnames(new.df) <- features[(mean | std.deviation), 2]
  new.df
}

name.activities = function(df) {
  # Use descriptive activity names to name the activities in the dataset
  colnames(df) <- "activity"
  df$activity[df$activity == 1] = "WALKING"
  df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
  df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
  df$activity[df$activity == 4] = "SITTING"
  df$activity[df$activity == 5] = "STANDING"
  df$activity[df$activity == 6] = "LAYING"
  df
}

bind.data <- function(x, y, subjects) {
  # Combine mean-std values (x), activities (y) and subjects into one data
  # frame.
  cbind(x, y, subjects)
}

create.tidy.dataset = function(df) {
  # Given X values, y values and subjects, create an independent tidy dataset
  # with the average of each variable for each activity and each subject.
  tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
  tidy
}


# Downloading data
download()

merged.data <- merge.datasets()

data.x <- extract.mean.std(merged.data$x)

data.y <- name.activities(merged.data$y)

colnames(merged.data$subject) <- c("subject")

combined <- bind.data(data.x, data.y, merged.data$subject)

# Create tidy dataset
tidy <- create.tidy.dataset(combined)

# Write tidy dataset as txt file
write.table(tidy, "UCI_HAR_tidy.txt", row.names=FALSE)
