# Part 1: Reading in the test set.
subject_test <- read.table(file = "./test/subject_test.txt") ## Identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
X_test <- read.table(file = "./test/X_test.txt")
Y_test <- read.table(file = "./test/y_test.txt")
body_acc_x_test <- read.table(file = "./test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table(file = "./test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table(file = "./test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table(file = "./test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table(file = "./test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table(file = "./test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table(file = "./test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table(file = "./test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table(file = "./test/Inertial Signals/total_acc_z_test.txt")

# Part 2 - Reading in the training set
subject_train <- read.table(file = "./train/subject_train.txt")
X_train <- read.table(file = "./train/X_train.txt")
Y_train <- read.table(file = "./train/y_train.txt")
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")

# Part 3 - Reading in the activities and features
activities <- read.table("activity_labels.txt")
features <- read.table("features.txt")
features_names <- features$V2

# Part 4 - Merging the training and test data sets, assigning names to the features
subjects_merge <- rbind(subject_test,subject_train)
X_merge <- rbind(X_test,X_train)
names(X_merge) <- features_names
activity_merge <- rbind(Y_test,Y_train)
body_acc_x_merge <- rbind(body_acc_x_train,body_acc_x_test)
body_acc_y_merge <- rbind(body_acc_y_test, body_acc_y_train)
body_acc_z_merge <- rbind(body_acc_z_test, body_acc_z_train)
body_gyro_x_merge <- rbind(body_gyro_x_test, body_gyro_x_train)
body_gyro_y_merge <- rbind(body_gyro_y_test, body_gyro_y_train)
body_gyro_z_merge <- rbind(body_gyro_z_test, body_gyro_z_train)
total_acc_x_merge <- rbind(total_acc_x_test, total_acc_x_train)
total_acc_y_merge <- rbind(total_acc_y_test, total_acc_y_train)
total_acc_z_merge <- rbind(total_acc_z_test, total_acc_z_train)

# Part 5 - Extracting the mean values.
body_acc_x_merge_mean <- rowMeans(body_acc_x_merge)
body_acc_x_merge_sd <- apply(body_acc_x_merge, 1, sd)

body_acc_y_merge_mean <- rowMeans(body_acc_y_merge)
body_acc_y_merge_sd <- apply(body_acc_y_merge, 1, sd)

body_acc_z_merge_mean <- rowMeans(body_acc_z_merge)
body_acc_z_merge_sd <- apply(body_acc_z_merge, 1, sd)

body_gyro_x_merge_mean <- rowMeans(body_gyro_x_merge)
body_gyro_x_merge_sd <- apply(body_gyro_x_merge, 1, sd)

body_gyro_y_merge_mean <- rowMeans(body_gyro_y_merge)
body_gyro_y_merge_sd <- apply(body_gyro_y_merge, 1, sd)

body_gyro_z_merge_mean <- rowMeans(body_gyro_z_merge)
body_gyro_z_merge_sd <- apply(body_gyro_z_merge, 1, sd)

total_acc_x_merge_mean <- rowMeans(total_acc_x_merge)
total_acc_x_merge_sd <- apply(total_acc_x_merge, 1, sd)

total_acc_y_merge_mean <- rowMeans(total_acc_y_merge)
total_acc_y_merge_sd <- apply(total_acc_y_merge, 1, sd)

total_acc_z_merge_mean <- rowMeans(total_acc_z_merge)
total_acc_z_merge_sd <- apply(total_acc_z_merge, 1, sd)


# Part 6 - Creating the data frame with mean and standard deviation values.
final_data_frame <- data.frame(body_acc_x_merge_mean, body_acc_x_merge_sd,
                               body_acc_y_merge_mean, body_acc_y_merge_sd,
                               body_acc_z_merge_mean, body_acc_z_merge_sd,
                               body_gyro_x_merge_mean, body_gyro_x_merge_sd,
                               body_gyro_y_merge_mean, body_gyro_y_merge_sd,
                               body_gyro_z_merge_mean, body_gyro_z_merge_sd,
                               total_acc_x_merge_mean, total_acc_x_merge_sd,
                               total_acc_y_merge_mean, total_acc_y_merge_sd,
                               total_acc_z_merge_mean, total_acc_z_merge_sd)

# Part 7 - Adding activity names 
subjects_merge <- as.factor(subjects_merge$V1)
activity_merge <- as.factor(activity_merge$V1)
levels(activity_merge) <- (list(WALKING=1,WALKING_UPSTAIRS=2,WALKING_DOWNSTAIRS=3,
                            SITTING=4,STANDING=5,LAYING=6))

# Part 8 - Creating the final data frame
final_data <- cbind(final_data_frame,X_merge)
final_data$subjects_merge <- subjects_merge
final_data$activity_merge <- activity_merge


# Part 9 - Outputting final data
final_tidy_data <- aggregate(. ~ subjects_merge + activity_merge, data = final_data, FUN = mean, na.rm = TRUE)
write.table(final_tidy_data, file = '../tidyData.txt', row.names = FALSE)


