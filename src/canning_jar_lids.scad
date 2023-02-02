
include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <config.scad>

module lid_outer(outer_diameter, outer_length, num_grips, grip_diameter) {
    grip_angle=360/num_grips;
    difference() {
        cylinder(h=outer_length, r=outer_diameter/2);
        for(idx = [1:num_grips]) {
            zrot((idx-1)*grip_angle) {
                down(1) {
                    right(outer_diameter/2) {
                        cylinder(h=outer_length+2, r=grip_diameter);
                    }
                }
            }
        }
    }
}

module lid_thread(inner_diameter, inner_length, pitch, nwraps) {
    threaded_rod(d=inner_diameter, 
                 l=inner_length, 
                 pitch=pitch,
                 bevel=false,
                 anchor=BOTTOM);
}

module lid_inner(diameter, length) {
    cylinder(h=length, r=diameter/2);
}

EPSILON=0.001;

module lid(inner_diameter=LID_INNER_DIAMETER,
            outer_diameter=LID_OUTER_DIAMETER,
            outer_length=LID_OUTER_HEIGHT,
            pitch=LID_PITCH,
            nwraps=LID_NWRAPS,
            num_grips=LID_NGRIPS,
            grip_diam=LID_GRIP_DIAMETER) {
    thread_len=2*pitch;
    inner_length=outer_length-WALL_WIDTH-thread_len;
    difference() {
        lid_outer(outer_diameter, outer_length, num_grips, grip_diam);
        union() {
            up(WALL_WIDTH-EPSILON) {
                lid_inner(inner_diameter, inner_length+2*EPSILON);
            }
            up(WALL_WIDTH+inner_length-EPSILON) {
                lid_thread(inner_diameter, 
                           thread_len+2*EPSILON, 
                           pitch, 
                           nwraps);
            }
        }
    }
}

module grommet(outer_diameter=GROMMET_OUTER_DIAMETER,
               inner_diameter=GROMMET_INNER_DIAMETER,
               height=GROMMET_HEIGHT) {
    difference() {
        cylinder(h=height, r=outer_diameter/2);
        translate([0, 0, -EPSILON]) {
            cylinder(h=height+2*EPSILON, r=inner_diameter/2);
        }
    }
}
