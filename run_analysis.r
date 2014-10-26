###############################################################################
# This script is used for reading and extracting the raw data (variables
# measure using sensors) for different subjects performing different activities
# The script then cleans the data by retaining only relevant information. It also
# updates the variable names and activity labels to provide a more understandable
# name to them. The script finally performs mean calculation on the variable columns
# (after grouping them by subject and activity parameters) and writes a clean
# data set to a text file ready to be used by the end user
###############################################################################
###############################################################################
# Downloading raw data from http link and unzipping it in HAR directory#
###############################################################################
zipdirectory <- tempfile()

dir.create(zipdirectory)


if(!file.exists("HAR")){
  dir.create("HAR")
}
fileurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,dest = "./HAR/zipfile.zip",mode ="wb")
unzip("./HAR/zipfile.zip",exdir="zipdirectory")
##################################################################################
######################Read the test and train files into R########################
##################################################################################
X_testDF <- read.table("./zipdirectory/UCI HAR Dataset/test/X_test.txt",sep ="")
Y_testDF <- read.table("./zipdirectory/UCI HAR Dataset/test/y_test.txt",sep ="")
subject_testDF <- read.table("./zipdirectory/UCI HAR Dataset/test/subject_test.txt",sep ="")

X_trainDF <- read.table("./zipdirectory/UCI HAR Dataset/train/X_train.txt",sep ="")
Y_trainDF <- read.table("./zipdirectory/UCI HAR Dataset/train/y_train.txt",sep ="")
subject_trainDF <- read.table("./zipdirectory/UCI HAR Dataset/train/subject_train.txt",sep ="")

#####################################################################################
#######################Read the features text file into R############################
#####################################################################################

FeaturesDF <- read.table("./zipdirectory/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE,sep="")
FeaturesDF <- FeaturesDF[,c(2)]
#####################################################################################
########################Combining the train datasets together############################
#####################################################################################
trainDF <- cbind(subject_trainDF,Y_trainDF,X_trainDF)
names(trainDF) <- c("Subjects","ActivityLabels",FeaturesDF)

########################################################################################
########################Combining the test datasets together############################
########################################################################################
testDF <- cbind(subject_testDF,Y_testDF,X_testDF)
names(testDF) <- c("Subjects","ActivityLabels",FeaturesDF)

#########################################################################################
########################Merge the train and test datasets together#######################
#########################################################################################
traintestDF <- rbind(trainDF,testDF)

#########################################################################################
########################Extracting only Mean and std measurements########################
#########################################################################################
features_mean_std <- grep("mean\\(\\)|std\\(\\)",FeaturesDF,perl=TRUE)
traintestDF <- traintestDF[,c(1,2,features_mean_std+2)]

#########################################################################################
# Step 3 - Subsituting descriptive names for activity Labels (replacing numeric
#          value with descriptive names)
###############################################################################
activityNames <- read.table("./zipdirectory/UCI HAR Dataset/activity_labels.txt")
traintestDF$ActivityLabels <- factor(traintestDF$ActivityLabels,levels=c(1,2,3,4,5,6),labels=activityNames[,2])

#########################################################################################
# Step 4 - Replacing variables with a better description 
#########################################################################################
names(traintestDF) <- gsub("t(\\w+)-mean\\(\\)-(\\w+)","Mean in time domain of \\1 in \\2 direction",names(traintestDF))
names(traintestDF) <- gsub("t(\\w+)-std\\(\\)-(\\w+)","Standard deviation in time domain of \\1 in \\2 direction",names(traintestDF))

names(traintestDF) <- gsub("t(\\w+)Mag-mean\\(\\)","Magnitude of mean in time domain for \\1",names(traintestDF))
names(traintestDF) <- gsub("t(\\w+)Mag-std\\(\\)","Magnitude of standard deviation in time domain for \\1",names(traintestDF))

names(traintestDF) <- gsub("BodyBody","Body",names(traintestDF))

names(traintestDF) <- gsub("f(\\w+)-mean\\(\\)-(\\w+)","Mean in frequency domain of \\1 in \\2 direction",names(traintestDF))
names(traintestDF) <- gsub("f(\\w+)-std\\(\\)-(\\w+)","Standard deviation in frequency domain of \\1 in \\2 direction",names(traintestDF))

names(traintestDF) <- gsub("f(\\w+)Mag-mean\\(\\)","Magnitude of mean in frequency domain for \\1",names(traintestDF))
names(traintestDF) <- gsub("f(\\w+)Mag-std\\(\\)","Magnitude of standard deviation in frequency domain for \\1",names(traintestDF))

###########################################################################################
# Step 5 - Splitting data frame based on Subject ID and Activity and then calculating
#          mean values for all the variables
###########################################################################################
traintestDF <- ddply(traintestDF,.(Subjects,ActivityLabels),numcolwise(mean))
###########################################################################################
# Writing out the tidy data value in traintest.txt file
###########################################################################################
write.table(traintestDF,file="./traintest.txt",row.name=FALSE)