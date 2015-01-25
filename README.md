Getting and Cleaning Data Project
=================================

This repository contains an R script `run_analysis.R` with functions
for combining and analyzing the UCI HAR Dataset available at:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The functions expect the zip file to be extracted in the current working directory.

The main functions are:

* `create_combined_dataset`: This will return a data frame table containing the combined data from both the test and training datasets in the UCI HAR data set. Only data points for mean and standard deviation values are included in the table. The first two columns in the table are the subject number and the activity label. See the Code Book below for the other variables.

* `save_combined_dataset`: This will write the combined dataset to the file `combined.txt` in the current directory.

* `read_combined_dataset`: This will read the combined dataset from the file `combined.txt`.

* `create_tidy_dataset`: This will summarize the combined dataset with the average value by subject and activity for every data value.

* `save_tidy_dataset`: This will write the given dataset to `tidy.txt`.

* `read_tidy_dataset`: This will read the tidy dataset from `tidy.txt`.


Code Book
---------

The first two columns in the tidy data set are `subject`, the numeric label of the individual subject, and `activity`, one of:

  * LAYING
  * SITTING
  * STANDING
  * WALKING
  * WALKING_DOWNSTAIRS
  * WALKING_UPSTAIRS

The remaining feature columns are of the form `mean.VAR.TYPE.[COOR].` where `VAR` is one of:

  * tBodyAcc
  * tGravityAcc
  * tBodyAccJerk
  * tBodyGyro
  * tBodyGyroJerk
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc
  * fBodyAccJerk
  * fBodyGyro
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

The `TYPE` is either `mean` or `std` (standard deviation). Finally, the optional `COOR` is either `X`, `Y`, or `Z`. Each feature column is the average value of the corresponding feature from the combined dataset, grouped by subject and activity. Only features for the estimated mean and standard deviation are included in this tidy data set.

Here is how the features in the original dataset were obtained (taken from the original dataset README):

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.