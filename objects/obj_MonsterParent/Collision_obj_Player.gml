/// obj_MonsterParent

other.state = State.Dead;

with (other) {
    vision_radius -= 30;
    if (vision_radius < 1) {
       vision_radius = 1;
       show_message("Vous avez perdu la vue !");
       game_restart();
    }
}
