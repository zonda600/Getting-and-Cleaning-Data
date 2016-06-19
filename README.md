# Getting and Cleaning Data - Course Project

This is the final course project for the Getting and Cleaning Data course.
The R script `run_analysis.R` will do the following:

1. Download the dataset (if it does not already exist in the working directory)
2. Load the relevant activity and feature info
3. Loads training dataset, extracting data related to mean and standard deviation
4. Loads the activity and subject data for the dataset, then merging those columns with the dataset
5. Converts the `activity` and `subject` columns into factors
6. Finally creates a "tidy" dataset that consists of the mean value of each
   variable for each subject and activity pair.

The end result is saved in the file `tidy.txt`.
