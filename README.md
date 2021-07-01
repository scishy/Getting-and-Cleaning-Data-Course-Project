# Getting and Cleaning Data Course Project

##Description
Create a tidy data set using the Human Activity Recognition Using Smartphones Study Data Set found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
Data file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##About
The run_analysis.R script creates a directory within the working directory where the .zip file will be downloaded and files extracted.
Each .txt (data set) file of interest is read into R and pieced together to create one tidy data table which is exported to the created directory as a .txt file.

##Acknowledgements
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012