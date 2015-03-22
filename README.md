# getdata-012_CourseProject
The Course Project for the course Getting and Cleaning Data from Coursera

The run_analysis.R script does the following: 
(1) Merge the training and test sets to create one data set
(2) Extract only the measurements on the mean and standard
    for each measurement
(3) Use descriptive activity names to name the activities in the data set
(4) Appropriately labels the data set with descriptive variable names
(5) Create a second, indpeendent tidy data set with average of each variable 
    for each activity and each subject


Step 1
- get necessary files from the working directory by recursively looking through the working directory
- combine all files for the training and test data sets respectively 

Step 2
- merge the training and test data sets together

Step 3
- recode activities with descriptive activity names

Step 4
- rename the variables with names provided in features.info

Step 5
- create a new table that averages by the subject and activity for each variable with the aggregate function
- save the tidy dataset as a .txt file in the working directory
