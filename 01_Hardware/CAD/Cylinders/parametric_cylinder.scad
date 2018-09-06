/*
Hydraulic cylinder variables


*/

//cylinder(h=8, r1=2.5, r2=2.5 ,$fn=50, center=false);
in=25.4;

module hydraulic_cylinder(unit,stroke,bore,extended){
    stroke=stroke*unit;
    bore=bore*unit;
    
    module h_cylinder(){
        difference(){
        cylinder(h=stroke,r=bore,$fn=50, center=true);
        color("lime")
        rotate([90,0,0])
        translate([0,stroke/2-(stroke*1/9),0])
        cylinder(r=unit,h=bore*3,center=true);
        }
    }
 
    // extend
    if (extended == true){
    translate([0,0,stroke])h_cylinder(); 
    }
    //unextend
    else{
        h_cylinder();
        }
    // Outer body
        
    color("red")cylinder(r=bore+0.6*in,h=stroke+2,$fn=50,center=true);
    
    module h_connection(){ 
        translate([0,bore+unit,0])
        rotate([90,90,0])
        color("red")cylinder(r=unit,h=20,center=true);
        
        
        }
    translate([0,0,stroke/2-(stroke*1/6)])h_connection();
    translate([0,0,-(stroke/2-(stroke*1/6))])h_connection();
    
    translate([0,0,-(stroke/2+stroke*1/30)])
    color("blue")
    rotate([0,90,0])
    cylinder(r=unit, h=bore*3, center=true);
    
    }
    
hydraulic_cylinder(in,32,2.5,true);