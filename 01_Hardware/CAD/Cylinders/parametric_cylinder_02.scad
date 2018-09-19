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

/*
Solution to the problem: have different files with same name variables


*/
use <parametric_cylinder_modules.scad>

//mm is the standard unit

/*[Tab Name]*/
units="inch";//["in","mm"]
unit=24.5;// hidden *[] fix the problem of inch and milimiters
/*[Drop Down box:]*/
// cylinder model
model="002";//["001","002","003"]

/*[Other Parameters]*/
//Stroke
stroke=8;//[20]
bore=5;//[20]
extended=true;// for extended set true, for not extended false
//size of the full cylinder
a= 9.25;//[40]
//offset of the cylinder rod with respect to the tube
b= 1.875;//[10]
//upper port location place
c= 3.375;//[10]
//lower port location
d= 2;//[10]
e= 0.375;//tubing wall
//select type of port
sae= 0.7;//sae *[] select put a string stating select type of port as a place holder
// rod size
rod=2.75;//[10.00]




module hydraulic_cylinder(){

// the current model is:216-380
    bore=bore*unit;
    a=a*unit;
    b=b*unit;
    c=c*unit;
    d=d*unit;
    e=e*unit;
    bore=bore*unit;
    stroke=stroke*unit;
    sae=sae*unit;
    tube_l=a+stroke-b;
    rod=rod*unit;
    rod_l=a+stroke-b;
    
    // optional model
    module connection(){
        difference(){
        rotate([0,90,0])
        cylinder(r=unit+10, h=bore, center=true);
        rotate([0,90,0])
        cylinder(r=unit/2+10, h=bore*2, center=true);
        }
    }
    
    // construct Hydraulic ports
    module h_connection(){
        translate([0,bore/2,0])
        rotate([90,90,0])
        cylinder(r=sae,h=20,center=true);
        }
    // construct body of cylinder (aggregate modules)
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
    //Construct rod
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
    
    // cylinder body call
    color("red")
    cylinder_body(model);
    // Call rod extended or retracted
    if (extended == true){
            translate([0,0,stroke])rod();
    }
    //unextend
    else{
        translate([0,0,])
        rod(); // *[ ] independizar modulo
        }

  }

if (units=="inch"){
    unit=24.5;
    }
//*[] Not working properly change to milimiters    
else{
    unit=1;
    }

// Call hydraulic cylinder
hydraulic_cylinder();

