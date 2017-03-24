# Getting and Cleaning Data - Course Project

-----------------------------------

This is the course project for the Getting and Cleaning Data Coursera course. The R Script, `run_analysis.R` does the following:

1. Unzip the original dataset into the working directory. Load the `data.table` package to use `fread()` which reads the training set data (`X_train.txt`, `y_train.txt` and `subject_train.txt`) and test set data (`X_test.txt`, `y_test.txt`, `subject_test.txt`).

2. Use the `cbind()` and `rbind()` functions to combine the training and test set data as `fullset`.

3. Use `fread()` to read `features.txt` as `features` and `activity_labels.txt` as `activity_labels`.

4. Merge the `fullset` and the `activity_labels` by activity using `merge()`. Rename the activity_labels to the actual activity names.

5. Use `grep()` to get the index for features with mean and standard deviation. Load the `dplyr` package and use `select()` to select only features with mean and standard deviation.

6. Name all the features with the correct features.

7. Finally, use `dplyr`s `group_by()` and `summarise_each()` to obtain the mean for each subject and each activity and store it as 'secondset'. This 'secondset' is the final tidy dataset.