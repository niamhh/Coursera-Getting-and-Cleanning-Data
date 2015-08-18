## Introduction

Additional information about the steps that I've performed to carry out the course project

* Step 1: We have to merge training and test set to create one data set. We will do that using `rbind` function. 
Once we have finished this step we will have the following variables `data_x`, `data_y` and `subject_data`.

* Step 2: In this step we have to select all those colums that cointains `mean` or `std` in their name, so to do that we
can use `grep` function.

* Step 3: We only have to replace each number by their own name.

* Step 4: `data_set` variable is a result of merge `data_x`, `data_y` and `subject_data` using `cbind`.

* Step 5: We will get all unique activities and subjects using `ùnique` function and then we will loop over it. Our loop is doing the following: first, 
select an user and then select each activity of that user and then save the `mean`of each column. To calculate the `mean`of each colum we will use `apply` function

## Source Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

* Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* Data of the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Variables

* Test set: `test_x`, `test_y` and `test_subject`

* Trainning set: `train_x`, `train_y` and `train_subject`

* Merged data: `data_x`, `data_y`, `subject_data`

* `features_select`: All features that contain `std`and `mean`-

* `features_select.names`: Names of `features_select`.

* `data_set`: All data merged as described in `Step 4`.

* `unique_subject`: Unique values of subjects.

* `unique_activity`: Unique values of activities.

* `results`: Tidy data set with the average of each variable for each activity and each subject

## Activity labels

* `WALKING` = 1

* `WALKING_UPSTAIRS` = 2

* `WALKING_DOWNSTAIRS` = 3

* `SITTING` = 4

* `STANDING` = 5

* `LAYING` = 6
