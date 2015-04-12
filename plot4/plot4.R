plot4 <- function() { 
    
############################################################################################## 
##
## This plot4 function uses data from the UC Irvine Machine Learning Repository, 
## in particular the “Individual household electric power consumption Data Set”
## 
## The function reads the dataset "household_power_consumption.txt" in the
## current Working directory, construct & print 4 graphics in on X-Y Plotting based on 
## Global Active Power, Voltage, Energy Sub metering (3 variables Sub_metering - from plot3) and
## Global Reactive Power over the time.
##
## The script generates the graphic to a PNG file called "plot4.png" with a width of 480px x height 480 px.
##
## This function requires data.table package due to the fread() function that performs better 
## than the read.table()
## 
## The dataset has 2,075,259 rows and 9 columns with Measurements of electric
## power consumption in one household with a one-minute sampling rate over a
## period of almost 4 years. 
##
## The function subsets the data from the dates 2007-02-01 and 2007-02-02. It cleans the variables
## retrieved to Date & Numeric formats.
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
    
#Subset the required Dates
sub_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02", select = -Global_intensity)
    
# Remove data variable to release memory
rm(data)
    
# Converts variables from character to numeric data
sub_data$Global_active_power<-as.numeric(sub_data$Global_active_power)
sub_data$Global_reactive_power<-as.numeric(sub_data$Global_reactive_power)
sub_data$Voltage<-as.numeric(sub_data$Voltage)
sub_data$Sub_metering_1<-as.numeric(sub_data$Sub_metering_1)
sub_data$Sub_metering_2<-as.numeric(sub_data$Sub_metering_2)
sub_data$Sub_metering_3<-as.numeric(sub_data$Sub_metering_3)
    
###############################################################################################
## Creats, print a Plotting graphic in a PNG file with a width of 480px x height 480px
###############################################################################################
    
# Open the Plotting to a PNG Device with the defined width and height
png(filename = "plot4.png",width = 480, height = 480, units = "px")

# Set Base plotting system parameter to plot 4 diferent graphics in the same page
par(mfrow=c(2,2))

# Creats the X-axis based on the time column and the date column
x <- paste(sub_data$Date,sub_data$Time) # join date and Time columns
x <- strptime(x, format = "%Y-%m-%d %H:%M:%S") # converts to the date format

# Creates the Y-axis based on the variables
y_active<-sub_data$Global_active_power
y_voltage<-sub_data$Voltage
y_met1 <- sub_data$Sub_metering_1
y_met2 <- sub_data$Sub_metering_2
y_met3 <- sub_data$Sub_metering_3
y_react <- sub_data$Global_reactive_power
    
# Plots the #1 Graphic > Global Active Time x Time
plot(x,y_active, type="l", xlab="",ylab="Global Active Power",col="black")

# Plots the #2 Graphic > Voltage x Time
plot(x,y_voltage, type="l", xlab="datetime",ylab="Voltage",col="black")

    
# Plots the #3 Graphic > Sub_meterings vs Time
    
    # Plots X-Sub_Metering_1 with the draw type for lines, color black and sets labels
    plot(x,y_met1, type="l", xlab="", ylab="Energy Sub metering", col="black")
    
    # Plots X-Sub_Metering_2 with the lines function - color red 
    lines(x,y_met2, col="red")
    
    # Plots X-Y3 with lines function - color blue
    lines(x,y_met3, col="blue")
    
    # Creates the legends for all the variables with corresponding colors
    legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue"))
    
# Plots the #4 Graphic > Sub_meterings vs Time
plot(x,y_react, type="l", xlab="datetime",ylab="Global_reactive_power", col="black")

# Closing the PNG device
invisible(dev.off())
message("Plot4 generated in the current working directory")
}