include <Round-Anything/polyround.scad>

rows = 2; //[1:40]
columns = 5; //[1:40]

x_spacing = 10; //[1:0.1:40]
y_spacing = 10; //[1:0.1:40]
rim_spacing = 5; //[1:0.1:40]

plate_thickness = 2; //[0.5:0.1:20]
plate_corner_radius = 1; //[0:0.1:5]
plate_bottom_radius = 0; //[0:0.1:5]
plate_top_radius = 1; //[0:0.1:5]

centred = true;

module __Customizer_Limit__ () {}

holder_diameter = 3.5;
holder_height = 20;

$fn = $preview ? 10 : 100;

translate([-(columns-1)/2*(x_spacing+holder_diameter), -(rows-1)/2*(x_spacing+holder_diameter), 0])
union(){
    for(i = [0: columns-1]){
        for (j = [0: rows-1]){
            translate([(x_spacing+holder_diameter)*i, (y_spacing+holder_diameter)*j, plate_thickness/2])
                cylinder(h=holder_height, d=holder_diameter);
        }
    }
    translate([0,0,-plate_thickness/2])
        extrudeWithRadius(plate_thickness, plate_bottom_radius, plate_top_radius, $fn)
            polygon(
                polyRound([
                    [-holder_diameter/2-rim_spacing, -holder_diameter/2-rim_spacing, plate_corner_radius],
                    [holder_diameter*(columns-0.5)+x_spacing*(columns-1)+rim_spacing, -holder_diameter/2-rim_spacing, plate_corner_radius],
                    [holder_diameter*(columns-0.5)+x_spacing*(columns-1)+rim_spacing, holder_diameter*(rows-0.5)+y_spacing*(rows-1)+rim_spacing, plate_corner_radius],
                    [-holder_diameter/2-rim_spacing, holder_diameter*(rows-0.5)+y_spacing*(rows-1)+rim_spacing, plate_corner_radius]
                ], $fn)
            );
}
