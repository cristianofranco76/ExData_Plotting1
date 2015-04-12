plot3 <- function() { 
    
############################################################################################## 
##
## This plot3 function uses data from the UC Irvine Machine Learning Repository, 
## in particular the “Individual household electric power consumption Data Set”
## 
## The function reads the dataset "household_power_consumption.txt" in the
## current Working directory, construct & print a X-Y Plotting based on 3 variables Sub_metering*
## over the time:
##
## Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
##
## The script copies the graphic to a PNG file called "plot3.png" with a width of 480px x height 480 px.
##
## This function requires data.table package due to the fread() function that performs better 
## than the read.table()
## 
## The dataset has 2,075,259 rows and 9 columns with Measurements of electric
## power consumption in one household with a one-minute sampling rate over a
## period of almost 4 years. 
##
## The function subsets the data from the dates 2007-02-01 and 2007-02-02. It cleans the variables
## retrieved to Date & Numeric formats. The columns Sub_metering are selected to plot 
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
    
# Reads the dataset using fread from the data.table package
# the warnings are suppressed due to the missing values "?" converted to NA
require("data.table")
suppressWarnings(data <- fread("household_power_consumption.txt",sep=";",na.strings="?"))
    
# Converts the Date column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
    
#Subset the required Dates and the necessary colums to plot
sub_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02", select = c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))
    
# Remove data variable to release memory
rm(data)
    
# Converts Sub_metering variables in numeric data
sub_data$Sub_metering_1<-as.numeric(sub_data$Sub_metering_1)
sub_data$Sub_metering_2<-as.numeric(sub_data$Sub_metering_2)
sub_data$Sub_metering_3<-as.numeric(sub_data$Sub_metering_3)
    
###############################################################################################
## Creats, print a Plotting graphic in a PNG file with a width of 480px x height 480px
###############################################################################################
    
# Creats the X-axis based on the time column and the date column
x <- paste(sub_data$Date,sub_data$Time) # join date and Time columns
x <- strptime(x, format = "%Y-%m-%d %H:%M:%S") # converts to the date format
    
# Creats the Y-axis base on the Sub_metering variables
y1 <- sub_data$Sub_metering_1
y2 <- sub_data$Sub_metering_2
y3 <- sub_data$Sub_metering_3

# Open the Plotting to a PNG Device with the defined width and height
png(filename = "plot3.png",width = 480, height = 480, units = "px")

# Plots X-Y1 with the draw type for lines, color black and sets labels
plot(x,y1, type="l", xlab="", ylab="Energy Sub metering", col="black")
    
# Plots X-Y2 with the lines function - color red 
lines(x,y2, col="red")

# Plots X-Y3 with lines function - color blue
lines(x,y3, col="blue")

# Creates the legends for all the variables with corresponding colors
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue"))

# Closing the PNG device
invisible(dev.off())
    message("Plot3 generated in the current working directory")
}