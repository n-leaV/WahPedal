**Wah Pedal**



Project to Design and Build a Wah Pedal. This project consists of a variable center frequency bandpass filter. Most of the project design is centered around the LTC1067-50. 



From the LTC1067 data sheet, "The LTC ®

1067/LTC1067-50 consist of two identical rail to-rail, high accuracy and very wide dynamic range 2nd order switched-capacitor building blocks. Each building block, together with three to five resistors, provides 2nd order filter functions such as bandpass, highpass, lowpass, notch and allpass. High precision 4th order filters are easily designed."



The LTC1067-50 allows for construction of two two-integrator-loop biquads. The biquads are structured to provide a 4th order bandpass filter. Due to the nature of the chip(Switched Capacitor), the center frequencies of the biquads can be controlled via an input clock frequency. Ideally the Q factor of the filter can also be controlled via a potentiometer.



**Files**



Filter.m

&#x09;"Transfer function modeling of the bandpass filter via LTC1067-50"

