filename <- "humanactivitydata.zip"

##Step 1 - Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Step 2 - To Load Activity labels & Features

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#To Loan Train and test datasets
traindata_x <- read.table("UCI HAR Dataset/train/X_train.txt")
traindata_y <- read.table("UCI HAR Dataset/train/y_train.txt")
traindata_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

testdata_x <- read.table("UCI HAR Dataset/test/X_test.txt")
testdata_y <- read.table("UCI HAR Dataset/test/y_test.txt")
testdata_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Step 3 :Merging the dataset

# create 'x' data set
merge_data_x <- rbind(traindata_x, testdata_x)

# create 'y' data set
merge_data_y <- rbind(traindata_y, testdata_y)

# create 'subject' data set
merge_data_subject <- rbind(traindata_subject, testdata_subject )

#Step 4 :Extracts only the measurements on the mean and standard deviation for 
#each measurement.

# to extract only measurements on the mean or std in their names
features_names_mean_sd <- grep(".*mean.*|.*std.*", features[, 2])

# subset the desired columns
merge_data_x <- merge_data_x[, features_names_mean_sd]

# correct the column names
names(merge_data_x) <- features[features_names_mean_sd, 2]

##Step 5: Assigning appropriate names to activities
names(merge_data_y) <- "activities"
merge_data_y[,1] <- activityLabels[merge_data_y[,1],2]

# Step 6 : Appropriately label the data set with descriptive variable names
###############################################################################
# correct column name
names(merge_data_subject) <- "subject"

# bind all the data in a single data set
consolidated_data <- cbind(merge_data_subject,merge_data_y,merge_data_x)

# Step 7
# To prepare data set with average of all measurements(mean & std) for each activty & subject
ave_data <- ddply(consolidated_data, .(subject, activities), function(x) colMeans(x[, 3:68]))
write.table(ave_data, "consolidatedmean_data.txt", row.name=FALSE)
