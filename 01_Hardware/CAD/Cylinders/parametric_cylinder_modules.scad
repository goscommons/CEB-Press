a= 90;// a = connector widthness
b= 10;// b = connector thickness
c=50;// c = height of the cube *[]this needs to be improved
d=50;// d = hole
e=100;// e = depth 
    
module connector_01(a,b,c,d,e){
    module bb_02(){
        module bb_01(){
        color("lime")translate([0,0,-c/2])cube ([a,b,c], center=    true);
        rotate([90,0,0])cylinder(d=a,h=b, center=true);
        }
    
    difference(){
        bb_01();
        rotate([90,0,0])cylinder(d=d,h=b+b, center=true);
        }
    }
    
    cube ([a,e,b], center=true);
    translate([0,-e/2+b/2,c]) bb_02();
    translate([0,e/2-b/2,c]) bb_02();
}

//translate([0,0,210])
/*color("red")connector_01(
90,// a = connector widthness
10,// b = connector thickness
50,// c = height of the cube *[]this needs to be improved
50,// d = hole
100// e = depth
);*/ 


connector_01(a,b,c,d,e);

