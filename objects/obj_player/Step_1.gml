/// @description Move

event_inherited();

with (obj_moving_platform_parent)
{
	if (cond != "Player Over" && move)
	{
		other.canMove = false;
	}
}

if (fall)
{
	image_index = 1;
}

else if (canFall)
{
	image_index = 0;
}

if (image_index == 0 && !global.edit && canMove && ceil(floor(global.screenAngle + 0.5) - 0.5) mod 90 == 0)
{
	var dir = keyboard_check(vk_right) - keyboard_check(vk_left),
		af = global.angleFix,
		sw = sprite_width,
		sh = sprite_height,
		hw = sw / 2,
		hh = sh / 2,
		cl = ds_list_create(),
		cc = collision_point(x + sw * dcos(image_angle), y - sh * dsin(image_angle), obj_collision_parent, false, true),
		cm = collision_point(x - sw * dcos(image_angle), y + sh * dsin(image_angle), obj_collision_parent, false, true);
	
	collision_point_list(x, y, obj_object_parent, false, true, cl, false);
	
	if (!ds_list_empty(cl))
	{
		for (var i = 0; i < ds_list_size(cl); i ++)
		{
			with (cl[| i])
			{
				if (hazard)
				{
					if (haz_color == 0)
					{
						global.gameOver = true;
					}
				}
			}
		}
	}
	
	ds_list_destroy(cl);
	
	if (cc != noone)
	{
		with (cc)
		{
			if (hazard)
			{
				if (haz_color == -1)
				{
					if (haz_type == 0)
					{
						if (dcos(-other.image_angle) == dcos(image_angle - 90) &&
							dsin(other.image_angle) == dsin(image_angle - 90))
						{
							global.gameOver = true;
						}
					}
					
					else if (haz_type == 1)
					{
						//1 Stuff...
					}
					
					else if (haz_type == 2)
					{
						//2 Stuff...
					}
					
					else if (haz_type == 3)
					{
						global.gameOver = true;
					}
				}
			}
		}
	}
	
	if (cm != noone)
	{
		with (cm)
		{
			if (hazard)
			{
				if (haz_color == 1)
				{
					if (haz_type == 0)
					{
						if (dcos(other.image_angle) == dcos(image_angle + 90) &&
							dsin(-other.image_angle) == dsin(image_angle - 90))
						{
							global.gameOver = true;
						}
					}
					
					else if (haz_type == 1)
					{
						//1 Stuff...
					}
					
					else if (haz_type == 2)
					{
						//2 Stuff...
					}
					
					else if (haz_type == 3)
					{
						global.gameOver = true;
					}
				}
			}
		}
	}
	
	if (global.gameOver)
	{
		if (move)
		{
			global.gameOver = false;
		}
		
		else if (room == rm_editor)
		{
			toggle_editor();
			
			exit;
		}
			
		else
		{
			room_restart();
		}
	}
	
	if (abs(dir) == 1 && !move)
	{
		var _x = x + dir * dcos(af) * sw,
			_y = y - dir * dsin(af) * sh,
			_c = collision_point(_x, _y, obj_collision_parent, false, true),
			go = true;
		
		with (_c)
		{
			go = false;
		}
		
		if (go)
		{
			if (a == 0)
			{
				move = true;
				
				a = dir;
				
				rot += a * 90;
				
				xO = x + hw * -(a * pow(dcos(af), abs(dcos(af))) * -pow(a * dsin(af), abs(dsin(af))));
				yO = y + hh * (a * pow(-dcos(af), abs(dcos(af))) * -a * pow(-a * -dsin(af), abs(dsin(af))));
			}
		}
	}
	
	if (abs(a) = 1)
	{
		image_angle -= moveSpeed * a;
			
		x = xO + r * dcos(image_angle + rot + 45 + sign(-a + 1) * 90 + af);
		y = yO - r * dsin(image_angle + rot + 45 + sign(-a + 1) * 90 + af);
		
		if (image_angle == defAng - a * rc * 90)
		{
			move = false;
			
			rot += a * (rc - 1) * 90;
			rc = 1;
			
			a = 0;
			defAng = image_angle;
			
			s = false;
		}
	}
}
