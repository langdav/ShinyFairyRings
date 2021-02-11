First draft of the data-visualization-App for the first station on the SENSO-Trail.

Current functions:
  - Choosing between two variables "Temperatur" and "Luftfeuchtigkeit"
  - Choosing a date; uses a calendar input (in this draft, only data for 2020-05-03 to 2020-05-05 are available; choosing other dates creates an error, as no data are available)
  - Choosing a time of day; uses a slider input (in this draft, you can change time in a two hour interval from 0 to 22 o'clock)
  - alternating one or more of the above mentioned values changes the descriptive text, the values printed in the image and the color scale gradient
  
Notes:
  - the position of values in the image represent the position of the respective measuring instruments in the tree
  - the color scale gradient represents the course of values in the tree: red (hottest/most humid) to yellow (coldes/least humid)
  - the used data are fake data, that were created randomly for testing and presentation purposes!
  
How to run:
  - open and run "start_here.R" 