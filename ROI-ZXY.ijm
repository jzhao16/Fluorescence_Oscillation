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

macro "ZXY-4" {
    height = getHeight(); // Returns the height in pixels of the current image.
    width = getWidth();  // Returns the width in pixels of the current image.
	labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";  // The Header is a 1-D array
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		labels[j+width*(i-1)] = "X" + toString(j-1) + "." + "Y" + toString(i-1); // Assign Header with each pixel X-Y coordinates label, the pixel is (j-1, i-1).
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

macro "ZXY-2" {
    height = getHeight(); // Returns the height in pixels of the current image.
    width = getWidth();  // Returns the width in pixels of the current image.
    labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";
    for (i=1; i<height+1; i++) {
        for (j=1; j<width+1; j++) {
            labels[j+width*(i-1)] = "X" + toString(j-1) + "." + "Y" + toString(i-1)+".BG"; // Assign Header with each pixel X-Y coordinates label, the pixel is (j-1, i-1).
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
                v = getPixel(j-1, i-1); // The pixel is (j-1, i-1).
                setResult(labels[j+width*(i-1)], slice, v); 
            }
        } 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}

