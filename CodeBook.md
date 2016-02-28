# Description of variables, the data, and  transformations or work performed to clean up the data 
The script run_analysis.R performs the below steps to create the tidy data set as per description provided in step 5 of course project

Step 1 -  Check whether the input data set provide in course project available in current working directory, if not then download the file 
          using URL provided in the course project. Then Unzip the zipped file and create a folder "UCI HAR Dataset"
          
Step 2 - a) Load Activity labels and features data into activityLabels
         b) Load the data gathered using smartphone for training and Testing samples into traindata_x,traindata_y,traindata_subject,
            testdata_x,testdata_y,testdata_subject 
            
 Step 3 - a) Merge the Train & Test datasets of x into  merge_data_x using rbind()
          b) Merge the Train & Test datasets of y into  merge_data_y using rbind()
          c) Merge the subject datasets of train & test into merge_data_subject using rbind()
          
 Step 4 - a) Extracts only the measurements on the mean and standard deviation for each measurement and change the column names 
            appropriately
 Step 5 -  a) Assigning appropriate names to activities
 
 Step 6 - a) Appropriately label the data set with descriptive variable names
          b) Merge all the three data sets merge_data_x,merge_data_y,merge_data_subject into single dataset consolidated_data

 Step 7 - a) prepare data set with average of all measurements(mean & std) for each activty & subject into data set ave_data,
             ddply() from the plyr package is used to apply colMeans() and ease the development.
          b) write the dataset created with averages into consolidatedmean_data.txt and create a text file in current working directory
