# Getting and Cleaning Data Project

## Description
The run\_analysis.r script is used for gathering,cleaning and analyzing data information for a group of 
subjects(30 in total) who performs six different activities(Laying,Sitting,Standing,Walking,Walking\_Upstairs and Walking\_downstairs) over a period of time.

## Details about script running this project
* Raw data is present in six separate files- subject\_test/train.txt files,y\_test/train.txt files,X\_test/train.txt files
* Since the raw data is spread over six different files,so the script performs the first step of reading in all these files into R datasets.
* It then makes two separate test and train dataframes(testDF and trainDF) by combining(using cbind) the \*\_test datasets and \*\_train datasets.
* Next step is to merge both the test and train dataframe in a single dataframe(traintestDF) and provide variable names which describes the content of each column-"Subjects","ActivityLabels",features(tBodyAcc-mean()-X
,tBodyAcc-mean()-Y...etc (561 variables in total))
* The script then selects(using grep) columns containing mean() and std() in their variable names in addition to 
Subjects and ActivityLabels to reduce to a dataframe with 68 columns.
* The script then reads the activity\_labels.txt file to give descriptive names to each activity in traintestDF.
  * 1 - WALKING
  * 2 - WALKING\_UPSTAIRS
  * 3 - WALKING\_DOWNSTAIRS
  * 4 - SITTING
  * 5 - STANDING
  * 6 - LAYING
* The next step is to further tidy the dataset by giving descriptive names to each feature variable name in the dataset.
  *  Mean of different measurements(BodyAcc,GravityAcc,Accjerk)in time domain in X,Y,Z directions are replaced by        more descriptive variable names.
eg. tBodyAcc-mean()-X --> "Mean in time domain of BodyAcc in X direction"
  *  Standard deviations of different measurements(BodyAcc,GravityAcc,Accjerk)in time domain in X,Y,Z directions are replaced by more decriptive variable names. 
eg. tBodyAcc-std()-X  --> "Standard deviation in time domain of BodyAcc in X direction"
  *  Magnitude of means of different measurements(BodyAcc,GravityAcc,Accjerk)in time domain are replaced by more descriptive variable names.
eg. tBodyAccMag-mean() --> "Magnitude of mean in time domain for BodyAcc"
  *  Magnitude of standard deviations of different measurements(BodyAcc,GravityAcc,Accjerk)in time domain are replaced by more descriptive variable names.
eg. tGravityAccMag-std()--> "Magnitude of standard deviation in time domain for GravityAcc"
  * Mean of different measurements(BodyAcc,GravityAcc,Accjerk)in frequency domain in X,Y,Z directions are replaced by more descriptive variable names.
eg. fBodyAcc-mean()-X --> "Mean in frequency domain of BodyAcc in X direction"
 *  Standard deviations of different measurements(BodyAcc,GravityAcc,Accjerk)in frequency domain in X,Y,Z directions and replaced by more descriptive variable names. 
eg. fBodyAcc-std()-X  --> "Standard deviation in frequency domain of BodyAcc in X direction"
Magnitude of means of different measurements(BodyAcc,GravityAcc,Accjerk)in frequency domain are replaced by more descriptive variable names.
eg. fBodyAccMag-mean() --> "Magnitude of mean in frequency domain for BodyAcc"
 *  Magnitude of standard deviations of different measurements(BodyAcc,GravityAcc,Accjerk)in frequency domain are replaced by more descriptive variable names.
eg. fBodyAccMag-std() --> "Magnitude of standard deviation in frequency domain for BodyAcc"
* The next step is to calculate the mean of each variable based on each activity and each subject.
* The last step is to write the dataset to a text file removing row names if any.

