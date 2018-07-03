macro "Z-axis Profile in XY Plane Pixel-wise" {
	getSelectionBounds(xbase, ybase, width, height);  // get samllest rectangle that contains ROI
	labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		labels[j+width*(i-1)] = "X" + toString(xbase+j-1) + "-" + "Y" + toString(ybase+i-1); // Assign Header with each pixel X-Y coordinates label
    	}
    } 
    run("Clear Results");
    setResult(labels[0], 0, "Selection");  // Assign "Selection" row to indicate whether the pixel is in the cellular region (ROI)
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		if (selectionContains(j, i)) 
    			setResult(labels[j+width*(i-1)], 0, 1);  // Set value to 1 if yes
    		else
    			setResult(labels[j+width*(i-1)], 0, 0);  // Set value to 0 if no
    	}
    } 

    if (nSlices==1) exit("This macro requires a stack");  
    currentSlice = getSliceNumber();    // Acquire slice index (1)
    for (slice=1; slice <= nSlices; slice++) {   // $nSlices record the Z dimensions 
    	setSlice(slice);                // Jump to specific slide to read the X-Y pixel value
    	setResult(labels[0], slice, toString(slice));  // Add an entry to the results table, setResult (labels[x], y, entry), x, y starts from 0.
    	for (i=1; i<height+1; i++) {
    		for (j=1; j<width+1; j++) {
    			v = getPixel(xbase+j-1, ybase+i-1);
    			setResult(labels[j+width*(i-1)], slice, v); 
    		}
    	} 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}
