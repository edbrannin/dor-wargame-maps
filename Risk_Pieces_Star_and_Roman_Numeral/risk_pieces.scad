w=1;
h=8;
d=6;
s=h/2;
v_factor=2.2;
h_spacer=1.2 * h;
i_factor=1.5;

module risk1() {
	translate([-w/2,0,0])
	cube([w,h,d]);
	translate([-(i_factor*s)/2,0,0])
	cube([i_factor*s,w,d]);
	translate([-(i_factor*s)/2,h-w,0])
	cube([i_factor*s,w,d]);
}

module risk3() {
	for ( x =[-1, 0, 1 ]) {
		translate([(x*s/1.5)-w/2,0,0])
		cube([w,h,d]);
	}
	translate([-(s/2+(s/1.5)), 0, 0])
	cube([(s+(2*s/1.5)), w, d]);
	translate([-(s/2+(s/1.5)), h-w, 0])
	cube([(s+(2*s/1.5)), w, d]);
}


module risk5() {
	translate([-w/2,0,0])
	rotate([0,0,20])
	cube([w,h,d]);
	translate([-w/2,w/2,0])
	rotate([0,0,-20])
	cube([w,h,d]);
	translate([-(s*v_factor)/2,0,0])
	cube([s*v_factor,w,d]);
	translate([-(s*v_factor)/2,h-w,0])
	cube([s*v_factor,w,d]);
}

module risk10() {
	translate([s/2-w/4,0,0])
	rotate([0,0,30])
	cube([w,h*1.05,d]);
	translate([-s/2-3*w/4,w/2,0])
	rotate([0,0,-30])
	cube([w,h*1.05,d]);
	translate([-s,0,0])
	cube([s*2,w,d]);
	translate([-s,h-w,0])
	cube([s*2,w,d]);
}

translate([0,h_spacer,0])
risk1();

translate([0, 2*h_spacer,0])
risk3();

translate([0,3*h_spacer, 0])
risk5();

translate([0,4*h_spacer,0])
risk10();
