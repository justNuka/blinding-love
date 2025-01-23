/// obj_MonsterParent - Create

//global.monsters_alive += 1;
state = "wander";
obj_RoomControl.monsters_in_room ++;

speed_walk = 1.5;
speed_run = 2.5;
hdir = choose(-1, 1);

wander_timer = 0;
idle_timer = 0;

detection_range = 450; // mettre 500 si trop petit
sprIdle = -1;
sprWalk = -1;
sprRun = -1;
sprDeath = -1;