/// @description Activate Button

var _c = collision_point(x - 16 / 1.5 * dsin(image_angle), y - 16 / 1.5 * dcos(image_angle), obj_dynamic_parent, false, true);

if (!global.edit)
{
	if (_c != noone)
	{
		with (_c)
		{
			if (other.cond == other.accConds[0])
			{
				if (object_index == obj_player)
				{
					if (!fall && (dsin(image_angle) == 0 || dcos(image_angle) == 0))
					{
						other.active = true;
					}
				}
			}
			
			if (other.cond == other.accConds[1])
			{
				if (!fall)
				{
					other.active = true;
				}
			}
			
			if (other.cond == other.accConds[2])
			{
				if (hazard)
				{
					if (!fall)
					{
						other.active = true;
					}
				}
			}
		}
	}
}
