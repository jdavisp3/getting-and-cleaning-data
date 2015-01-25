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

The remaining columns are of the form `mean.VAR.TYPE.[COOR].` where `VAR` is one of:

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

The `TYPE` is either `mean` or `std` (standard deviation). Finally, the optional `COOR` is either `X`, `Y`, or `Z`.
