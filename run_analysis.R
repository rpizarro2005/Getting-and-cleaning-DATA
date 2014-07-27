install.packages("data.table")
library(data.table)
# We have 21 subjects assigned to test, and 9 assigned to train
subjecttest <- read.table("subject_test.txt")
table(subjecttest)
subjecttrain <- read.table("subject_train.txt")
table(subjecttrain)
# Some subjects performed more activities (the most in train the subject labeled 25, 409 activities
# the most in test the subject labeled 24, 381 activities); Total 7352 train obs. and 2947 test obs.
# We have six kind of activities, and the number of times those activities were performed
# at train and test: 
# 1 WALKING, train 1226, test 496
# 2 WALKING_UPSTAIRS, train 1073, test 471
# 3 WALKING_DOWNSTAIRS, train 986, test 420
# 4 SITTING, train 1286, test 491
# 5 STANDING, train 1374, test 532
# 6 LAYING, train 1407, test 537
# Total 7352 train obs. and 2947 test obs.
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")
table(y_train)
table(y_test)
# We have the Data in the files X_train (7352 obs. of  561 variables) 
# and X_test (2947 obs. of  561 variables); total 10299 obs.
X_train <- read.table("X_train.txt")
str(X_train)
X_test <- read.table("X_test.txt")
str(X_test)
# We convert all the files from data.frame to data.table
subjecttrainDT <- data.table(subjecttrain)
is.data.table(subjecttrainDT)
# [1] TRUE
# We add a column in all the files named obsid
subjecttrainDT[,obsid:=1:7352]
subjecttestDT[,obsid:=1:2947]
y_trainDT <- data.table(y_train)
y_testDT <- data.table(y_test)
y_testDT[,obsid:=1:2947]
y_trainDT[,obsid:=1:7352]
X_trainDT <- data.table(X_train)
X_testDT <- data.table(X_test)
X_trainDT[,obsid:=1:7352]
X_testDT[,obsid:=1:2947]
# We merge the three files for train
setkey(subjecttrainDT, obsid)
setkey(y_trainDT, obsid)
setkey(X_trainDT, obsid)
temp <- merge(subjecttrainDT,y_trainDT)
setkey(temp, obsid)
alldatatrain <- merge(temp,X_trainDT)
View(alldatatrain)
# We merge the three files for test
setkey(subjecttestDT, obsid)
setkey(y_testDT, obsid)
setkey(X_testDT, obsid)
temp <- merge(subjecttestDT,y_testDT)
setkey(temp, obsid)
alldatatest <- merge(temp,X_testDT)
View(alldatatest)
# We add a column variable "kind" as train or test
alldatatrain[,kind:="train"]
alldatatest[,kind:="test"]
View(alldatatrain)
View(alldatatest)
# We save the files and sum the rows in Excel in the new alldatatrainandtest.txt
write.csv(alldatatrain,"datatrain.csv")
write.csv(alldatatest,"datatest.csv")
# Extracts only the measurements on the mean and standard deviation for each measurement.
resultmeantest <- numeric(ncol(alldatatest)-4)
resultSDtest <- numeric(ncol(alldatatest)-4)
resultmeantrain <- numeric(ncol(alldatatrain)-4)
resultSDtrain <- numeric(ncol(alldatatrain)-4)
for(i in 1:(ncol(alldatatest)-4)) {
x <- c("V", i)
x <- paste(x, collapse = "")
resultmeantest[i] <- alldatatest[,mean(x)]}