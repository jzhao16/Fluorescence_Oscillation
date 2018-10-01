// TimeStamp.ijm
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
