run_analysis <- function(){ 
    require(plyr)
    
    # Read data
    
    dirpath <- "UCI\ HAR\ Dataset"
    feature_aux <- paste(dirpath, "/features.txt", sep = "")
    features <- read.table(feature_aux, colClasses = c("character"))
    
    activity_aux <- paste(dirpath, "/activity_labels.txt", sep = "")
    activity_labels <- read.table(activity_aux, col.names = c("ActivityId", "Activity"))
    
    x_train <- read.table(paste(dirpath, "/train/X_train.txt", sep = ""))
    y_train <- read.table(paste(dirpath, "/train/y_train.txt", sep = ""))
    subject_train <- read.table(paste(dirpath, "/train/subject_train.txt", sep = ""))
    x_test <- read.table(paste(dirpath, "/test/X_test.txt", sep = ""))
    y_test <- read.table(paste(dirpath, "/test/y_test.txt", sep = ""))
    subject_test <- read.table(paste(dirpath, "/test/subject_test.txt", sep = ""))
    
    ##################################################################
    # 1. Merge the training and the test sets to create one data set.
    ##################################################################
    
    
    sensor_data <- rbind(cbind(cbind(x_train, subject_train), y_train), cbind(cbind(x_test, subject_test), y_test))
    
    names(sensor_data) <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
    
    ############################################################################################
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    ############################################################################################
    
    sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]
    
    ###########################################################################
    # 3. Uses descriptive activity names to name the activities in the data set
    ###########################################################################
    
    sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
    sensor_data_mean_std <- sensor_data_mean_std[,-1]
    
    ##############################################################
    # 4. Appropriately labels the data set with descriptive names.
    ##############################################################
    
    
    names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE)
    
    names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
    names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))
    
    #################################################
    # 5. Creates a second, independent tidy data set 
    #################################################
    
    write.table(ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean)), file = "tidydata.txt")


}


