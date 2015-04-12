plot2 <- function() { 
    
############################################################################################## 
##
## This plot2 function uses data from the UC Irvine Machine Learning Repository, 
## in particular the “Individual household electric power consumption Data Set”
## 
## The function reads the dataset "household_power_consumption.txt" in the
## current Working directory, construct & print a X-Y Plotting based on the Global Active Power 
## over the time. It copies the graphic to a PNG file called "plot2.png" 
## with a width of 480 pixel x height 480 pixel.
## 
## The dataset has 2,075,259 rows and 9 columns with Measurements of electric
## power consumption in one household with a one-minute sampling rate over a
## period of almost 4 years. 
##
## The function subsets the data from the dates 2007-02-01 and 2007-02-02. It cleans the variables
## retrieved to Date & Numeric formats. The column Global_active_power is selected to plot 
## the Y-axis.
## 
## IMPORTANT NOTE: The dataset represents a large table. Therefore as rough estimation, 
## considering 8bytes each numeric value, requests at least 
## (2,075,259 rows) x (9 columns x 8bytes) x 2 times / (10^-9 Gbytes) = 0,30 Gbytes 
## of free memory in the computer.
##
###############################################################################################
## Check the existance of the file household_power_consumption.txt in the current WD
###############################################################################################
    
#list all the files of the current directory
files <- list.files() 
    
#check if the file exists
data_exists <- sum(files=="household_power_consumption.txt")==1 
    
#if file does not exist in the current working directory returns an error message
if(!data_exists) { 
    return(print("ERROR: File household_power_consumption.txt is not in the current Working Directory"
                 ,quote=FALSE))
    }    
    
# remove temporary variables
rm(files, data_exists)    
    
###############################################################################################
## Reads the subset of the dataset from the dates 2007-02-01 and 2007-02-02 and Clean 
## the necessary plotting data
###############################################################################################

# Creats a message in the console to wait
message("Wait...")

# Reads the dataset
data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", stringsAsFactors=FALSE)
    
# Converts the Date column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
    
#Subset the required Dates and the necessary colums to plot
sub_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02", select = Date:Global_active_power)
    
# Remove data variable to release memory
rm(data)
    
# Converts Global Active Power Column in numeric data
sub_data$Global_active_power<-as.numeric(sub_data$Global_active_power)

###############################################################################################
## Creats, print a Plotting graphic in a PNG file with a width of 480px x height 480px
###############################################################################################
 
# Creats the X-axis based on the time column and the date column
x <- paste(sub_data$Date,sub_data$Time) # join date and Time columns
x <- strptime(x, format = "%Y-%m-%d %H:%M:%S") # converts to the date format

# Creats the Y-axis base on the Global_active_power variable
y <- sub_data$Global_active_power

# Plots X-Y with the draw type for lines, and sets labels
plot(x,y, type="l", xlab="", ylab="Global Active Power (Kilowatts)")

# Copy the Plotting to a PNG Device with the defined width and height
dev.copy(png, width = 480, height = 480, units = "px", file = "plot2.png")
    
# Closing the PNG device
invisible(dev.off())
message("Plot2 generated in the current working directory")
}