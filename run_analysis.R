# Source of data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.

a <- read.table("train/X_train.txt")
b <- read.table("test/X_test.txt")
X <- rbind(a,b)

a <- read.table("train/subject_train.txt")
b <- read.table("test/subject_test.txt")
S <- rbind(a,b)

a <- read.table("train/y_train.txt")
b <- read.table("test/y_test.txt")
Y <- rbind(a,b)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
good <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, good]
names(X) <- features[good, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activity <- read.table("activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
Y[,1] = activity[Y[,1], 2]
names(Y) <- "Activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "Subject"
clean <- cbind(S, Y, X)
write.table(clean, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activity[,1])
numCols = dim(clean)[2]
result = clean[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activity[a, 2]
                tmp <- clean[clean$Subject==s & clean$Activity==activity[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "tidy_data.txt",row.name=FALSE)
