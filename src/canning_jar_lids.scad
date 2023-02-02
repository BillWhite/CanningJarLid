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

module lid_thread(inner_diameter, inner_length, pitch, nwraps, debug) {
    if (debug) {
        cylinder(r=inner_diameter/2, h=inner_length);
    } else {
        threaded_rod(d=inner_diameter, 
                     l=inner_length, 
                     pitch=pitch,
                     bevel=true,
                     anchor=BOTTOM);
    }
}

module lid_inner(diameter, length) {
    cylinder(h=length, r=diameter/2);
}

EPSILON=0.001;

module lid_top_gap(diameter, height) {
    cylinder(h=height, r=diameter/2);
}
module lid(inner_diameter=LID_INNER_DIAMETER,
            outer_diameter=LID_OUTER_DIAMETER,
            outer_length=LID_OUTER_HEIGHT,
            pitch=LID_PITCH,
            nwraps=LID_NWRAPS,
            num_grips=LID_NGRIPS,
            grip_diam=LID_GRIP_DIAMETER) {
    thread_len=pitch;
    inner_length=outer_length-WALL_WIDTH-thread_len;
    difference() {
        lid_outer(outer_diameter, outer_length, num_grips, grip_diam);
        union() {
            up(WALL_WIDTH-EPSILON) {
                lid_inner(inner_diameter, inner_length+2*EPSILON);
            }
            !up(WALL_WIDTH+inner_length-EPSILON) {
                lid_thread(inner_diameter, 
                           thread_len+2*EPSILON, 
                           pitch, 
                           nwraps,
                           false);
            }
            up(WALL_WIDTH+inner_length+1.5*pitch) {
                lid_top_gap(LID_TOP_GAP_DIAMETER, LID_TOP_GAP_HEIGHT+2*EPSILON);
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
