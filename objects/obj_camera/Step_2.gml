/// @description Camera Movement

global.screenAngle += ((global.angleFix - global.screenAngle) / global.screenRotSpd);

if (!global.edit)
{
	if (_spd == -1)
	{
		if (instance_number(obj_player) == 1)
		{
			x = obj_player.x;
			y = obj_player.y;
			
			xTo = obj_player.x;
			yTo = obj_player.y;
		}
		
		_spd = spd;
	}
	
	x += (xTo - x) / _spd;
	y += (yTo - y) / _spd;
	
	if (instance_number(obj_player) == 1)
	{
		xTo = obj_player.x;
		yTo = obj_player.y;
	}
}

else
{
	if (keyboard_check(vk_control))
	{
		global.ZOOM += (mouse_wheel_down() - mouse_wheel_up()) * 0.1;
	}
	
	global.ZOOM = clamp(global.ZOOM, 0.5, 2);
	
	x = clamp(x, 0, global.maxGridWidth * 16);
	y = clamp(y, 0, global.maxGridHeight * 16);
	
	global.editX = x;
	global.editY = y;
}

var CANG = floor(dcos(global.screenAngle) * 100) / 100,
	SANG = floor(dsin(global.screenAngle) * 100) / 100,
	vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0),
	pm = matrix_build_projection_ortho(global.WIDTH * global.ZOOM, global.HEIGHT * global.ZOOM, 1.0, 32000.0);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);
