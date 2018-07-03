macro "CellOutline" {
	name = getTitle();    // Get the filename of current window
	selectWindow(name);   // Select current window
	run("Duplicate...", "duplicate range=1-1");  // Make a duplicate of stack 1
	setAutoThreshold("Default dark");  // Set auto threshold with a default dark
	run("Threshold...");   
	run("Analyze Particles...", "size=30-150 display clear include summarize add");  // Run "Add Particle" algorithm to outline the cell 
	selectWindow(name);   // Jump back to main window
	roiManager("Select", 0);  // Display the ROI on the main image window
}
