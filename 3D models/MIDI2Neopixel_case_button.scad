// MIDI2Neopixel case button
// by stanoba http://www.thingiverse.com/stanoba/about
// https://www.thingiverse.com/thing:4714197
// https://github.com/stanoba/MIDI2Neopixel

difference(){
	union(){
		translate([0,0,3.1]) cylinder(h=6.2,d=8, center=true, $fn=40);
		translate([0,0,5])    cylinder(h=10,d=6, center=true, $fn=40);
	}
	translate([0,0,2])    cylinder(h=4,d=3.8, center=true, $fn=30);
}