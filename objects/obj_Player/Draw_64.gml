/// obj_Player - Draw GUI

// Largeur max de la vision
var max_radius = 300; // correspond à la valeur initiale
var ratio = vision_radius / max_radius;

// On clamp pour éviter de dépasser 1 ou tomber < 0
if (ratio > 1) ratio = 1;
if (ratio < 0) ratio = 0;

// Taille de la barre
var bar_width  = 200;
var bar_height = 20;

// Calcul de la largeur actuelle
var current_width = ratio * bar_width;

// Dessin de la barre
draw_set_color(c_black);
draw_rectangle(10, 10, 10 + bar_width, 10 + bar_height, false); // fond
draw_set_color(c_white);
draw_rectangle(10, 10, 10 + current_width, 10 + bar_height, false); // partie blanche
