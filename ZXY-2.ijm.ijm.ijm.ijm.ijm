macro "Z-axis Profile in XY Plane Pixel-wise" {
	getSelectionBounds(xbase, ybase, width, height);  // Rectangle ROI
	labels = newArray(width*height+1);  // Set up Header with specific length
    labels[0] = "X-Y";
    for (i=1; i<height+1; i++) {
    	for (j=1; j<width+1; j++) {
    		labels[j+width*(i-1)] = toString(xbase+j-1)+"-"+toString(ybase+i-1); // Assign Header with each pixel X-Y coordinates label
    	}
    } 
    run("Clear Results");

    if (nSlices==1) exit("This macro requires a stack");  
    currentSlice = getSliceNumber();    // Acquire slice index (1)
    for (slice=1; slice <= nSlices; slice++) {   // $nSlices record the Z dimensions 
    	setSlice(slice);                // Jump to specific slide to read the X-Y pixel value
    	setResult(labels[0], slice-1, toString(slice));
    	for (i=1; i<height+1; i++) {
    		for (j=1; j<width+1; j++) {
    			v = getPixel(xbase+j-1, ybase+i-1);
    			setResult(labels[j+width*(i-1)], slice-1, v);
    		}
    	} 
    }
    setSlice(currentSlice);   // Return to first slide
    updateResults();          // Display Results table
}

 
