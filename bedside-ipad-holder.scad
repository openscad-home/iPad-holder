$fn = 200;
width = 25;
wallThickness = 4;
side_height = 60;
side_gap = 20;
total_height = 180;
ipad_gap = 15;

side();

translate([0, 100, width])
    rotate([180, 0, 0])
        side(true);


module side(flip = false) {

    // hanger
    wall(30, wallThickness, width);

    // top
    rotate([0, 0, 90])
        wall(wallThickness + 22 + wallThickness, wallThickness, width, 3, 2);

    // back plane
    translate([0, 22 + wallThickness, 0])
        wall(total_height, wallThickness, width, 7, 3);

    // bottom
    translate([total_height, wallThickness + 22, 0])
        cube([wallThickness, ipad_gap + 2 * wallThickness, width]);

    //  side
    if (flip) {
        translate([total_height - side_height - side_gap, 22 + wallThickness, width - wallThickness])
            rotate([90, 0, 90])
                wall(ipad_gap + 2 * wallThickness, wallThickness, side_height);
    } else {
        translate([total_height - side_height - side_gap, 22 + wallThickness, 0])
            rotate([90, 0, 90])
                wall(ipad_gap + 2 * wallThickness, wallThickness, side_height);
    }

    //front
    translate([total_height - 120, wallThickness + 22 + wallThickness + ipad_gap])
        wall(120, wallThickness, width, 3, 1);
}

module wall(width, height, depth, radius = 5, spacing = 5 / 2) {
    difference() {
        step = radius * 2 + spacing;
        nrX = floor((width - spacing) / step);
        nrY = floor((depth - spacing) / step);
        startx = (width - nrX * step - spacing) / 2 + radius + spacing;
        starty = (depth - nrY * step - spacing) / 2 + radius + spacing;
        cube([width, height, depth]);
        for (x = [startx : step : width - radius - spacing / 2]) {
            offset = ((x - startx) / step) % 2 == 0 ? 0 : radius + spacing / 2;
            for (y = [starty + offset : step : depth - radius - spacing / 2]) {
                translate([x, height + 1, y])
                    rotate([90, 0, 0])
                        cylinder(height + 2, radius, radius);
            }
        }
    }
}