library(dplyr)


## Now we have to merge x_test and x_train in one data set

fulldata <- rbind(x_test, x_train)

## The names of the columns are the features dataset
names(fulldata) <- features[,2]

## Now we select only the columns that express a mean or a std
## For that we use regular expressions to parse the columns that we need
re1 <- 'mean[(][)]' ## To detect the pattern 'mean()'
re2 <- 'std[(][)]' ## To detect the pattern 'std()'
## We assign the logical vector to a variable
logcol <- grepl(re1, names(fulldata)) | grepl(re2, names(fulldata))
## And now we select the columns we need
meanstd_data <- fulldata[,logcol] 

## For the activity data we need to merge the y_train and y_test 

y_data <- rbind(y_test, y_train)

## We create a named vector with the values which will be used in the y_data
dict <- c('1' = 'WALKING', '2' = 'WALKING_UPSTAIRS', '3' = 'WALKING_DOWNSTAIRS',
          '4' = 'SITTING', '5' = 'STANDING', '6' = 'LAYING')
y_data <- mutate(y_data, act = dict[y_data[[1]]])
y_data <- y_data[-1]
## Rename the column
names(y_data) <- 'activity'

## Then we load the subject_train and subject_test information:
subject <- rbind(subject_test, subject_train)
names(subject) <- 'subject'

##We add the y_data and the subject data in meanstd_data
meanstd_data <- cbind(subject, y_data, meanstd_data)

## And finally we apply the mean to all columns by subject and activity
group_data <- meanstd_data %>% group_by(subject, activity) %>% summarise(
  across(everything(), mean))
