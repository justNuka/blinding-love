// Inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check(vk_space);
RunningKeyPressed = keyboard_check(vk_shift);

moveDir = rightKey - leftKey;

// Déplacements horizontaux
if (keyboard_check(vk_shift)) {
    xspd = moveDir * runSpd;
} else {
    xspd = moveDir * moveSpd;
}

var _subPixel = 0.5;
if (place_meeting(x + xspd, y, obj_Ground)) {
    var _pixelCheck = _subPixel * sign(xspd);
    while (!place_meeting(x + _pixelCheck, y, obj_Ground)) {
        x += _pixelCheck;
    }
    xspd = 0;
}
x += xspd;

// Déplacements verticaux
yspd += grav;

if (jumpKeyPressed && (place_meeting(x, y + 1, obj_Ground)||(doubleJumpAvailable && isFirstJump))) {
	state = State.Jumping
    yspd = jspd;
	noCollision=true
	if(!place_meeting(x, y + 1, obj_Ground) && yspd<0){
		isFirstJump=false
	}
}

var _subPixel = 0.5;
if (place_meeting(x, y + yspd, obj_Ground) && !noCollision) {
    var _pixelCheck = _subPixel * sign(yspd);
    while (!place_meeting(x, y + _pixelCheck, obj_Ground)) {
        y += _pixelCheck;
    }
    yspd = 0;
}
y += yspd;

// Les états du player
switch (state) {
    case State.Idle:
        sprite_index = Elle_Idle;
        image_speed = 0.2;

        if (moveDir != 0) {
            state = State.Walking;
        }
        break;

    case State.Walking:
        sprite_index = Elle_Walk;
        image_speed = 0.3;

        if (moveDir == 0) {
            state = State.Idle;
        }

        if (keyboard_check(vk_shift)) {
            state = State.Running;
        }

        if (!place_meeting(x, y + 1, obj_Ground)) {
            state = State.Jumping;
        }

        if (moveDir < 0) image_xscale = -1;
        if (moveDir > 0) image_xscale = 1;
        break;

    case State.Running:
        sprite_index = Elle_Run;
        image_speed = 0.5;

        if (!keyboard_check(vk_shift)) {
            state = State.Walking;
        }

        if (moveDir == 0) {
            state = State.Idle;
        }

        if (!place_meeting(x, y + 1, obj_Ground)) {
            state = State.Jumping;
        }
		
        if (moveDir < 0) image_xscale = -1;
        if (moveDir > 0) image_xscale = 1;
        break;

    case State.Jumping:
        sprite_index = Elle_Jump;
        image_speed = 0.3;

        if (moveDir != 0) {
            if (moveDir < 0) image_xscale = -1;
            if (moveDir > 0) image_xscale = 1;
        }
		
		if(!jumpKeyPressed && isFirstJump) {
			doubleJumpAvailable = true
		}
		if(yspd<0){
			noCollision = true	
		}else if(noCollision && !place_meeting(x, y + 1, obj_Ground)){
			noCollision = false
		}

        if (place_meeting(x, y + 1, obj_Ground) && !noCollision) {
			isFirstJump= true
			doubleJumpAvailable = false
            if (moveDir == 0) state = State.Idle;
            else state = State.Walking;
        }

        break;
	
	case State.Attacking:
		attack_sprite = choose(Elle_Attack_1, Elle_Attack_2);
        sprite_index = attack_sprite;
		image_index = 0
        image_speed  = 0.3;

        xspd = 0; 

        if (image_index >= image_number - 1) {
            if (moveDir != 0) state = State.Walking;
            else state = State.Idle;
            image_index = 0;
        }

    default:
        state = State.Idle;
        break;
}

// Champ de vision qui se réduit

vision_radius -= vision_reduction_rate;

if (vision_radius < vision_min_radius) {
    vision_radius = vision_min_radius;

    // Exemple : condition de défaite
    show_message("Vous avez perdu la vue !");
    game_end();
}


// Attaque
if (keyboard_check_pressed(vk_tab)) {
    state = State.Attacking;

    var direction_sign = image_xscale;
    var attack_range = 150;

    with (obj_MonsterParent) {
        var dx_m = x - other.x;
        if (direction_sign * dx_m > 0 && abs(dx_m) < attack_range) {
            state = "death"; 
            image_index = 0;
        }
    }
}