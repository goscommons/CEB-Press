/*
*[x] Add true false for extender retracted
*[x] Proper position of the rod
*[] Find rod width
*[x] Adjust general dimensions
*[] Adjust proper lower connector variables
*[] Proper customizer design
*[] Verifying the module
*/

extended=true;
unit=25.4;
bore=1.5;
stroke=5;
a=10.250;
// rod diameter
d=0.75;
// Rod Connector variables
l=0.96;
r=0.765;
e=1.850;
g=1.732;
h=0.787;
//height of the part

j=1.15;

r_c_h=j+l;

k=2.125;
m=0.922;
n=0.9;
// Low connector dimension
o=0.787;

/*Custom variables*/
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
			//*[]set l x dimension
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
		cylinder(d=l, h=g, center=true, $fn = 20 );
		translate([-j/2, 0, 0])
			/* cube(size=[j, l, g], center=true); */
			cube(size=[n+n*0.8, l, g], center=true);
		}
		cube(size=[j+j*0.2, j+j, h], center=true);
	}
	cylinder(d=r, h=z+10, center=true, $fn=20);
	}

}

/*Body Cylinder connector
* [] related variables h, e
* [] Build this
*/

// cylinder rod
module rod(args) {
	translate([0,0,j])
	cylinder(d=d, h=stroke+stroke*0.2, center=true, $fn=20);
	//*[]add to the translation the size of the head
	translate([0,0,a/2])rotate([90,270,0])rod_connector();

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
		translate([0,0,body/2-k])h_ports();
		translate([0,0,-body/2+m])h_ports();

		// main body cylinder
		cylinder(d=bore, h=body-body*0.05, center=true, $fn=20);
		//*[]proper dimension of lower connector with N, M from catalog
		translate([0,0,-(a/2)])rotate([90,90,0])low_connector();
}



// Construct full cylinder cylinder_body

color("red")m003();
if (extended==true){
	translate([0,0,stroke])color("lime")rod();
}
else{
	translate([0,0,0])color("lime")rod();
}

translate([0,2,0])
cube(size=[1, 1, a+l/2+o/2], center=true);

/* translate([0,0,a/2-l/2])
rotate([90,270,0])
rod_connector(); */


}
scale([unit, unit, unit]) {
	main_mod();
}



/* cylinder(d=l, h=h, center=true);
cylinder(d=r, h=h, center=true); */
