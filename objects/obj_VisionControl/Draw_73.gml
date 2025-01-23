/// obj_VisionControl - Draw End

if instance_exists(obj_Player) {
    var cam = view_camera[0];
    var screen_x = obj_Player.x - camera_get_view_x(cam);
    var screen_y = obj_Player.y - camera_get_view_y(cam);
	
	var hole_diameter_in_sprite = 25;

    var max_radius = 300;
    var scale = obj_Player.vision_radius / hole_diameter_in_sprite;
    if (scale < 0) scale = 0; 
    //if (scale > 1) scale = 1;

    draw_sprite_ext(
        sReductionVision,
        0,
        screen_x,
        screen_y,
        scale,
        scale,
        0,
        c_white,
        1
    );
}
