filename <- "humanactivitydata.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#To Load Activity labels & Features

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#To Loan Train and test datasets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Step 1:Merging the dataset

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

#Extracts only the measurements on the mean and standard deviation for 
#each measurement.

# to extract only measurements on the mean or std in their names
features_names_mean_sd <- grep(".*mean.*|.*std.*", features[, 2])

# subset the desired columns
x_data <- x_data[, features_names_mean_sd]

# correct the column names
names(x_data) <- features[features_names_mean_sd, 2]

##Step 3: Assigning appropriate names to activities
names(y_data) <- "activities"
y_data[,1] <- activityLabels[y_data[,1],2]
# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################
# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
consolidated_data <- cbind(subject_data,y_data,x_data)

# Step 5 
# To prepare data set with average of all measurements(mean & std) for each activty & subject
ave_data <- ddply(consolidated_data, .(subject, activities), function(x) colMeans(x[, 3:68]))
write.table(ave_data, "consolidatedmean_data.txt", row.name=FALSE)
