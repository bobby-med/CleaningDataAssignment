First dplyr is loaded and dataset unzipped

data is read into corresponding names: features, activitylabels, subject_test, x, y, and subject_train. These dataframes are then combined into everythingtgt
The tidy dataframe is then created by selecting subject, code, "mean", and "std".
Column names in the tidy dataframe are replaced for clarity.
The final txt file is created.

### Codebook:

features <- features.txt
activitylabels <- activity_labels.txt
subject_test <- subject_test.txt
x_test <- X_test.txt
y_test <- y_test.txt
subject_train <-subject_train.txt
x_train <- X_train.txt
y_train <- y_train.txt
