# Clean the Smartphone data
library(dplyr)
library(lazyeval)

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

create_combined_dataset <- function(nrows=-1) {
  test_data <- load_data_set('test', nrows=nrows)
  train_data <- load_data_set('train', nrows=nrows)
  dataset <- bind_rows(test_data, train_data)
  arrange(dataset, subject, activity)
}

save_combined_dataset <- function(dataset) {
  combined_file <- file.path('combined.txt')
  write.table(dataset, combined_file)
}

read_combined_dataset <- function() {
  combined_file <- file.path('combined.txt')
  dataset <- read.table(combined_file)
  tbl_df(dataset)
}

create_tidy_dataset <- function(dataset) {
  columns <- colnames(dataset)
  columns <- columns[3:length(columns)]

  mean_expression <- function(column) {
    interp(quote(mean(var)), var=as.name(column))
  }
  
  dots <- lapply(columns, mean_expression)

  summarise_(group_by(dataset, subject, activity), .dots = dots)
}

save_tidy_dataset <- function(dataset) {
  tidy_file <- file.path('tidy.txt')
  write.table(dataset, tidy_file, row.names=FALSE)
}

read_tidy_dataset <- function(dataset) {
  tidy_file <- file.path('tidy.txt')
  tbl_df(read.table(tidy_file, header=TRUE, row.names=NULL))
}