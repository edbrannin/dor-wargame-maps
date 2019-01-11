use <risk_star_pieces.scad>

v_single = 12;
h_single = 12;

h1 = 5;
h2 = h1 * 1.5;
h3 = h1 * 2;

translate([-50,-55,0])
translate([8,8,0])
for (i = [0:3])
{
	for (j = [0:4])
	{
		translate([i*v_single, j*h_single, 0])
		if (i % 2 == 1)
		{
			rotate([0,0,180])
			risk(3,h1);
		} else {
			risk(3,h1);
		}
	}

	for (j = [5:6])
	{
		translate([i*v_single, j*h_single, 0])
		rotate([0,0,45])
		risk(4,h2);
	}

	for (j = [7])
	{
		translate([i*v_single, j*h_single, 0])
		if ( i  < 4 )
		{
			if (i % 2 == 1)
			{
				rotate([0,0,180])
				risk(5, h3);
			} else {
				risk(5, h3);
			}				
		} else {
			rotate([0,0,45])
			risk(4,h2);
		}
	}

	for (j = [8])
	{
		translate([i*v_single, j*h_single, 0])
		if (i % 2 == 1)
		{
			rotate([0,0,180])
			risk(5, h3);
		} else {
			risk(5, h3);
		}
	}
}