pressed = true;
audio_play_sound(sndQuit, 1, false);
with (obj_button_parent)
{
	state = b_state.destroy;
}