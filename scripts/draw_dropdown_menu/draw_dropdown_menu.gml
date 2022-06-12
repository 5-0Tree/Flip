/// @description draw_dropdown_menu(inst, _x, _y)

function draw_dropdown_menu(inst, _x, _y, _x2, _y2)
{
	draw_set_alpha(0.85)
	
	draw_rectangle(_x + 64, _y + 8, _x2 - 64, _y2 - 8, false);
	
	draw_set_alpha(1.0)
	
	draw_rectangle(_x + 64, _y + 8, _x2 - 64, _y2 - 8, true);
	
	with (inst)
	{
		if (keyboard_check(vk_escape) || array_length(editables) < 1)
		{
			return -1;
			
			break;
		}
		
		for (var i = 0; i < array_length(editables); i ++)
		{
			
		}
	}
}
