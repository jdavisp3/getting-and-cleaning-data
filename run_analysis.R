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
  features <- matrix(features_data[,2])
  apply(features, 2, clean_feature_name)
}

is_mean_or_std <- function(feature) {
  matches <- grep('(mean|std)\\(\\)', feature)
  length(matches) > 0
}

clean_feature_name <- function(feature) {
  no_lparens <- gsub('\\(', '', feature)
  no_rparens <- gsub('\\)', '', no_lparens)
  chartr('-,', '..', no_rparens)
}

load_data_set <- function(set_name, nrows=-1) {
  dataset_dir <- file.path(data_dir, set_name)

  get_data_file_name <- function(data_type) {
    paste(data_type, '_', set_name, '.txt', sep='')
  }

  subject_file <- file.path(dataset_dir, get_data_file_name('subject'))
  subject_data <- read.csv(subject_file, header=FALSE, stringsAsFactors=FALSE, nrows=nrows)
  subject_data <- tbl_df(subject_data)
  colnames(subject_data) <- c('subject')

  activities <- get_activities()
  features <- get_features()

  x_file <- file.path(dataset_dir, get_data_file_name('x'))
  x_data <- read.fwf(x_file, rep(16, length(features)), col.names=features, colClasses='numeric', n=nrows)
  x_data <- tbl_df(x_data)
  x_data <- select(x_data, contains('mean'), contains('std'))
  
  y_file <- file.path(dataset_dir, get_data_file_name('y'))
  y_data <- read.table(y_file, colClasses='numeric', col.names=c('activity'), nrows=nrows)
  y_data <- tbl_df(y_data)
  y_data <- transmute(y_data, activity=activities[activity])
  
  bind_cols(subject_data, y_data, x_data)
}

test_data <- load_data_set('test', 20)
train_data <- load_data_set('train', 20)

all_data <- bind_rows(test_data, train_data)