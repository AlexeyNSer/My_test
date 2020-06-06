setwd("D:/TEST/UCI HAR Dataset/UCI HAR Dataset")

library(dplyr)

activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("activity_code","activity_desc")
features <- read.table("features.txt")


s_test <- read.table("test/subject_test.txt")
names(s_test) <- c("subject_id")
s_test$source <- 'test'
s_test$recordno <- c(1:2947)

y_test <- read.table("test/y_test.txt")
names(y_test) <- c("activity_code")


obs_test <- read.table("test/X_test.txt")
names(obs_test) <- as.character(features$V2)
x_test<- obs_test[,grep("mean|Mean|std", names(obs_test))]

test <- cbind(s_test, y_test,x_test)

s_train <- read.table("test/subject_test.txt")
names(s_train) <- c("subject_id")
s_train$source <- 'train'
s_train$recordno <- c(2948:10299)  


y_train <- read.table("train/y_train.txt")
names(y_train) <- c("activity_code")


obs_train <- read.table("train/x_train.txt")
names(obs_train) <- as.character(features$V2)
x_train<- obs_train[,grep("mean|Mean|std", names(obs_test))]
train <- cbind(obs_train, y_train,x_train)

Fulldata <- rbind(test,train)


FinalData <- merge (activity_labels,Fulldata,by.x="activity_code", by.y="activity_code")
FinalData_1 <- FinalData%>%select(activity_desc,subject_id, 6:91)
FinalData_2 <- FinalData_1%>%group_by(activity_desc,subject_id)%>%summarize_all(funs(mean))

write.table(FinalData_2, "ActivityStudent.txt",row.names=FALSE )
