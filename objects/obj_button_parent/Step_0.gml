switch (state)
{
	case ButtonStates.create:
		image_xscale += 0.05
		if(image_xscale >= 1)
		{
			image_xscale = 1
			state = ButtonStates.normal
		}
		image_yscale = image_xscale
		break;
	case ButtonStates.normal:
		if(point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
		{
			state = ButtonStates.hover
			sprite_index = sButton_play_hover
		}
		break;
	case ButtonStates.hover:
		if(!point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
		{
			state = ButtonStates.normal
			sprite_index = sButton_play
		}
		else 
		{
			if (mouse_check_button_pressed(mb_left))
			{
				state = ButtonStates.pressed;
				sprite_index = sButton_play_hover
			}
		}
		break;
	case ButtonStates.pressed:
		event_user(0);
		image_index = 0
		break;
	case ButtonStates.destroy:
		event_user(1);
		instance_destroy();
		break;
}