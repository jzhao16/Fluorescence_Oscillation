# Fluorescence_Oscillation
Detect and analyze fluorescence oscillation in the time domain

## Table of Contents

**FluorescenceOscillation.Rmd** is the R markdown file that read the dataframes, conduct analysis and display statistical plots. 

**ZXY-4.ijm** is the ImageJ scirpt (Java) for extracting the dataframes from a rectangle window. This window is the samllest window contais the ROI (any shape). Each column of the Results table not only contains a time-series but also has a indicator at the beginning indicates that whether the pixel is in the ROI. 

**Cell-ROI.ijm** is the ImageJ script (Java) for outline the cell.

## Miscellaneous

**ZXY-2.ijm** is the ImageJ scirpt (Java) for extracting the dataframes from the rectangle ROI (Required!!). Each column is a time-series for a specific pixel.




