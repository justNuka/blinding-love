//global.monsters_alive -= 1;
obj_RoomControl.monsters_in_room --;

if (global.monsters_alive < 0) {
    global.monsters_alive = 0;
}
