// Step Event de obj_Monster
// Récup la position du player
var dx = obj_Player.x - x;
var dy = obj_Player.y - y;
var dist = point_distance(x, y, obj_Player.x, obj_Player.y);

// Avancer vers lui
if (dist > 0) {
    x += (dx / dist) * monster_speed;
    y += (dy / dist) * monster_speed;
}

// Si collision avec player => player meurt
/*if (place_meeting(x, y, obj_Player)) {
    with (obj_Player) {
        // ex: state = State.Dead;
        // ou vie -= 1;
        // ou show_message("You died");
        instance_destroy(); // test minimal
    }
}
