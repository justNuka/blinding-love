// --- INPUTS ---
// Récupère les entrées clavier
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check(vk_space);
RunningKeyPressed = keyboard_check(vk_shift);

moveDir = rightKey - leftKey;

// --- DÉPLACEMENT HORIZONTAL ---
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

// --- DÉPLACEMENT VERTICAL ---
yspd += grav;

if (jumpKeyPressed && (place_meeting(x, y + 1, obj_Ground)||(doubleJumpAvailable && isFirstJump))) {
	state = State.Jumping
    yspd = jspd;
	if(!place_meeting(x, y + 1, obj_Ground)){
		isFirstJump=false
	}
}

var _subPixel = 0.5;
if (place_meeting(x, y + yspd, obj_Ground)) {
    var _pixelCheck = _subPixel * sign(yspd);
    while (!place_meeting(x, y + _pixelCheck, obj_Ground)) {
        y += _pixelCheck;
    }
    yspd = 0;
}
y += yspd;

// --- LOGIQUE D'ÉTATS ---
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

        if (place_meeting(x, y + 1, obj_Ground)) {
			isFirstJump= true
			doubleJumpAvailable = false
            if (moveDir == 0) state = State.Idle;
            else state = State.Walking;
        }
        break;

    default:
        state = State.Idle;
        break;
}

// --- RÉDUCTION DU CHAMP DE VISION ---

vision_radius -= vision_reduction_rate;

if (vision_radius < vision_min_radius) {
    vision_radius = vision_min_radius;

    // Exemple : condition de défaite
    show_message("Vous avez perdu la vue !");
    game_restart();
}

// --- ATTAQUE MINIMALE (FAIRE UNE HITBOX AVEC UN OBJET ATTACK
// SI TEMPS DISPO) ---

if (keyboard_check_pressed(ord("X"))) {
    var range_attack = 60;
    with (obj_MonsterParent) {
        if (abs(x - other.x) < range_attack) {
            instance_destroy();
        }
    }
}