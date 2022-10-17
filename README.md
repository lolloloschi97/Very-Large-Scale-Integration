# Very Large Scale Integration
### Description of the Problem
VLSI (Very Large Scale Integration) refers to the trend of integrating circuits into silicon chips. This enabled the modern cell phone to mature into a powerful tool that shrank from the size of a large brick-sized unit to a device small enough to comfortably carry in a pocket or purse, with a video camera, touchscreen and other advanced features. <br/>
Given a fixed-width plate and a list of rectangular circuits, we had to decide how to place them on the plate so that the length of the nal device is minimized. In order for the device to work properly, each circuit must be placed in a fixed orientation with respect to the others, therefore it cannot be rotated.<br/>
We have decided to manage this problem using CP (with MiniZinc) and SMT (with the Python library z3). <br/>

### CP Solution

<br/>
<p align="center">
  <img src="https://github.com/lolloloschi97/Very-Large-Scale-Integration/blob/main/image1.jpg" width=30% height=30% class="center">
</p>
<br/>


### SMT Solution

<br/>
<p align="center">
  <img src="https://github.com/lolloloschi97/Very-Large-Scale-Integration/blob/main/image2.jpg" width=30% height=30% class="center">
</p>
<br/>
