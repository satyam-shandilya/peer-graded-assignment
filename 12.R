library(dplyr)
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/Y_train.txt")
Subject_train <- read.table("train/subject_train.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/Y_test.txt")
Subject_test <- read.table("test/subject_test.txt")
variable<- read.table("features.txt")
activitylabels <- read.table("activity_labels.txt")
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
Subject <- rbind(Subject_train, Subject_test)
selected_variable <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
x_data <- x_data[,selected_variable[,1]]

colnames(x_data) <- variable_names[selected_variable[,1],2]
colnames(y_data) <- "activity"
y_data$activitylabel <- factor(y_data$activity, labels = as.character(activity_labels[,2]))
activitylabel <- y_data[,-1]
colnames(Subject) <- "subject"
total <- cbind(x_data, activitylabel, Subject)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = " tidydata.txt", row.names = FALSE, col.names = TRUE)