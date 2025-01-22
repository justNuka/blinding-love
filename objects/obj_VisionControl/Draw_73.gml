var radius = 0

if(instance_exists(obj_Player)){
	radius = obj_Player.vision_radius
}

// Ensuite, on applique la logique
if (radius <= 0) {
    // vision nulle => tout noir
    var vw = camera_get_view_width(view_camera[0]);
    var vh = camera_get_view_height(view_camera[0]);
    draw_set_color(c_black);
    draw_rectangle(0, 0, vw, vh, false);
}
else if (radius < 9999) {
    // On dessine le rectangle noir + trou
    var vw = camera_get_view_width(view_camera[0]);
    var vh = camera_get_view_height(view_camera[0]);
    draw_set_color(c_black);
    draw_rectangle(0, 0, vw, vh, false);

    // On passe en mode subtract pour "percer" un trou
    gpu_set_blendmode(bm_subtract);

    // Calcul de la position du joueur sur l'écran
    var screen_x = obj_Player.x - camera_get_view_x(view_camera[0]);
    var screen_y = obj_Player.y - camera_get_view_y(view_camera[0]);

    draw_set_color(c_white);
    draw_circle(screen_x, screen_y, radius, false);

    gpu_set_blendmode(bm_normal);
}

show_debug_message("Player x= " + string(obj_Player.x) 
    + ", cam_x= " + string(camera_get_view_x(view_camera[0])) 
    + ", screen_x= " + string(screen_x));


// draw_self()