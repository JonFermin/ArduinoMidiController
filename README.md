# Arduino MIDI CC Controller

![FullSizeRender](https://jonfermin.files.wordpress.com/2018/03/fullsizerender.jpg?w=2048) This project was born out of the fact that midi controllers are overpriced and often have too many knobs to be approachable. Micro controllers have relatively simple wiring that can produce effective, and most importantly, customizable midi controllers. This project explores a USB to Mini USB implementation that takes advantage of Serial to OSC communication to send MIDI CC values over to FL Studio. ![FullSizeRender-1.jpg](https://jonfermin.files.wordpress.com/2018/03/fullsizerender-1.jpg) Here's a video of the final product in action. The mappings of each of the knobs can be customized, making a single knob control multiple outputs, inverting the controls, or simply selecting new effects. You can link to any FL studio controller or VST, simply by right clicking and selecting 'Link to Controller.' [vimeo 260507716 w=640 h=360]

### Hardware

*   3 Rotary Potentiometer
*   2 Slide Potentiometer (Fader)
*   3 Silver Metal Knob
*   2 Slide Potentiometer Knobs
*   Plywood for Enclosure

### Software

*   Wekinator
*   Arduino IDE
*   Processing
*   Audio MIDI Setup

### Circuitry

Refer to Lab 3, an older post on this blog, for the information on the basics of hooking up potentiometers.

The following circuit diagram below shows the five potentiometers hooked up to analog inputs A0 - A4\. Each potentiometer has 3 pins. For rotary potentiometers, the outer pins connect to GND or 5V, and the middle pin connects to an Analog Input. The sliders are numbered, and pins 1 and 3 connect to GND and 5V, while pin 2 connects to an Analog Input.

![PotDiagram.png](https://jonfermin.files.wordpress.com/2018/03/potdiagram.png)

![IMG_0156.jpg](https://jonfermin.files.wordpress.com/2018/03/img_0156.jpg)

### Code

I attempted to use the midi and midi-usb Arduino libraries, however I soon realized that there were various limitations to both of these options. The midi library requires a midi in port to be installed in the circuit itself. Due to not foreseeing this problem, I didn’t order the midi jack in time. This is also unattractive, as newer midi controllers are plug and play with a USB port. The midi usb library changes the use of the micro usb cord, so in most orientations, you cannot upload to the board without re-flashing the original Arduino hex file.

Therefore serial to midi communication is probably the most effective output. I accomplished this through a tool called Wekinator. Rebecca Fiebrink produced this tool for machine learning interfaces, but this tool is proven to be effective for. The first processing sketch parses the serial information, delimiting by commas. 5 inputs come in, due to the 5 potentiometers, and<span class="Apple-converted-space"></span> Eventually, I would have liked to output the serial information, parsed it, and sent it straight to midi. However, the benefit of this orientation, is that the controls can be mapped non linearly, inverted, etc. Credit goes to Fiebrink for the following code that parses Serial to OSC.

1: Check for the potentiometer and fader values through an Analog input.

*   5V - Potentiometer
*   Route pin A0 to this circuit before it touches ground

2: Output through a serial port (9600), and parse to OSC by delimiting by commas and new lines. 3.  Send OSC message to Wekinator, which will map the values using regression 4\. Output the values to a MIDI continuous control channel using the Audio Midi Setup application, creating a new MIDI 'bus' 5\. Link the values of certain knobs/faders in FL Studio to the Midi Controller, using the proper channel and https://gist.github.com/JonFermin/61300296840592c0145220e9fb7c3fa2 This outputs values such as "554, 1023, 849, 700, 200" into the serial port. The important part of the processing sketch is located here, where it parses through the port 9600 and takes in the values to the 'a' array: https://gist.github.com/JonFermin/cb4e53731fb093b2b68b20661953c1cc [Link to the Entire Github Repository](https://github.com/JonFermin/ArduinoMidiController)

### Improvements

Eventually, it would be nice to implement all of this onto a single, mapped processing sketch that takes the input of the Serial potentiometers and simply crafts a 0-127 midi message to send to One of the bigger problems I ran into for this project was related to fabrication. The creative enclosure should be at the forefront of physical computing, rather than an afterthought. I've found after this project, that the software elements for most projects are simpler, rather than complicated. For my Project 2, I will try to focus on a visually appealing project that can be considered 'solid.' For the following project, I will focus on fabrication. Feedback and interaction should be at the forefront of designing physical computing projects, and while interesting prototypes can be made, the polished projects are often the most impressive. My goal is to put something in front of a future user that is self explanatory and visually interesting.


## Blog Post
[Link to My Blog](https://jonfermin.wordpress.com/2018/03/15/project-1/)
