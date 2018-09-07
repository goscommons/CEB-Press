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

//mm is the standard unit
in=25.4;//inch=25.4mmm
cm=10;


module hydraulic_cylinder(unit,stroke,bore,extended,a,b,c,d,e,sae,rod){

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
    
   
    color("red")
    //cylinder(r=bore/2,h=a,$fn=50,center=true);
    cylinder(r=bore/2,h=tube_l,center=true);
    
    
    // Parameters for hydraulic connections
    //SEA connection port dimension
   
    module h_connection(){   
        translate([0,bore/2,0])
        rotate([90,90,0])
        color("red")cylinder(r=sae,h=20,center=true);
        }
   
    // These are the positions of hydraulic connectors    
    translate([0,0,tube_l/2-c])h_connection();
    translate([0,0,-(tube_l/2-d)])h_connection();
    
        
    // lower cylinder connection    
    translate([0,0,-(tube_l/2+(tube_l*0.04))])
    color("blue")
    rotate([0,90,0])
    cylinder(r=unit, h=bore, center=true);
    
    //cylinder rod    
    module h_cylinder(){
        translate([0,0,b])
        difference(){
        cylinder(h=rod_l,r=rod/2,$fn=50, center=true);
        
        //custom made hole
        color("lime")
        rotate([90,0,0])
        translate([0,rod_l/2-(rod_l*1/10),0])
        cylinder(r=10,h=bore*3,center=true);
        }
    }
 
    // extend
    if (extended == true){
    translate([0,0,stroke])h_cylinder(); 
    }
    //unextend
    else{
        translate([0,0,])
        h_cylinder(); 
        }
    // Outer body
    
    }
    
hydraulic_cylinder(
    in,//units
    8,//Stroke
    5,//bore
    false,// for extended set true, for not extended false
    9.25,// a= size of the full cylinder
    1.875,//b= offset of the cylinder rod with respect to the tube 
    3.375,//c= upper place
    2,//d= lower port place
    0.375,//tubing wall
    0.7,//sae
    2.75);//rod size
    
    

  