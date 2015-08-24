This is the code book describing the manipulations done to data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

After moving the subfile out to the main directory, this is the directory where all files resided:
     C:/Users/Kem/Documents/UCI HAR Dataset


These are the variables representing a data frame containing the files from the dataset, the first name will be the variable containing the data from the file, the second name will be the file containing the data from the UCI HAR Dataset 
     xtest <-  X_test.txt 
     ytest <- y_test.txt 
     subjtest <- subject_test.txt
     xtrain <- X_train.txt
     ytrain <- y_train.txt"
     subjtrain <- subject_train.txt
     actLabels <- activity_labels.txt
     features <- features.txt
     featInfo <- activity_labels.txt


Column Names
The left hand side is the variable, the right side is the column name
     xtest <- features (only the second article of this chosen)
     ytest <- activityID
     subjtest <- subjectID
     xtrain <- features (only the second article of this chosen)
     ytrain <- activityID
     subjtrain <- subjectID
     actLabels <- activityID, activityType 

Variable representing a data frame that holds all of the training data done with cbind
     trainData

Variable representing a data frame that holds all of the test data done with cbind
     testData 

The data frame combining both the training and test data frmes done with rbind
     finalDS 

A vector helping find mean/std moving the column names from finalDS
     cols

Stores the logical vector that puts out TRUE for each mean/std column grabbed through grepl
      logicalDS
Then pulls the corresponding columns from the combined data frame by setting last vector equal to T while calling the combined dataframe       
      finalDS

The dataset is finally merged with the corresponding activity labels and ids using merge
      finalDS 

The vector is now getting updated with the new column names from the last data frame
      cols

Renaming the columns by column number, extending some names, capitalizing others. Each name goes through the list of possible changes due to a for loop, the column names indexed and gsub for substituting. If a match is founds, the change is done
f

Reassigning the new column names to the cols variable

Make new Table without the activity labels


New tidy dataset including just the mean of each variable for each activity & subject using aggregate to compute summary statistics for each listed column


Merged tidydata with activityLabels for activity descriptions

Make an exportable file for GitHub

