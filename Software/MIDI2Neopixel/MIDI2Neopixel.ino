// Developed in Arduino IDE 1.8.13 (Windows)

#include <FastLED.h> // FastLED version 3.3.3 https://github.com/FastLED/FastLED
#include "MIDIUSB.h" // MIDIUSB version 1.0.4 https://www.arduino.cc/en/Reference/MIDIUSB

#define BUTTON_PIN1 3
#define BUTTON_PIN2 2
#define LED_ACT_PIN 4
#define LED_PIN     5
#define NUM_LEDS    144
#define LED_TYPE    WS2812B
#define COLOR_ORDER GRB
#define AMPERAGE    1500     // Power supply amperage in mA

#define NOTE_OFFSET   29     // Offset of first note from left (depends on Piano)
#define LEDS_PER_NOTE 2      // How many LED are on per key
#define LED_INT_STEPS 8      // LED Intensity button steps

#define DEBUG

CRGB leds[NUM_LEDS];
byte color = 0xFFFFFF;
int ledProgram = 1;
int ledIntensity = 2;  // default LED brightness
int ledBrightness = ceil(255 / LED_INT_STEPS * ledIntensity); // default LED brightness
int buttonState1;
int buttonState2;
int lastButtonState1 = LOW;
int lastButtonState2 = LOW;
unsigned long lastDebounceTime1 = 0;
unsigned long lastDebounceTime2 = 0;
unsigned long debounceDelay = 50;

//------------------------------------------- FUNCTIONS ----------------------------------------------//

const char* pitch_name(byte pitch) {
  static const char* names[] = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
  return names[pitch % 12];
}

int pitch_octave(byte pitch) {
  return (pitch / 12) - 1;
}

void SetNote(byte pitch, CRGB color) {
  int b = 0;
  for (int a = 0; a < LEDS_PER_NOTE; a++) {
    //if (int(pitch) > 66){b=1;}else{b=0;} // led stripe solder joints compensation
    leds[(((pitch - NOTE_OFFSET)*LEDS_PER_NOTE)+ a - b)]= color;
  }
}

void SetNote2(byte pitch, int hue) {
  int b = 0;
  for (int a = 0; a < LEDS_PER_NOTE; a++) {
    //if (int(pitch) > 66){b=1;}else{b=0;} // led stripe solder joints compensation
    leds[(((pitch - NOTE_OFFSET)*LEDS_PER_NOTE)+a - b)].setHSV(hue, 255, 255);
  }
}

void noteOn(byte channel, byte pitch, byte velocity) {
  if (velocity > 0) {
    switch (channel) {

      // Left Hand
    case 144: // Default Channel is 144
    case 155:
    case 145 ... 149:
      if (ledProgram == 1){
        SetNote(pitch,0x0000FF);
      }else if (ledProgram == 2){
        SetNote(pitch,0x00FF00);
      }else if (ledProgram == 3){
        SetNote2(pitch,pitch*velocity);
      }else if (ledProgram == 4){
        SetNote2(pitch,velocity*2);
      }else if (ledProgram == 5){
        SetNote(pitch,0xFFFFFF);
      }else if (ledProgram == 6){
        SetNote2(pitch,ceil((pitch-NOTE_OFFSET) * (255/(NUM_LEDS/LEDS_PER_NOTE))));
      }else{
      }
      break;
      
      // Right Hand
    case 156:
    case 150 ... 154:
      SetNote(pitch,0x00FF00);
      break;
      
    default:
      SetNote(pitch,0xFFFFFF);
      break;
    }

    if (DEBUG == true){     Serial.println("Note ON   - Channel:" + String(channel) + " Pitch:" + String(pitch) + " Note:" + pitch_name(pitch) + String(pitch_octave(pitch)) + " Velocity:" + String(velocity)); }
  }else{   
    SetNote(pitch,0x000000); // black
    if (DEBUG == true){     Serial.println("Note OFF2 - Channel:" + String(channel) + " Pitch:" + String(pitch) + " Note:" + pitch_name(pitch) + String(pitch_octave(pitch)) + " Velocity:" + String(velocity)); }
  }
  FastLED.show();
}

void noteOff(byte channel, byte pitch, byte velocity) {
  if (ledProgram == 5){
    fill_rainbow( leds, NUM_LEDS, 0, 5);
  }else{
    SetNote(pitch,0x000000); // black
  }

  #ifdef DEBUG
  Serial.print("Note OFF  - Channel:");
  Serial.print(String(channel));
  Serial.print(" Pitch:");
  Serial.print(String(pitch));
  Serial.print(" Note:");
  Serial.print(pitch_name(pitch) + String(pitch_octave(pitch)));
  Serial.print(" Velocity:");
  Serial.println(String(velocity));
  #endif
  FastLED.show();
}

void controlChange(byte channel, byte control, byte value) {
  #ifdef DEBUG
  Serial.print("Control  - Channel:");
  Serial.print(String(channel));
  Serial.print(" Control:");
  Serial.print(String(control));
  Serial.print(" Value:");
  Serial.println(String(value));
  #endif
}

//-------------------------------------------- SETUP ----------------------------------------------//

void setup() {
  #ifdef DEBUG
  Serial.begin(115200);
  #endif
  delay( 3000 ); // power-up safety delay
  FastLED.setMaxPowerInVoltsAndMilliamps(5, AMPERAGE);
  pinMode(BUTTON_PIN1, INPUT_PULLUP);
  pinMode(BUTTON_PIN2, INPUT_PULLUP);
  pinMode(LED_ACT_PIN, OUTPUT);
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness(ledBrightness);
  fill_solid( leds, NUM_LEDS, CRGB(0,0,0));
  SetNote(NOTE_OFFSET+ledProgram-1,0xFF0000);
  FastLED.show();
  #ifdef DEBUG
  Serial.println("MIDI2Neopixel is ready!");
  #endif
}

//--------------------------------------------- LOOP ----------------------------------------------//
void loop() {
  ////////////////////////////////////////////// Button 1 /////////////////////////////////////////////

  int reading1 = digitalRead(BUTTON_PIN1);

  if (reading1 != lastButtonState1) {
    lastDebounceTime1 = millis();
  }

  if ((millis() - lastDebounceTime1) > debounceDelay) {
    if (reading1 != buttonState1) {
      buttonState1 = reading1;

      // only toggle the LED if the new button state is HIGH
      if (buttonState1 == LOW) {
        ledProgram++;
        if (ledProgram>6){
          ledProgram = 1;
        }
        if (DEBUG == true){     Serial.println("Button 1 pressed! Program is " + String(ledProgram)); }
        // Set LED indication for program
        fill_solid( leds, NUM_LEDS, CRGB(0,0,0));
        SetNote(NOTE_OFFSET+ledProgram-1,0xFF0000);
        FastLED.show();
      }
    }
  }

  ////////////////////////////////////////////// Button 2 /////////////////////////////////////////////

  int reading2 = digitalRead(BUTTON_PIN2);

  if (reading2 != lastButtonState2) {
    lastDebounceTime2 = millis();
  }

  if ((millis() - lastDebounceTime2) > debounceDelay) {
    if (reading2 != buttonState2) {
      buttonState2 = reading2;

      // only toggle the LED if the new button state is HIGH
      if (buttonState2 == LOW) {
        ledIntensity++;
        SetNote(NOTE_OFFSET+ledIntensity-2,0x000000);
        if (ledIntensity>LED_INT_STEPS){
          ledIntensity = 1;
        }
        // Map ledIntensity to ledBrightness
        ledBrightness = map(ledIntensity, 1, LED_INT_STEPS, 3, 255);
        FastLED.setBrightness(ledBrightness);
        #ifdef DEBUG
        Serial.print("Button 2 pressed! Intensity is ");
        Serial.print(String(ledIntensity));
        Serial.print(" and brightness to ");
        Serial.print(String(ledBrightness));
        #endif
        // Set LED indication for program
        SetNote(NOTE_OFFSET+ledIntensity-1,0x00FF00);
        FastLED.show();
      }
    }
  }

  ////////////////////////////////////////// MIDI Read routine ////////////////////////////////////////
  midiEventPacket_t rx = MidiUSB.read();
  if (rx.header) {digitalWrite(LED_ACT_PIN, HIGH);}
  switch (rx.header) {
  case 0:
    break; //No pending events
    
  case 0x9:
    noteOn(rx.byte1,rx.byte2,rx.byte3);
    break;
    
  case 0x8:
    noteOff(rx.byte1,rx.byte2,rx.byte3);
    break;
    
  case 0xB:
    controlChange(rx.byte1 & 0xF,rx.byte2,rx.byte3);
    break;
    
  default:
    #ifdef DEBUG
    Serial.print("Unhandled MIDI message: ");
    Serial.print(rx.header, HEX);
    Serial.print("-");
    Serial.print(rx.byte1, HEX);
    Serial.print("-");
    Serial.print(rx.byte2, HEX);
    Serial.print("-");
    Serial.println(rx.byte3, HEX);
    #endif
    break;
  }


  if (rx.header) {digitalWrite(LED_ACT_PIN, LOW);}
  lastButtonState1 = reading1;
  lastButtonState2 = reading2;
}
//------------------------------------------ END OF LOOP -------------------------------------------//
