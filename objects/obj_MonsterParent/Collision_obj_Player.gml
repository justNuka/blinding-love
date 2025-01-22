/// obj_MonsterParent - Collision with obj_Player

// other.state = State.Dead;
// game_restart()

with (other) {
    vision_radius -= 50;
    if (vision_radius < 0) {
       vision_radius = 0;
       show_message("Vous avez perdu la vue !");
       game_restart();
    }
}