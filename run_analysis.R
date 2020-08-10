library(dplyr)
unzip(zipfile="HARdataset.zip",exdir="./dataset")

features <- read.table("./dataset/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activitylabels <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt", col.names = "code")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
everythingtgt <- cbind(Subject, Y, X)

Tidy <- everythingtgt %>% select(subject, code, contains("mean"), contains("std"))
Tidy$code <- activitylabels[Tidy$code, 2]

names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "Time_Body", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy))
names(Tidy)<-gsub("-std()", "STD", names(Tidy))
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy))
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

Final <- Tidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Final, "Final.txt", row.name=FALSE)