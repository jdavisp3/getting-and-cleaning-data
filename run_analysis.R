# Clean the Smartphone data

data_dir <- 'UCI HAR Dataset'

get_activities <- function() {
  activity_labels_file <- file.path(data_dir, 'activity_labels.txt')
  activity_data <- read.csv(activity_labels_file, header=FALSE, sep=' ')
  factor(activity_data$V1, labels=activity_data$V2)
}

get_features <- function() {
  features_file <- file.path(data_dir, 'features.txt')
  features_data <- read.csv(features_file, header=FALSE, sep=' ', stringsAsFactors = FALSE)
  matrix(features[,2])
}

activities <- get_activities()
features <- get_features()
