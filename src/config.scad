include <GRISCAD/assemblies.scad>

WALL_WIDTH=4;
TOLERANCE=1;

WIDE_MOUTH_JAR_DIAMETER=92;
WIDE_MOUTH_PITCH=5;
WIDE_MOUTH_NWRAPS=1.1;

GROMMET_WIDTH=10;

LID_FLOOR_HEIGHT=WALL_WIDTH;
LID_INNER_DIAMETER=WIDE_MOUTH_JAR_DIAMETER+TOLERANCE;
LID_OUTER_DIAMETER_DELTA=WALL_WIDTH+4;
LID_OUTER_DIAMETER=LID_INNER_DIAMETER+LID_OUTER_DIAMETER_DELTA;

LID_PITCH=WIDE_MOUTH_PITCH;
LID_NWRAPS=WIDE_MOUTH_NWRAPS;

LID_TOP_GAP_DIAMETER=LID_INNER_DIAMETER;
LID_TOP_GAP_HEIGHT=WALL_WIDTH/2;
LID_NGRIPS=60;
LID_GRIP_DIAMETER=(PI*LID_OUTER_DIAMETER)/LID_NGRIPS/4;

GROMMET_OUTER_DIAMETER=WIDE_MOUTH_JAR_DIAMETER;
GROMMET_INNER_DIAMETER=GROMMET_OUTER_DIAMETER-GROMMET_WIDTH;
GROMMET_HEIGHT=WALL_WIDTH/2;

$fn=$preview ? 32 : 128;

