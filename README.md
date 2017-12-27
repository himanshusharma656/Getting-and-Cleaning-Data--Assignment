# Getting-and-Cleaning-Data--Assignment
Step0: Download Zip file from Getting-and-Cleaning-Data--Assignment|Coursera

Step1: Read Activity and features file which can be used while naming the variables

Step2: First all the dataset has been loaded into R environment in following order
        1.Train Label
        2.Train Features
        3.All inertial signal(Train)------Use loop  to read 12 file for convenience
        4.Test Label
        5.Test Features
        6.All inertial signal(Test)------Use loop  to read 12 file for convenience

Step3: wherever, it is convient to name the variable name while reading the file or after reading

Step4: use feature data frame to name all the X_train and X_test

Step5: Cbind all the data frames of test and train respectively

Step6: Rbind test and train dataset after flag Train/Test dataset to identify what data is training

Step7: Identify measurements which corresponds to Mean and Standard deviation using grep and regular expression

Step8:Filter those variable and add label and subject column from previous dataset as we will be needing that for next questions

Step9: Add descriptive name to Label using activity dataframe

Step10:As we have already set the variable names as descriptive as posible , we don't need to do further on question 4

step 11:  Use dplyr package function Select,Group_by,and summarise_all to calculate mean of every variable
        
