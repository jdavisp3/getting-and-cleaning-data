# Clean the Smartphone data
library(dplyr)

data_dir <- 'UCI HAR Dataset'

get_activities <- function() {
  activity_labels_file <- file.path(data_dir, 'activity_labels.txt')
  activity_data <- read.csv(activity_labels_file, header=FALSE, sep=' ')
  factor(activity_data$V1, labels=activity_data$V2)
}

get_features <- function() {
  features_file <- file.path(data_dir, 'features.txt')
  features_data <- read.csv(features_file, header=FALSE, sep=' ', stringsAsFactors = FALSE)
  matrix(features_data[,2])
}

load_data_set <- function(set_name) {
  dataset_dir <- file.path(data_dir, set_name)

  get_data_file_name <- function(data_type) {
    paste(data_type, '_', set_name, '.txt', sep='')
  }

  subject_file <- file.path(dataset_dir, get_data_file_name('subject'))
  subject_data <- read.csv(subject_file, header=FALSE, stringsAsFactors=FALSE)
  subject_data <- tbl_df(subject_data)
  colnames(subject_data) <- c('subject')

  features <- get_features()

  x_file <- file.path(dataset_dir, get_data_file_name('x'))
  x_data <- read.fwf(x_file, rep(16, length(features)), col.names=features, colClasses=c('numeric'), n=50)
  x_data <- tbl_df(x_data)
  x_data
}

activities <- get_activities()
features <- get_features()

train_data <- load_data_set('train')
