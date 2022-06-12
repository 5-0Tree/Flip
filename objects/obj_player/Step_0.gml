/// @description Gravity Controls

var nn = 0;

with (obj_dynamic_parent)
{
	nn ++;
}

global.canRotate = true;

for (var i = 0; i < nn; i ++)
{
	with (instance_find(obj_dynamic_parent, i))
	{
		if (move || fall)
		{
			global.canRotate = false;
		}
	}
}

var sw = sprite_width,
	sh = sprite_height;

if (collision_line(x - sw, y, x + sw, y, obj_wall_sp_anti, false, true) == noone &&
	collision_line(x, y - sh, x, y + sh, obj_wall_sp_anti, false, true) == noone && !global.edit)
{
	with (obj_dynamic_parent)
	{
		if (movable || object_index == obj_moving_platform_parent)
		{
			if (!move && !fall && ceil(floor(global.screenAngle + 0.5) - 0.5) mod 90 == 0 && global.canRotate)
			{
				if (keyboard_check_pressed(ord("W")))
				{
					global.angleFix += 180;
					
					global.canRotate = false;
				}
				
				if (keyboard_check_pressed(ord("A")))
				{
					global.angleFix -= 90;
					
					global.canRotate = false;
				}
				
				if (keyboard_check_pressed(ord("D")))
				{
					global.angleFix += 90;
					
					global.canRotate = false;
				}
			}
		}
	}
}

canMove = !global.edit;
