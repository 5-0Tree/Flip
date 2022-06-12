/// @description Falling & Update Values

event_inherited();

if (movable && !global.edit)
{
	if (ceil(floor(global.screenAngle + 0.5) - 0.5) mod 90 == 0)
	{
		if (!place_meeting(x - lengthdir_y(4, global.angleFix),
		 y + lengthdir_x(4, global.angleFix), obj_collision_parent))
		{
			if (canFall)
			{
				x -= lengthdir_y(4, global.angleFix);
				y += lengthdir_x(4, global.angleFix);
				
				fall = true;
			}
		}
		
		else
		{
			fall = false;
		}
	}
}

accAttr = {
	Main : {
		Color : color[0],
		Angle : image_angle,
		Alpha : alpha,
		Group : group,
		Layer : editLayer,
		Locked : locked,
		Condition : undefined,
		Speed : undefined,
		Trigger : undefined
	}
};
