/*********************************************************************
 * VM66
 *   *********************************************************************/

b=1;
l=40;

lc = 5e-1;

nl=601;
nb=13;

Point(1) = {0, 0, 0, lc};
Point(2) = {0, b, 0, lc} ;
Point(3) = {l, b, 0, lc} ;
Point(4) = {l, 0, 0, lc} ;
//Point(5) = {0, b/2, 0, lc} ;


Line(1) = {1,2} ;
//Line(5) = {5,2} ;

Line(2) = {2,3} ;
Line(3) = {3,4} ;
Line(4) = {1,4} ;

Line Loop(1) = {1,2,3,-4} ;
Plane Surface(1) = {1} ;

Transfinite Line{2,4} = nl;// Using Progression 1.01 ; // Using Bump 0.1 ;   // 
Transfinite Line{3} = nb ;
Transfinite Line{1} = nb ;
Transfinite Surface{1} = {1,2,3,-4};

Recombine Surface{1};
//Mesh.Smoothing = 100;

Physical Surface("ToPhy",1) = {1};
Physical Line("bottom", 11) = {1,5};
Physical Line("top", 12) = {3};
Physical Point("b_left", 101) = {1};
Physical Point("b_right", 102) = {2};
//Physical Point("b_center", 103) = {5};
