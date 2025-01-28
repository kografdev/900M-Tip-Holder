
rows = 2; //[1:40]
columns = 5; //[1:40]

x_spacing = 10; //[1:0.1:40]
y_spacing = 10; //[1:0.1:40]
rim_spacing = 5; //[1:0.1:40]

plate_thickness = 2; //[0.5:0.1:20]
plate_rounding_radius = 1; //[0:0.1:5]
plate_flat_bottom = true; 

centred = true;

preview_fn = 20;
render_fn = 200;

module __Customizer_Limit__ () {}

holder_diameter = 3.5;
holder_height = 20;

$fn = $preview ? preview_fn : render_fn;

plate_length = (columns-1)*x_spacing+columns*holder_diameter+2*rim_spacing;
plate_width = (rows-1)*y_spacing+rows*holder_diameter+2*rim_spacing;

corner_x_offset = plate_length/2-plate_rounding_radius;
corner_y_offset = plate_width/2-plate_rounding_radius;

plate_top_translate = plate_thickness-2*plate_rounding_radius;

pin_max_x_offset = (columns-1)*(x_spacing+holder_diameter)/2;
pin_max_y_offset = (rows-1)*(y_spacing+holder_diameter)/2;

pin_x_stepsize = x_spacing+holder_diameter;
pin_y_stepsize = y_spacing+holder_diameter;

pin_z_offset = plate_top_translate+plate_rounding_radius;

module plate_shape(){
    hull(){
	translate([corner_x_offset,corner_y_offset])
	circle(plate_rounding_radius);
	translate([-corner_x_offset,corner_y_offset])
	circle(plate_rounding_radius);
	translate([-corner_x_offset,-corner_y_offset])
	circle(plate_rounding_radius);
	translate([corner_x_offset,-corner_y_offset])
	circle(plate_rounding_radius);
    }
}

module plate(){
    union(){
	if(plate_flat_bottom){
	    translate([0,0,-plate_rounding_radius])
	    linear_extrude(plate_rounding_radius)
	    plate_shape();
	}
	hull(){
	    //bottom
	    translate([corner_x_offset,corner_y_offset,0])
	    sphere(plate_rounding_radius);
	    translate([-corner_x_offset,corner_y_offset,0])
	    sphere(plate_rounding_radius);
	    translate([-corner_x_offset,-corner_y_offset,0])
	    sphere(plate_rounding_radius);
	    translate([corner_x_offset,-corner_y_offset,0])
	    sphere(plate_rounding_radius);
	    //top
	    if(plate_top_translate > 0){
		translate([corner_x_offset,corner_y_offset,plate_top_translate])
	    	sphere(plate_rounding_radius);
	    	translate([-corner_x_offset,corner_y_offset,plate_top_translate])
	    	sphere(plate_rounding_radius);
	    	translate([-corner_x_offset,-corner_y_offset,plate_top_translate])
	    	sphere(plate_rounding_radius);
	    	translate([corner_x_offset,-corner_y_offset,plate_top_translate])
	    	sphere(plate_rounding_radius);
	    }
	}
    }
}
	
module pins(){
    for(x=[-pin_max_x_offset:pin_x_stepsize:pin_max_x_offset]){
	for(y=[-pin_max_y_offset:pin_y_stepsize:pin_max_y_offset]){
	    translate([x,y,pin_z_offset])
	    cylinder(h=holder_height, d=holder_diameter);
	}
    }
}

plate();
pins();
