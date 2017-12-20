# raspberry_playground
This project is for me to play around with a Raspberry Pi.  Anyone is welcome to contribute, as this is more of a learning experience than anything else!

# Long Term Plan
This will have code that will handle routines for a bartending robot to perform.

# Current Progress
Added [Adafruit Python Library for DC + Stepper Motor HAT](https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library/) as a submodule, which will basically serve as our driver to control one or more motor HATs (as needed).  In order to use, run "ez_setup.py" on the Raspberry Pi you want to build/run this project on.

Added [Perfect Python](https://github.com/PerfectlySoft/Perfect-Python.git) as a Swift Package Manager dependency, which is used to load Python modules/classes/functions/etc.  Unfortunately, it doesn't strongly type the classes/functions (nor would a reasonable person expect them to), so we have to wrap these PyObj's in Swift classes to interact with them in a more swifty fashion.

With the two libraries above, in addition to some classes wrapping our Python objects for easier interaction, we now have a MotorSpinner Routine that simply lets the user set a motor's speed variably from 0-255.  It's more of a proof of concept for controlling a motor than anything else.  The instructions contained within could be used to control a pump, stopping when a certain threshold is achieved, possibly through use of a flow controller or a simple scale (both with predetermined measures).
