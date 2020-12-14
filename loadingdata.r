## First, let's load the data:
## I'll be using the same names as the file for better understanding
x_test <- read.table('X_test.txt')
x_train <- read.table('X_train.txt')
y_test <- read.table('y_test.txt')
y_train <- read.table('y_train.txt')
features <- read.table('features.txt')
subject_train <- read.table('subject_train.txt')
subject_test <- read.table('subject_test.txt')
