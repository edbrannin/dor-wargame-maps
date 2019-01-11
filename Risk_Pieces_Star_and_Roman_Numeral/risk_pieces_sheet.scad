use <risk_pieces.scad>

h_spacer = 10;
v_spacer1 = 8;
v_spacer2 = 12;

translate([5,2,0])
for (i = [0:4])
{
	for (j = [0:3])
	{
		translate([i*v_spacer1, j*h_spacer, 0])
		risk1();
	}
}
translate([5, 2, 0])
for (i = [0:3])
{
	for (j = [4:5])
	{
		translate([i*v_spacer2, j*h_spacer, 0])
		risk3();
	}
	for (j = [6:7])
	{
		translate([i*v_spacer2, j*h_spacer, 0])
		risk5();
	}
	for (j = [8])
	{
		translate([i*v_spacer2, j*h_spacer, 0])
		risk10();
	}
}

if (0) {
difference(){
	cube([100,100,1]);
	translate([1,1,0])
	cube([98,98,1]);
}
}
