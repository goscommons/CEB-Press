/* README
Intro:
This is a parametric model of simple hydraulic cylinder, based on the catalog of Chief cylinders[1]. Additionally we have added two modifications to this standard model.

1) a hole on the rod
2) a connection at the bottom in blue

How to use it:
- Change the parameters in the module call below
- For standard- off the shelve cylinders look for the
- The variables from a to e, are taken from a specific catalog provided in the references. Be aware that these might change from catalog to catalog.
- You can generate an extended or non extended version of the model by changing the turning this parameter to true or false.

References:
[1]

*/

//-[]* under certain conditions load certain modules

//mm is the standard unit
// slider widget for number with max. value
sliderWithMax =34; // [50]

// slider widget for number in range
sliderWithRange =34; // [10:100]

//step slider for number
stepSlider=2; //[0:5:100]

// slider widget for number in range
sliderCentered =0; // [-10:0.1:10]


unit=25.4;//[] inch=25.4mmm
model="002"; // cylinder model
stroke=8;//Stroke
bore=5;//bore
extended=true;// for extended set true, for not extended false
a= 9.25;// a= size of the full cylinder
b= 1.875;//b= offset of the cylinder rod with respect to the tube
c= 3.375;//c= upper place
d= 2;//d= lower port place
e= 0.375;//tubing wall
sae= 0.7;//sae
rod=2.75;//rod size

//include <parametric_cylinder_modules.scad>
if (model=="001"){
 //include <parametric_cylinder_modules.scad>
}


module hydraulic_cylinder(model,unit,stroke,bore,extended,a,b,c,d,e,port,rod){

// the current model is:216-380
    bore=bore*unit;
    a=a*unit;// general length of the cylinder
    b=b*unit;
    c=c*unit;//upper SAE port place
    d=d*unit;//lower SAE port place
    e=e*unit; // thickness of the tubewall
    bore=bore*unit;//
    stroke=stroke*unit;
    sae=sae*unit;
    tube_l=a+stroke-b;
    rod=rod*unit;
    rod_l=a+stroke-b;

    module connection(){
        // lower mechanical connector
        difference(){
        rotate([0,90,0])
        cylinder(r=unit+10, h=bore, center=true);
        rotate([0,90,0])
        cylinder(r=unit/2+10, h=bore*2, center=true);
        }
    }
    
    module h_connection(){
        translate([0,bore/2,0])
        rotate([90,90,0])
        cylinder(r=sae,h=20,center=true);
        }

    module cylinder_body(model){
    translate([0,0,-(tube_l/2+unit/2)])

        if (model=="002"){
            connection();
         }

    cylinder(r=bore/2,h=tube_l,center=true);
    // These are the positions of hydraulic connectors
    translate([0,0,tube_l/2-c])h_connection();
    translate([0,0,-(tube_l/2-d)])h_connection();
    }

    // Parameters for hydraulic connections
    //SEA connection port dimension

    module rod(){
        translate([0,0,b])


    //different connectors
        if (model=="001") {//*[] set proper parameters
        //custom made hole
        difference(){
        cylinder(h=rod_l,r=rod/2,$fn=50, center=true);
        color("lime")
        rotate([90,0,0])
        translate([0,rod_l/2-(rod_l*1/10),0])
        cylinder(r=10,h=bore*3,center=true);
        }
    }

        else if (model=="002"){
            // lower cylinder connection
            translate([0,0,rod_l/2])
            connection();
            cylinder(h=rod_l,r=rod/2,$fn=50, center=true);


        }

    }

    color("red")
    cylinder_body(model);

    if (extended == true){

            translate([0,0,stroke])rod();

    }
    //unextend
    else{
        translate([0,0,])
        rod(); // *[ ] independizar modulo
        }

    }

hydraulic_cylinder(model,unit,stroke,bore,extended,a,b,c,d,e,sae,rod);
/*hydraulic_cylinder(
    "002", // cylinder model
    in,//units
    8,//Stroke
    5,//bore
    true,// for extended set true, for not extended false
    9.25,// a= size of the full cylinder
    1.875,//b= offset of the cylinder rod with respect to the tube
    3.375,//c= upper place
    2,//d= lower port place
    0.375,//tubing wall
    0.7,//sae
    2.75);//rod size*/
