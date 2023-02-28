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
                     bevel=false,
                     anchor=BOTTOM);
    }
}

EPSILON=0.1;

module lid_top_gap(diameter, height) {
    cylinder(h=height, r=diameter/2);
}
module lid(inner_diameter=LID_INNER_DIAMETER,
            outer_diameter=LID_OUTER_DIAMETER,
            pitch=LID_PITCH,
            nwraps=LID_NWRAPS,
            num_grips=LID_NGRIPS,
            grip_diam=LID_GRIP_DIAMETER) {
    grommet_height=GROMMET_HEIGHT;
    floor_height=LID_FLOOR_HEIGHT;
    thread_height=nwraps*pitch;
    top_gap_height=LID_TOP_GAP_HEIGHT;
    outer_height = floor_height + grommet_height + thread_height + top_gap_height;

    difference() {
        lid_outer(outer_diameter, outer_height, num_grips, grip_diam);
        union() {
            union() {
                /* Space for the grommet */
                up(floor_height) {
                    cylinder(r=inner_diameter/2, h=grommet_height);
                }
                /* Space for the thread. */
                up(floor_height+grommet_height-EPSILON) {
                    lid_thread(inner_diameter, 
                               thread_height+EPSILON, 
                               pitch, 
                               nwraps,
                               false);
                }
                /* Space for a gap */
                up(floor_height+grommet_height+thread_height-EPSILON) {
                    cylinder(r=LID_TOP_GAP_DIAMETER/2, h=top_gap_height+2*EPSILON);
                }
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
