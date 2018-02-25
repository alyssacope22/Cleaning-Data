---
title: "Code Book for Cleaning and Tidying Data"
author: "Alyssa Copeland"
date: "February 25, 2018"
output: html_document
---

The document describes  the code of the run_analysis.R of this project.

#URL Data Loading Variables

1. fileURL - calling the file from its URL
2. download.file - downloads the file to the program
3. unzip - unzips the the .zip file
4. path_rf - name given the the file path for this data set

#Merging of Data Variables

1. xtrain - name given to X_train.txt within the file path and reads the table
2. ytrain - name given to Y_train.txt within the file path and reads the table
3. sub_train - name given to the subject_train.txt within the file path and reads the table

4. xtest - name given to the X_test.txt within the file path and reads the table
5. ytest - name given to the Y_test.txt within the file path and reads the table
6. sub_test - name given to the subject_test.txt within the file path and reads the table

#Creating X, Y, and Subject Data Sets Variables

1. xdata - combining the xtrain and xtest data from the X_train.txt and X_test.txt
2. ydata - combining the ytrain and ytest data from the Y_train.txt and Y_test.txt
3. subdata - combining the sub_train and sub_test data from the subject_train.txt and subject_test.txt

#Further Merging and Naming Variables

1. xfeats - name given to the features.txt within the file path and reads the table
2. combine - combination of subdata and ydata
3. data - combination of xdata and combine

#Extracting Mean and std for  Each Measurement

1. subfeat - mean and standard deviation of xfeats file
2. subnames - changing names of the variable in subfeat to "subject" and "activity" 
3. data - changing the data in the previous section (further merging and naming variables) to subset the data and to select for subnames

#Use Descriptive Activity Names for Activity Data Set

1. activitylabels - naming and reading the activity_labels.txt within the file path

#Melt Data, Add Labels, and Write Table

1. data.melt - melts data and gives id called "subject" and "activity"
2. data.mean - takes the mean from data.melt looking at activity and subject compared to variable

