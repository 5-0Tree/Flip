/// @description Adjust Settings

if (keyboard_check_pressed(vk_f11))
{
	global.fullscreen = !global.fullscreen;
	
	window_set_fullscreen(global.fullscreen)
}

with (obj_editor_control)
{
	if (!altMenu && !open && !saveAs)
	{
		if (keyboard_check_pressed(ord("G")))
		{
			other.showGrid = !other.showGrid;
		}
	}
}

if (!surface_exists(global.surfGUI))
{
	global.surfGUI = surface_create(global.WIDTH, global.HEIGHT);
}
