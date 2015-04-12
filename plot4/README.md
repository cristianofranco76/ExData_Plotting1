## About the function plot4.R

This plot4 function uses data from the <a href="http://archive.ics.uci.edu/ml/"> 
UC Irvine Machine Learning Repository</a>, in particular the “Individual household 
Electric power consumption Data Set”. The dataset has 2,075,259 rows and 9 columns 
with Measurements of electric power consumption in one household with a one-minute 
sampling rate over a period of almost 4 years. 

The function reads the dataset "household_power_consumption.txt" in the
current Working directory, construct & print 4 graphics in on X-Y Plotting based on 
Global Active Power, Voltage, Energy Sub metering (3 variables Sub_metering as done for plot3) and
Global Reactive Power over the time.

The script generates the graphic to a PNG file called <b>"plot4.png"</b> with a width of 480px x height 480 px.

<b><i>This function requires data.table package due to the fread() function that performs better 
than the read.table() </b></i>

The function subsets the data from the dates 2007-02-01 and 2007-02-02. It cleans the variables
retrieved to Date & Numeric formats. 

<b><i>IMPORTANT NOTE:</b></i> The dataset represents a large table. Therefore as rough estimation, 
considering 8bytes each numeric value, requests at least 
(2,075,259 rows) x (9 columns x 8bytes) x 2 times / (10^-9 Gbytes) = <b>0,30 Gbytes</b> 
of free memory in the computer.

Main steps of the functions:

1) Check the existance of the file household_power_consumption.txt in the current Working Directory

	* list all the files of the current directory
	* check if the file exists
	* if file does not exist in the current working directory returns an error message
	* remove temporary variables

2) Reads the subset of the dataset from the dates 2007-02-01 and 2007-02-02 and Clean 
the necessary plotting data
 
	* creats a message in the console to wait
	* reads the dataset
	* converts the Date column
	* subset the required Dates and the necessary colums to plot
	* remove data variable to release memory
	* converts variables from character to numeric data

3) Creats, print a Plotting graphic in a PNG file with a width of 480px x height 480px

	* Open the Plotting to a PNG Device with the defined width and height
	* Set Base plotting system parameter to plot 4 diferent graphics in the same page
	* Creats the X-axis based on the time column and the date column
	* Creats the Y-axis base on the variables
	* Plots the #1 Graphic > Global Active Time x Time
	* Plots the #2 Graphic > Voltage x Time
	* Plots the #3 Graphic > Sub_meterings vs Time
		* Plots X-Y1 with the draw type for lines, color black and sets labels (Y1 = Sub_metering_1)
		* Plots X-Y2 with the lines function - color red (Y2 = Sub_metering_2)
		* Plots X-Y3 with lines function - color blue (Y3 = Sub_metering_3)
		* Creates the legends for all the variables with corresponding colors
	* Plots the #4 Graphic > Sub_meterings vs Time
	* Closes the PNG device and genarates a message to the console: 
	"Plot4 generated in the current working directory"

Ps. There is a sample of the PNG file created by the function in this repo.
