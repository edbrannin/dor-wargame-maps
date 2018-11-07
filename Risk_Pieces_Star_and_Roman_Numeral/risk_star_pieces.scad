w=1;
d=6;
s=d*2.1;
r=w*3;

h1=5;
h2=h1*1.5;
h3=h1*2;

module risk(points, h) {
	angle = 360/points;
	angle2 = angle/2;
	middle = w*(points/2);
	middle2 = middle/2;
	filler = d/2;
	x = sin(angle) * filler;
	y = cos(angle) * filler;
	for (i = [0:points - 1]) {
		rotate([0,0, angle*i])
		translate([-w/2,0,0])
		cube([w,d,h]);
		rotate([0,0,angle*i])
		polyhedron( [ [0,0,0], [0,filler,0],[x,y,0], [0,0,h], [0,filler,h],[x,y,h]],
				   [ [2,1,0], [3,4,5], [0,1,4], [0,4,3], [0,3,2], [2,3,5], [1,2,5],[1,5,4] ]);
	}
}


risk(3, h1);

translate([0,-s,0])
risk(4,h2);

translate([0,s,0])
risk(5,h3);

