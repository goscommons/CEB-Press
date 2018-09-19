/*
About the model: This is a simplified model of a hydraulc cylinder, with key properties to consider when designing and CADing you own model. It allows you to look into a catalog and change parameters, based on the model you select.
The refernece used to construct this specific model is the "Chieve WC Wlded Cylinders", available in 2012 Catalog 280 provided by Bailey.

How to change it:
1) You can directly change it here, or
2) Enable the customizer feature of openscad
*/

/* [General Parameters]*/
unit=25.4;
extended=false;
bore=1.5;
stroke=5;
//Length of the cylinder
a=10.250;
/* [Cylinder Body Parameters] */
b=0.18;
// rod diameter
d=0.75;
/*[rod mechanical link parameters]*/
h=0.787;
l=0.96;
r=0.765;
g=1.732;
j=1.15;
/*[cylinder mechanical link parameters]*/
o=0.787;
e=1.850;
n=0.9;
r_c_h=j+l;
/*[Distance of hydraulic ports]*/
k=2.125;
m=0.922;

/*[Hidden]*/
//Z axis connection
// Rod connection related variable
z=g-h/2;
//size of the body cylinder
body=a-m-j;//*[] put the variables
y=a-(n+n);


module main_mod(){

// Rod Connector construction
module rod_connector(args) {
	module m001(args) {
		cylinder(d=l, h=g, center=true, $fn = 20 );
		translate([-j/2, 0, 0]){
			/* cube(size=[j, l, g], center=true); */
			cube(size=[j, l, g], center=true);

		}

	}
	difference(){
		difference() {
			m001();
			cylinder(d=r, h=z+10, center=true, $fn = 20);
		}
		cube(size=[j+j*0.2, j+j, h], center=true);
	}

}
// Lower Body connector *[] call within cylinder body module
module low_connector(){
	difference(){
	difference(){
	union(){
		cylinder(d=l, h=e, center=true, $fn = 20 );
		translate([-j/2, 0, 0])
			/* cube(size=[j, l, g], center=true); */
			cube(size=[n+n*0.5, l, e], center=true);
		}
		cube(size=[j+j*0.2, j+j, h], center=true);
	}
	cylinder(d=r, h=z+10, center=true, $fn=50);
	}

}

/*Body Cylinder connector
* [] related variables h, e
* [] Build this
*/

// cylinder rod
module rod(args) {
	translate([0,0,j])
	cylinder(d=d, h=stroke+stroke*0.2, center=true, $fn=50);
	translate([0,0,a/2])rotate([90,270,0])rod_connector();
}

// cylinder body
module body(args) {
	//hydraulic ports construction
	module h_ports(args) {
		color("red")
		rotate([0,90,0])
		translate([0, 0, -bore/2])
		cylinder(d=0.5, h=0.4, center=true, $fn=50);
		}
		translate([0,0,body/2-k])h_ports();
		translate([0,0,-body/2+m])h_ports();
		// main body cylinder
		cylinder(d=bore+b, h=body-body*0.05, center=true, $fn=50);
		translate([0,0,-(a/2)])rotate([90,90,0])low_connector();
}


// Construct full cylinder cylinder_body
color("red")body();
if (extended==true){
	translate([0,0,stroke])color("lime")rod();
}
else{
	translate([0,0,0])color("lime")rod();
}

}
//Convert to proper units
scale([unit, unit, unit]) {
	main_mod();
}
