IPRO Confluency Shiny R App
The Image Analysis Shiny App is a web-based application built using the R Shiny framework, designed for analyzing images and quantifying the cell coverage within them. This app provides an interactive platform to perform image processing, edge detection, and labeling, enabling users to quickly assess the extent of cell coverage in various images.

Features
Image Loading: Users can upload individual image files or select an entire directory containing images for analysis.
Image Inversion: Users have the option to invert image colors before processing, allowing for flexibility in handling images with different background colors.
Alpha Value Adjustment: Users can adjust the alpha value to control the sensitivity of edge detection, fine-tuning the analysis based on their specific images.
Real-time Image Display: The app displays the loaded image in real-time, reflecting any adjustments made to inversion or alpha value.
Image Analysis: The app performs edge detection using the Canny algorithm and fills gaps in the detected edges. It calculates and presents the cell coverage percentage based on the filled areas.
Interactive Plots: Users can visualize the original image, the edge detection result, and the filled-in regions to observe the effect of image processing.
Download PDF Report: Users can download a PDF report summarizing the analysis results, including the image filename, alpha value, and cell coverage percentage.
How to Use
Upload an image file or select a directory containing images.
Optionally, invert image colors if the background is not white.
Adjust the alpha value to control edge detection sensitivity.
Click the "Analyze" button to perform image analysis.
View the original image, edge detection result, and filled-in regions.
Download a PDF report summarizing the analysis results.
Purpose
The Image Analysis Shiny App is intended for researchers, scientists, and professionals working in fields such as biology, medicine, and image processing. It provides a user-friendly interface to quickly assess and quantify cell coverage in images, helping researchers analyze experimental data and make informed decisions.

Getting Started
To use the app:
1). Visit https://ipro-confluencyapp.shinyapps.io/ccapp/
      or
2). Simply clone or download the repository, ensure you have the {imager, dplyr, and shiny} R packages installed, and run the app using RStudio or an R environment. The app can be accessed via a web browser, allowing for easy analysis of images.

Explore the potential of the Image Analysis Shiny App to streamline your image processing workflow and gain valuable insights from your visual data.

Feel free to modify and customize the description to suit your preferences and provide additional details about the app's functionalities and potential applications.
