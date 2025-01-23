/// obj_MonsterParent - Create

//global.monsters_alive += 1;
obj_RoomControl.monsters_in_room ++;

speed_walk = 1.5;
hdir = choose(-1, 1);
detection_range = 450; // mettre 500 si trop petit
state = "wander";