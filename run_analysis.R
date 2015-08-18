# =========================================================================
# Getting and Cleaning Data
# Course Project
# Carlos Espeleta
# August 18th, 2015 
#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# =========================================================================


# 0. Configuration
# =========================================================================
options(stringsAsFactors = TRUE)
setwd("~/R/Coursea/Stats 03 - Getting and Cleaning Data")


# 1. Merges the training and the test sets to create one data set.
# =========================================================================
# Read test set
test_x <- read.table("project/test/X_test.txt", header = F, sep = "")
test_y <- read.table("project/test/Y_test.txt", header = F, sep = "")
test_subject <- read.table("project/test/subject_test.txt", header = F, sep = "")

# Read train set
train_x <- read.table("project/train/X_train.txt", header = F, sep = "")
train_y <- read.table("project/train/Y_train.txt", header = F, sep = "")
train_subject <- read.table("project/train/subject_train.txt", header = F, sep = "")

# Create test set 'x' data set
data_x <- rbind(train_x, test_x)

# Create train set 'y' data set
data_y <- rbind(train_y, test_y)

# create 'subject' data set
subject_data <- rbind(train_subject, test_subject)


# 2. Extracts only the measurements on the mean
# and standard deviation for each measurement. 
# =========================================================================
# Read features file
features <- read.table("project/features.txt", col.names = c("id", "name"))

# Get only words that contains 'mean' or 'std'
features_select        <- grep(".*mean.*|.*std.*", features$name)
features_select.names  <- features[features_select, 2]
names(features_select) <- features_select.names


# 3. Uses descriptive activity names to name the activities in the data set
# =========================================================================
activities <- read.table("project/activity_labels.txt", sep = "")

# Replace numbers by string names
data_y[, 1] <- activities[data_y[, 1] , 2]


# 4. Appropriately labels the data set with descriptive variable names.
# =========================================================================
data_set <- cbind(subject_data, data_y, data_x)
colnames(data_set) <- c("subject", "activity", as.character(features$name))


# 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
# =========================================================================
# Select unique values
unique_subject  <- as.numeric(unique(data_set$subject))
unique_activity <- unique(data_set$activity)

results <- c()
for(i in 1:length(unique_subject)) {
  subject <- unique_subject[i]                          # Select subject
  filter1 <- data_set[data_set$subject == subject, ]    # Filter by subject
  for(j in 1:length(unique_activity)) {
    # Loop over all activities
    activity <- unique_activity[j]                      # Select activity  
    filter2 <- filter1[filter1$activity == activity, ]  # Filter by Activity
    average <- apply(filter2[,(3:563)], 2, mean)
    
    # Save averages
    res <- cbind(subject, activity, t(average))         # Temporal matrix
    results <- rbind(results, res)                      # Results matrix
  }
}

# Write results into a file
write.table(results, "project_results.txt", row.names = FALSE)


