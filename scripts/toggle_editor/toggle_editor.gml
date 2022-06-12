/// @description toggle_edit()

function toggle_editor()
{
	global.edit = !global.edit;
	
	global.gameOver = false;
	
	global.screenAngle = 0;
	global.angleFix = 0;
	
	if (instance_exists(obj_editor_control))
	{
		obj_editor_control.altMenu = false;
	}
	
	if (instance_exists(obj_camera))
	{
		with (obj_camera)
		{
			x = global.editX;
			y = global.editY;
			
			xTo = global.editX;
			yTo = global.editY;
		}
	}
	
	with (obj_object_parent)
	{
		active = false;
		
		selected = false;
		
		image_alpha = alpha;
	}
	
	with (obj_dynamic_parent)
	{
		fall = false;
		movable = true;
		move = false;
		canMove = false;
		canFall = true;
		
		image_angle = a_origin;
		x = x_origin;
		y = y_origin;
		
		if (object_get_parent(object_index) == obj_moving_platform_parent)
		{
			atEnd = false;
			
			wpPoint = 0;
		}
		
		if (object_index == obj_player)
		{
			a = 0;
			defAng = image_angle;
			
			rot = -defAng;
			
			xO = x;
			yO = y;
		}
	}
}