# MIDI2Neopixel - Piano LED Visualizer - Software

## Build and upload via Arduino IDE

1. Download prerequisities from https://github.com/FastLED/FastLED (version 3.3.3) and https://www.arduino.cc/en/Reference/MIDIUSB (version 1.0.4) to `Arduino/libraries` folder or via `Tools/Manage libraries` menu in IDE. 

2. Open source code in IDE and hit `Upload` button.

**Note:** If you want to use different USB device name instead of `Arduino Leonardo`, replace existing Arduino Leonardo name deffinition in `C:\Program Files (x86)\Arduino\hardware\arduino\avr\boards.txt` with `leonardo.name=MIDI2Neopixel` and `leonardo.build.usb_product="MIDI2Neopixel"`. Upload code, uninstall device `Arduino Leonardo` in Windows Device Manager and replug USB cable.


## Flash precompiled HEX to Arduino

If you have problem to compile code in Arduino IDE, you can directly flash precompiled firmware to `Arduino pro micro` board.

**Example:** `C:\Program Files (x86)\Arduino\hardware\tools\avr/bin/avrdude -CC:\Program Files (x86)\Arduino\hardware\tools\avr/etc/avrdude.conf -v -patmega32u4 -cavr109 -PCOM2 -b57600 -D -Uflash:w:MIDI2Neopixel.ino.hex:i`


