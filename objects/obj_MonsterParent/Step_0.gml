/// obj_MonsterParent - Step

if !instance_exists(obj_Player) {
    exit;
}

var dist = point_distance(x, y, obj_Player.x, obj_Player.y);

// --- Gestion de l'état ---
switch (state) {
	case "idle":
		sprite_index = sprIdle;
		image_speed = 0.2;
		
		if (idle_timer > 0) {
			idle_timer -= 1;
		} else {
			state = "wander";
		}
		
		if (dist < detection_range) {
			state = "chase";
		}
		break;
    case "wander":
		sprite_index = sprWalk;
		image_speed = 0.3;
		
        if (place_free(x + hdir * speed_walk, y)) {
            x += hdir * speed_walk;
        } else {
            hdir = -hdir;
        }
		
		if (hdir < 0) image_xscale = -1; else image_xscale =1;
		
		if (random(100) < 1) {
			state = "idle";
			idle_timer = irandom_range(30, 90);
		}

        if (dist < detection_range) {
            state = "chase";
        }

        if (random(100) < 1) {
            hdir = choose(-1, 1);
        }
	break;

    case "chase":
	
		sprite_index = sprRun;
		image_speed = 0.4;
		
        if (obj_Player.x < x) {
            hdir = -1;
        } else {
            hdir = 1;
        }
		
		if (hdir < 0) {
			image_xscale = -1;
		} else {
			image_xscale = 1;
		}
	
        if (place_free(x + hdir * speed_run, y)) {
            x += hdir * speed_run;
        }
		
		if (round(x) == round(obj_Player.x)){
			state = "idle";
			idle_timer = 30;
		}

        if (dist > detection_range + 50) {
            state = "wander";
        }
    break;
	
	case "death":
		sprite_index = sprDeath;
		image_speed = 0.3;
		
		if (image_index >= (image_number -1)){
			instance_destroy()
		}
}

if (hdir < 0) {
    image_xscale = -1;
} else if (hdir > 0) {
    image_xscale = 1;
}