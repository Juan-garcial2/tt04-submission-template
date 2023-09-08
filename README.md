![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)

# Frequency meter

This project is a frequency meter up to 10Khz.


## GPIO Pins.

The input and output pins play crucial roles in the functionality of the clock, contributing to its operation and configuration. Below is the function assignment for each of the pins:

Input Pins: 

- data_in: 12-bit vector coming from an ADC.
- 
Output Pins: 

- segments: The "segments" pin controls the activation of individual segments in the 7-segment displays. By manipulating this pin, the necessary segments are turned on or off to form digits and characters on the displays.
- display_select [1:0]: These output pins determine which display should be activated at a given moment in the multiplexed configuration. Different values of these pins will select the specific digit to be displayed at that instant.
- segment_select [2:0]: These pins control the selection of segments within the active display. By changing the values of these pins, specific segments are activated or deactivated, allowing for the display of different numbers and characters on the clock.

 

