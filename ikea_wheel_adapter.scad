hauteur = 34.90;
largeur = 36.90;
profondeur = 19.90;
nb_couche = 9;
hole_diameter = 11.6;
hole_position = 18.8;

module IkeaWheelAdapter() {

    module step(hauteur, largeur, profondeur) {
        hull() {
            translate([largeur / 2, 0, 0])
                cube([largeur / 2, profondeur, hauteur]);
            translate([profondeur / 2, profondeur /2, 0])
                cylinder(hauteur, d=profondeur, $fn=200);
        }
    }

    hauteur_serrage = (hauteur - 5.10) / nb_couche;

    difference () {
        union() {
            for (i = [0:nb_couche - 1]) {
                item_profondeur = (i % 2 == 0) ? profondeur - 3.1 : profondeur - 2.25;
                item_largeur = (i % 2 == 0) ? largeur - 1.75 : largeur - 1.2;
                translate([largeur - item_largeur, (profondeur - item_profondeur) / 2, hauteur_serrage * i])
                    step(hauteur_serrage, item_largeur, item_profondeur);
            }
            translate([0, 0, hauteur_serrage * nb_couche])
                step(5.10, largeur, profondeur);
        }
        translate([largeur - 25.5, profondeur / 2, hole_position])
            rotate([0, 90, 0])
            cylinder(26.5, d=hole_diameter, $fn=200);

    }
}

translate([0, 0, hauteur]) rotate([180, 0, 0]) IkeaWheelAdapter();
