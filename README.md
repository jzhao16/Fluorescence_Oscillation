# Fluorescence_Oscillation
Detect and analyze fluorescence oscillation in the time domain.

## Table of Contents

**FluorescenceOscillation.Rmd** is the R markdown file that read the data files, conduct time-series analysis and display statistical plots. 

**ROI-ZXY.ijm** is the ImageJ script that extract pixel-wise time-series data. It contains three macros. **Cell-ROI** is the macro that outline the cellular region. **ZXY-4** is the macro that extract the dataset for this image window. Each column of the Results table contains a time-series datasets of the corresponding pixel. Row one contains the pixel coordinate, row two contains a indicator that tell whether this pixel is in the outlined ROI (0:not; 1:yes). **ZXY-2** is the macro that extract the dataset for this image window but without selection (ROI). This is used for extracting Background dataset. 



