/// @description init front end
game_set_speed(60,gamespeed_fps);

var _x = room_width / 2
var _y = room_height / 2

instance_create_layer(_x, _y - 100, "Pickups", obj_Button_play)
instance_create_layer(_x, _y + 100, "Pickups", obj_Button_quit)