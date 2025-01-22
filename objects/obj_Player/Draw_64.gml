// Dessine la barre de vision
var max_radius = 200;
var bar_width = 200;
var bar_height = 20;

var current_width = (vision_radius / max_radius) * bar_width;

draw_set_color(c_black);
draw_rectangle(10, 10, 10 + bar_width, 10 + bar_height, false); // Fond de la barre
draw_set_color(c_white);
draw_rectangle(10, 10, 10 + current_width, 10 + bar_height, false); // Barre actuelle