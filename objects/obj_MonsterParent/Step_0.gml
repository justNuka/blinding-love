/// obj_MonsterParent - Step

if !instance_exists(obj_Player) {
    exit;
}

var dist = point_distance(x, y, obj_Player.x, obj_Player.y);

// --- Gestion de l'état ---
switch (state) {
    
    case "wander":
        if (place_free(x + hdir * speed_walk, y)) {
            x += hdir * speed_walk;
        } else {
            hdir = -hdir;
        }

        if (dist < detection_range) {
            state = "chase";
        }

        if (random(100) < 1) {
            hdir = choose(-1, 1);
        }
		// Rajouter le idle dans le wander state quand le reste est OK

    break;

    case "chase":
        if (obj_Player.x < x) {
            hdir = -1;
        } else {
            hdir = 1;
        }

        var chase_speed = speed_walk * 1.8;
        if (place_free(x + hdir * chase_speed, y)) {
            x += hdir * chase_speed;
        }

        if (dist > detection_range + 50) {
            state = "wander";
        }
    break;
}

if (hdir < 0) {
    image_xscale = -1;
} else if (hdir > 0) {
    image_xscale = 1;
}