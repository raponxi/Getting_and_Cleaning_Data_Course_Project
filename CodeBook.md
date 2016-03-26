Codebook
================

### The data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The data for the project was downloaded from:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### The variables

    mean(): Mean value
    std(): Standard deviation
    mad(): Median absolute deviation
    max(): Largest value in array
    min(): Smallest value in array
    sma(): Signal magnitude area
    energy(): Energy measure. Sum of the squares divided by the number of values.
    iqr(): Interquartile range
    entropy(): Signal entropy
    arCoeff(): Autoregression coefficients with Burg order equal to 4
    correlation(): Correlation coefficient between two signals
    maxInds(): Index of the frequency component with largest magnitude
    meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    skewness(): Skewness of the frequency domain signal
    kurtosis(): Kurtosis of the frequency domain signal
    bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    angle(): Angle between some vectors.

No unit of measures is reported. All features were normalized and bounded within -1,1.

### Data transformation

There is only one script called run\_analysis.R that transform the data. The library plyr is required to run and is loaded at the beginning of the script.

#### 1) Merge training and test sets

The script merges the files: X\_train.txt, X\_test.txt, subject\_train.txt, subject\_test.txt, y\_train.txt, y\_test.txt, using the names in features.txt

#### 2) Extract mean and standard deviation variables

As only the mean and standard deviation is needed, the script subset the data to take only those values.

#### 3) Use descriptive activity names

The activity description is added to the previous set, using the description in activity\_labels.txt.

#### 4) Label variables appropriately

The script removes the paretheses, dashes and commas and rename the variables as follows:

AngularAcceleration, AngularSpeed, Magnitude, TimeDomain, FrequencyDomain, .Mean, .StandardDeviation, Frequency., Frequency

#### 5) Create a tidy data set

The scripts finally creates a data set called "tidydata.txt" with the numeric variables, containing 10299 observations with 81 variables.
