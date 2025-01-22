if (target_room == noone) {
    show_debug_message("ERREUR : target_room n'est pas défini ou est invalide !");
} else {
	show_debug_message("Instance utilisée : " + string(id));
    show_debug_message("Target Room : " + string(target_room));
    show_debug_message("Collision détectée. Changement de room vers : " + string(target_room));
    room_goto(target_room); // Change de room
    obj_Player.x = target_x; // Position X
    obj_Player.y = target_y; // Position Y
}