// MIDI2Neopixel case top
// by stanoba http://www.thingiverse.com/stanoba/about
// https://www.thingiverse.com/thing:4714197
// https://github.com/stanoba/MIDI2Neopixel

height = 36;
width = 62;
outside_radius=5;
depth=19;
font="Liberation Sans:style=Bold";
font_depth=1;

/// PCB
//translate([28.5,-13.3,4.2]) rotate([0,0,90]) color([0,1,0]) import("MIDI2Neopixel_PCB.stl", convexity=3);

// Case bottom
//translate([0,0,-2]) rotate([0,0,0]) color([1,0,0]) import("MIDI2Neopixel_case_bottom.stl", convexity=3);

module main(){
	difference(){
		union(){
			hull(){
				translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
			}
			
		}
		translate([ 0,0,-6 ]) pcb_space();

		hull(){
			translate([ (width/2)-(outside_radius/2)+0.1,(height/2)-(outside_radius/2) +0.1,2.25]) cylinder(h=4.5,d=3, center=true, $fn=40);
			translate([(-width/2)+(outside_radius/2)-0.1,(height/2)-(outside_radius/2) +0.1,2.25]) cylinder(h=4.5,d=3, center=true, $fn=40);
			translate([(-width/2)+(outside_radius/2)-0.1,(-height/2)+(outside_radius/2)-0.1,2.25]) cylinder(h=4.5,d=3, center=true, $fn=40);
			translate([ (width/2)-(outside_radius/2)+0.1,(-height/2)+(outside_radius/2)-0.1,2.25]) cylinder(h=4.5,d=3, center=true, $fn=40);
		}        

	}
	translate([ 8,0,11.5]) cylinder(h=14,d=6, center=true, $fn=40);
	//translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2) ,(depth/2)+2]) cylinder(h=3,d=3, center=true, $fn=40);
	//translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2) ,(depth/2)+2]) cylinder(h=14,d=3, center=true, $fn=40);
	translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+2]) cylinder(h=14,d=3, center=true, $fn=40);
	translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+2]) cylinder(h=14,d=3, center=true, $fn=40);
}

module pcb_space(){
	hull(){
		translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
	}
}



module holes(){
	// Screw
	translate([ 8,0,0]) cylinder(h=30,d=2.5, center=true, $fn=20);
	
	// LEDs
	translate([ 13.6,-8.6,15]) cylinder(h=30,d=3.2, center=true, $fn=30);
	translate([ 20.6,-8.6,15]) cylinder(h=30,d=3.2, center=true, $fn=30);
	
	// Buttons
	translate([ -8.6,-8.6,15])cylinder(h=30,d=6.4, center=true, $fn=30);
	translate([ 3.5,-8.6,15]) cylinder(h=30,d=6.4, center=true, $fn=30);
	
	// Power Jack
	translate([ (-width/2),-8.3,10.2]) rotate([0,90,0]) cylinder(h=5,d=7, center=true, $fn=30);

	// LED stripe connector
	translate([ (width/2),-0.4,7.1]) rotate([0,90,0]) cube([6.4,10.4,5],center=true);

	// micro USB connector
	translate([ (-width/2),5.4,9.6]) rotate([90,0,90]) microUSB();
	translate([ (-width/2)+1.5,5.5,6]) rotate([0,90,0]) cube([12,9,2],center=true);
}


module microUSB(){
	hull(){
		translate([ 2.6,0,0]) cylinder(h=5,d=3.4, center=true, $fn=30);
		translate([ -2.6,0,0]) cylinder(h=5,d=3.4, center=true, $fn=30);
	}
}

module labels(){
	translate([ -20, -15, depth-font_depth]) rotate([0,0,90]) linear_extrude(font_depth) text("MIDI2Neopixel", font = font, size = 3.3);

	translate([-7.6, -4, depth-font_depth]) rotate([0,0,90]) linear_extrude(font_depth) text("Program", font = font, size = 3);
	translate([ 4.6, -4, depth-font_depth]) rotate([0,0,90]) linear_extrude(font_depth) text("Intensity", font = font, size = 3);
	
	translate([14.6, -4, depth-font_depth]) rotate([0,0,90]) linear_extrude(font_depth) text("Power", font = font, size = 2.5);
	translate([21.6, -4, depth-font_depth]) rotate([0,0,90]) linear_extrude(font_depth) text("Activity", font = font, size = 2.5);
}


difference(){
	main();
	holes();
	labels();
}




