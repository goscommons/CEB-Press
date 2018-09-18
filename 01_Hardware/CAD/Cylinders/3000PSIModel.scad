unit=25.4;
bore=1.5;
stroke=10.5;
a=10.250;
// rod diameter
d=0.75;
l=0.96;
r=0.765;
g=1.732;// determins height of m002
h=0.787;// determins height of m002
j=2.216;
k=2.125;
n=0.9;

/*Custom variables*/
//Z axis connection
z=g-h/2;
y=a-(n+n);

module main_mod(){
// Rod Connector construction
module m002(args) {
	module m001(args) {
		cylinder(d=l, h=z, center=true, $fn = 20 );
		translate([-j/2, 0, 0]) {
			cube(size=[j, l, z], center=true);
			//*[]set l x dimension
		}
	}

	difference() {
		m001();
		cylinder(d=r, h=z+10, center=true, $fn = 20);
	}
}

/*Body Cylinder connector
* [] related variables h, e
* [] Build this
*/

module rod(args) {
	cylinder(d=d, stroke, center=true, $fn=20);
}

// cylinder body
module m003(args) {

	//hydraulic ports construction
	module h_ports(args) {
		color("red")
		rotate([0,90,0])
		translate([0, 0, -bore/2])
		cylinder(d=0.5, h=0.2, center=true, $fn=20);
		}
		// *[] Fix this and add proper offset dimension to y
		translate([0,0,y/2])h_ports();
		translate([0,0,-y/2])h_ports();
		// main body cylinder
		cylinder(d=bore, h=a, center=true, $fn=20);
}

// Construct full connector with submodules
translate([0, 0, g/2])m002();
translate([0, 0, -g/2])m002();



// Construct full cylinder cylinder_body
translate([0, 5, 0]) {
	m003();
	color("lime")rod();
}




}
scale([unit, unit, unit]) {
	main_mod();
}


/* cylinder(d=l, h=h, center=true);
cylinder(d=r, h=h, center=true); */
