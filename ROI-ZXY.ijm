macro "Cell-ROI" {
	name = getTitle();    // Get the filename of current window
	selectWindow(name);   // Select current window
    run("Z Project...", "projection=[Sum Slices]"); // Calcualte the summation image of all slices 
	setAutoThreshold("Default dark");  // Set auto threshold with a default dark
	run("Threshold...");   
	run("Analyze Particles...", "size=30-150 display clear include summarize add");  // Run "Add Particle" algorithm to outline the cell based on the summation image
	selectWindow(name);   // Jump back to main window
	roiManager("Select", 0);  // Display the ROI on the main image window
}

macro "ZXY-Cell-Crop" {
    height = getHeight(); // Returns the height in pixels of the current image
    width = getWidth();  // Returns the width in pixels of the current image
	labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";  // The Header is a 1-D array
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		labels[j+width*(i-1)] = "X" + toString(j-1) + "." + "Y" + toString(i-1); // Assign Header with each pixel "X-Y" coordinates label, the pixel is (j-1, i-1).
    	}
    } 
    run("Clear Results");
    setResult(labels[0], 0, "Selection");  // Assign "Selection" row to indicate whether the pixel is in the cellular region (ROI)
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		if (selectionContains(j-1, i-1)) // The pixel is (j-1, i-1).
    			setResult(labels[j+width*(i-1)], 0, 2);  // Set value to 2 if pixel is in the selection
    		else
    			setResult(labels[j+width*(i-1)], 0, 1);  // Set value to 1 if pixel is not in the selection
    	}
    } 

    if (nSlices==1) exit("This macro requires a stack");  
    currentSlice = getSliceNumber();    // Acquire slice index (1)
    for (slice=1; slice <= nSlices; slice++) {   // $nSlices record the Z dimensions 
    	setSlice(slice);                // Jump to specific slide to read the X-Y pixel value
    	setResult(labels[0], slice, toString(slice));  // Add an entry to the results table, setResult (labels[x], y, entry), x, y starts from 0.
    	for (i=1; i<height+1; i++) {
    		for (j=1; j<width+1; j++) {
    			v = getPixel(j-1, i-1);  // The pixel is (j-1, i-1).
    			setResult(labels[j+width*(i-1)], slice, v); 
    		}
    	} 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}

macro "ZXY-BG-Crop" {
    height = getHeight(); // Returns the height in pixels of the current image
    width = getWidth();  // Returns the width in pixels of the current image
    labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";
    for (i=1; i<height+1; i++) {
        for (j=1; j<width+1; j++) {
            labels[j+width*(i-1)] = "X" + toString(j-1) + "." + "Y" + toString(i-1)+".BG"; // Assign Header with each pixel "X-Y.BG" coordinates label, the pixel is (xbase+j-1, ybase+i-1).
        }
    } 
    run("Clear Results");
    setResult(labels[0], 0, "Selection");  // Assign "Selection" row to indicate whether the pixel is in the cellular region (ROI)
    for (i=1; i<height+1; i++) {
        for (j=1; j<width+1; j++) {
            setResult(labels[j+width*(i-1)], 0, 0);  // Set all values to 0 
        }
    } 

    if (nSlices==1) exit("This macro requires a stack");  
    currentSlice = getSliceNumber();    // Acquire slice index (1)
    for (slice=1; slice <= nSlices; slice++) {   // $nSlices record the Z dimensions 
        setSlice(slice);                // Jump to specific slide to read the X-Y pixel value
        setResult(labels[0], slice, toString(slice));  // Add an entry to the results table, setResult (labels[x], y, entry), x, y starts from 0.
        for (i=1; i<height+1; i++) {
            for (j=1; j<width+1; j++) {
                v = getPixel(j-1, i-1); // The pixel is (xbase+j-1, ybase+i-1).
                setResult(labels[j+width*(i-1)], slice, v); 
            }
        } 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}



macro "ZXY-BG-Rec" {
    getSelectionBounds(xbase, ybase, width, height);  // Obtain width and height of the rectangle selection 
    labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";
    for (i=1; i<height+1; i++) {
        for (j=1; j<width+1; j++) {
            labels[j+width*(i-1)] = "X" + toString(xbase+j-1) + "." + "Y" + toString(ybase+i-1)+".BG"; // Assign Header with each pixel "X-Y.BG" coordinates label, the pixel is (xbase+j-1, ybase+i-1).
        }
    } 
    run("Clear Results");
    setResult(labels[0], 0, "Selection");  // Assign "Selection" row to indicate whether the pixel is in the cellular region (ROI)
    for (i=1; i<height+1; i++) {
        for (j=1; j<width+1; j++) {
            setResult(labels[j+width*(i-1)], 0, 0);  // Set all values to 0 
        }
    } 

    if (nSlices==1) exit("This macro requires a stack");  
    currentSlice = getSliceNumber();    // Acquire slice index (1)
    for (slice=1; slice <= nSlices; slice++) {   // $nSlices record the Z dimensions 
        setSlice(slice);                // Jump to specific slide to read the X-Y pixel value
        setResult(labels[0], slice, toString(slice));  // Add an entry to the results table, setResult (labels[x], y, entry), x, y starts from 0.
        for (i=1; i<height+1; i++) {
            for (j=1; j<width+1; j++) {
                v = getPixel(xbase+j-1, ybase+i-1); // The pixel is (xbase+j-1, ybase+i-1).
                setResult(labels[j+width*(i-1)], slice, v); 
            }
        } 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}

macro "TimeStamp" {
    run("Bio-Formats Macro Extensions");
id = File.openDialog("Choose a file");
open(id);
Ext.setId(id);
Ext.getImageCount(imageCount);
print("Plane count: " + imageCount);

deltaT = newArray(imageCount);
TimeInterval = newArray(imageCount-1);
exposureTime = newArray(imageCount);
labels = newArray(3);
labels[0] = "TimeStamp (ms)"
labels[1] = "Time Interval (ms)"
labels[2] = "Exposure Time (ms)"

for (slice=0; slice<imageCount; slice++) {
    Ext.getPlaneTimingDeltaT(deltaT[slice], slice);
    Ext.getPlaneTimingExposureTime(exposureTime[slice], slice);
    if (deltaT[slice] == deltaT[slice]) { // not NaN
        setResult(labels[0], slice, deltaT[slice]*1000);
        if (slice == 0) {
        setResult(labels[1], slice, NaN); //set first frame time interval to NaN
    } else {
        setResult(labels[1], slice, deltaT[slice]*1000-deltaT[slice-1]*1000);
        TimeInterval[slice-1] = deltaT[slice]*1000-deltaT[slice-1]*1000;
    }
    }
    
    if (exposureTime[slice] == exposureTime[slice]) { // not NaN
        setResult(labels[2], slice, exposureTime[slice]);
    }
}
updateResults();          // Display Results table


Array.getStatistics(TimeInterval, min, max, mean, std);
print("Time Interval Statistics");
print("   min: "+min);
print("   max: "+max);
print("   mean: "+mean);
print("   std dev: "+std);

}

