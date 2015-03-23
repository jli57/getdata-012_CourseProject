####################################################################################
## This script does the following:
## (1) Merge the training and test sets to create one data set
## (2) Extract only the measurements on the mean and standard
##     for each measurement
## (3) Use descriptive activity names to name the activities in the data set
## (4) Appropriately labels the data set with descriptive variable names
## (5) Create a second, indpeendent tidy data set with average of each variable
##     for each activity and each subject
####################################################################################


## Load relevant packages

library(plyr)

####################################################################################
## (1) Merge the training data and test sets to creat one data set
####################################################################################


## load data set from working directory

## define working directory
wd = "./"

## get all files within working directory with .txt extension, return full filenames
files <- list.files(wd, recursive = TRUE, pattern = "+.*txt", full.names = TRUE)


## prepare feature file
feat <- files[ grep( "/features.txt", files) ]
feat <- read.table(feat, col.names = c("feat_ID", "feat_name"), stringsAsFactors = FALSE)
feat$feat_ID <- as.integer(feat$feat_ID)

## create a vector for the for floop to loop through the test and train filessourc
folders <- c("test", "train")

## read and combine files
for ( i in 1:2 ) {

	filenames <- files[ c( grep( paste("/y_", folders[i], sep="") , files) , grep( paste("/X_", folders[i], sep="") ,files), grep( paste("/subject_", folders[i], sep="") ,files) )]

	if ( i == 1 ) {
	test <- llply(filenames, read.table)
	test <- cbind(test[[1]], test[[3]], test[[2]])
	}
	else {
	train <- llply(filenames, read.table)
	train <- cbind(train[[1]], train[[3]], train[[2]])
	}

}



## Creat one data frame x with test and trainig data
merge <- rbind(test, train)

## rename the column names
colnames(merge)[1:2] <- c("subj_ID", "activity_ID")

####################################################################################
## (2) Extract only measurements on mean and standard 
####################################################################################

## get a vector of indices for mean and standard deviation measures
features <- feat[ c( grep("mean", feat[ , 2]) , grep("std",feat[ , 2])), 1:2]

merge <- merge[ , c(1:2, features$feat_ID+2)]


####################################################################################
## (3) Use descriptive activity names to name the activities in the data set
####################################################################################

## recode activities with descriptive activity names
merge$activity_ID <- mapvalues(merge$activity_ID, from = c("1","2","3","4","5","6"), to = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying") )

####################################################################################
## (4) Appropriately labels the data set with descriptive variable names
####################################################################################

## rename the variables with names provided in features.info
names(merge) <- c("subject", "activity", features$feat_name)

####################################################################################
## (5) Create a second, indpeendent tidy data set with average of each variable
##     for each activity and each subject
####################################################################################

## create a new table with average
tidy <- aggregate( . ~ subject+activity, data=merge, FUN=mean)

## write tidy data frame as a text file
write.table(tidy, file="./tidy.txt", row.name=FALSE)

