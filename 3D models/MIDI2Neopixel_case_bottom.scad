// MIDI2Neopixel case bottom
// by stanoba http://www.thingiverse.com/stanoba/about
// https://www.thingiverse.com/thing:4714197
// https://github.com/stanoba/MIDI2Neopixel

height = 36;
width = 62;
outside_radius=5;
depth=2;

/// PCB
translate([28.5,-13.3,6.2]) rotate([0,0,90]) color([0,1,0]) import("MIDI2Neopixel_PCB.stl", convexity=3);

module main(){
	difference(){
		union(){
			hull(){
				translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
				translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)]) cylinder(h=depth,d=outside_radius, center=true, $fn=40);
			}
			
			hull(){
				translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=3, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=3, center=true, $fn=40);
				translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=3, center=true, $fn=40);
				translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=3, center=true, $fn=40);
			}
		}
		pcb_space();
	}
	translate([ 8,0,3]) cylinder(h=3,d=6, center=true, $fn=40);
	//translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2) ,(depth/2)+2]) cylinder(h=3,d=3, center=true, $fn=40);
	translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2) ,(depth/2)+2]) cylinder(h=3,d=3, center=true, $fn=40);
	translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+2]) cylinder(h=3,d=3, center=true, $fn=40);
	translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+2]) cylinder(h=3,d=3, center=true, $fn=40);
}

module pcb_space(){
	hull(){
		translate([ (width/2)-(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([(-width/2)+(outside_radius/2),(height/2)-(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([(-width/2)+(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
		translate([ (width/2)-(outside_radius/2),(-height/2)+(outside_radius/2),(depth/2)+3]) cylinder(h=depth+2,d=1, center=true, $fn=40);
	}
}


module holes1(){
	translate([ 8,0,0]) cylinder(h=30,d=3.2, center=true, $fn=20);
	translate([ 8,0,1]) cylinder(h=2,d2=3.2,d1=6, center=true, $fn=20);
}



difference(){
	main();
	holes1();
	//holes2();
	
}

