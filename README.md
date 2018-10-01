# Fluorescence Oscillation
Detect and analyze periodic oscillation of the fluorescene time-series signal.

## Table of Contents

**FluorescenceOscillation.Rmd** is the R markdown file that read the data files, conduct time-series analysis and display statistical plots. 

**ROI-ZXY.ijm** is the ImageJ script that extract pixel-wise time-series data. It contains four macros. 

**Cell-ROI** is the macro that outline the cellular region based on the z-stacks summation image (accumulated flurorescence). **ZXY-Cell-Crop** is the macro that extract the dataset for this image window. Each column of the Results Table contains a time-series datasets of the corresponding pixel. Row one contains the pixel coordinate, row two contains a indicator that tell whether this pixel is in the outlined ROI (1:Perpheral; 2:Cell). **ZXY-BG-Crop** is the macro that extract the dataset for this image window but without selection (whole crop window). This is used for extracting background dataset which is labeled with a indicator (0:BG). **ZXY-BG-Rec** is the macro that extract the dataset whithin this image window with a rectangle selection. This is used for extracting background dataset which is labeled with a indicator (0:BG). **TimeStamp** is the macro that extract time stamp, time interval between each frame (1/frame rate) and exposure time from the imaging stacks. 



