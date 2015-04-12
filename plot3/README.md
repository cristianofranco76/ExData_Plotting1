## About the function plot3.R

This plot3 function uses data from the <a href="http://archive.ics.uci.edu/ml/"> 
UC Irvine Machine Learning Repository</a>, in particular the “Individual household 
Electric power consumption Data Set”. The dataset has 2,075,259 rows and 9 columns 
with Measurements of electric power consumption in one household with a one-minute 
sampling rate over a period of almost 4 years. 

The function reads the dataset <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">"household_power_consumption.txt"</a> 
in <b>the current Working directory</b>, construct & print a <b>X-Y Plotting</b> based on tn 3 variables <b>Sub_metering</b>
over the time:

* Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
* Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
* Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

The script copies the graphic to a PNG file called "plot3.png" with a width of 480px x height 480 px.

<b><i>This function requires data.table package due to the fread() function that performs better 
than the read.table() </b></i>

The function subsets the data from the dates 2007-02-01 and 2007-02-02. It cleans the variables
retrieved to Date & Numeric formats. The columns Sub_metering are selected to plot the Y-axis.

<b><i>IMPORTANT NOTE:</b></i> The dataset represents a large table. Therefore as rough estimation, 
considering 8bytes each numeric value, requests at least 
(2,075,259 rows) x (9 columns x 8bytes) x 2 times / (10^-9 Gbytes) = <b>0,30 Gbytes</b> 
of free memory in the computer.

Main steps of the functions

1) Check the existance of the file household_power_consumption.txt in the current Working Directory

	* list all the files of the current directory
	* check if the file exists
	* if file does not exist in the current working directory returns an error message
	* remove temporary variables

2) Reads the subset of the dataset from the dates 2007-02-01 and 2007-02-02 and Clean 
the necessary plotting data
 
	* reads the dataset
	* converts the Date column
	* subset the required Dates and the necessary colums to plot
	* remove data variable to release memory
	* converts Sub_metering variables in numeric data

3) Creats, print a Plotting graphic in a PNG file with a width of 480px x height 480px

	* Creats the X-axis based on the time column and the date column
	* Creats the Y-axis base on the Sub_metering variables
	* Open the Plotting to a PNG Device with the defined width and height 
	* Plots X-Y1 with the draw type for lines, color black and sets labels (Y1 = Sub_metering_1)
	* Plots X-Y2 with the lines function - color red (Y2 = Sub_metering_2)
	* Plots X-Y3 with lines function - color blue (Y3 = Sub_metering_3)
	* Creates the legends for all the variables with corresponding colors
	* Closes the PNG device

Ps. There is a sample of the PNG file created by the function in this repo.
