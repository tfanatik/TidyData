#set directory to where the files are
setwd("C:/Users/Kem/Documents/UCI HAR Dataset")

#read files into R
xtest <-read.table("./test/X_test.txt", header=F);
ytest <-read.table("./test/y_test.txt", header=F);
subjtest <-read.table("./test/subject_test.txt", header=F);
xtrain <-read.table("./train/X_train.txt", header=F);
ytrain <-read.table("./train/y_train.txt", header=F);
subjtrain <-read.table("./train/subject_train.txt", header=F);
actLabels <-read.table("./activity_labels.txt",header=F);
features <-read.table("./features.txt",header=F);
featInfo <-read.table("./activity_labels.txt",header=F)

#assign column names
colnames(xtest) <- features[,2];
colnames(ytest) <- "activityID";
colnames(subjtest) <- "subjectID";
colnames(xtrain) <- features[,2];
colnames(ytrain) <- "activityID";
colnames(subjtrain) <- "subjectID";
colnames(actLabels) <- c("activityID","activityType") 

trainData <-cbind(xtrain, ytrain, subjtrain) #pull train data together
testData <-cbind(xtest, ytest, subjtest) #pull test data together

finalDS <- rbind (trainData, testData) #create one final data set
cols <- colnames(finalDS) #a vector helping find mean/std

logicalDS <- (grepl("..-mean",cols) & !grepl("meanFreq..",cols,fixed = T) & !grepl("mean..-",cols,fixed = T)|grepl("-std",cols) & !grepl("std()..-",cols,fixed = T)|grepl("activity..",cols)|grepl("subject..", cols));

finalDS <- finalDS[logicalDS == TRUE];

finalDS <- merge(finalDS,actLabels,by="activityID",all.x=TRUE)

cols <- colnames(finalDS) #updating column name vector

#renaming the columns by column number, extending some names, capitalizing others
for (i in 1:length(cols)){
  cols[i] <- gsub("\\()", "",cols[i])
  cols[i] <- gsub("-std$", "Std Dev",cols[i])
  cols[i] <- gsub("-mean", "Mean",cols[i])
  cols[i] <- gsub("^(t)", "Time",cols[i])
  cols[i] <- gsub("^(f)", "Frequency",cols[i])
  cols[i] <- gsub("([Gg]ravity)", "Gravity",cols[i])
  cols[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body",cols[i])
  cols[i] <- gsub("([Gg]yro)", "Gyroscope",cols[i])
  cols[i] <- gsub("AccMag", "AccelerationMagnitude",cols[i])
  cols[i] <- gsub("([Bb]odyaccjerkmag)", "BodyAcceleratonJerkMagnitude",cols[i])
  cols[i] <- gsub("JerkMag", "JerkMagnitude",cols[i])
  cols[i] <- gsub("GyroMag", "GyroscopeMagnitude",cols[i])
}

colnames(finalDS) <- cols #reassigning the new column names

noActData <- finalDS[,names(finalDS)!="actLabels"]#new Table w/o activity labels
print (head(noActData))

#tidy data includeing just the mean of each variable for each activity & subject
tData <- aggregate(noActData[,names(noActData)!=c("activityID","subjectID")],
         by=list(activityID=noActData$activityID, subjectID=
          noActData$subjectID),mean)

#merging tidydata with activityLabels for activity descriptions
tData <- merge(tData,actLabels, by="activityID",all.x=TRUE)

write.table(tData,"./tidyData.txt",row.names=TRUE,sep="\t") #export the tidy dataset