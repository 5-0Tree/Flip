/// @description Follow Path

var sw = sprite_width,
	sh = sprite_height,
	_c = collision_point(x - sw / 1.5 * dsin(image_angle), y - sh / 1.5 * dcos(image_angle), obj_dynamic_parent, false, true),
	_o = collision_point(x, y, obj_waypoint, false, true);

if (_o != noone)
{
	if (!init)
	{
		with (_o)
		{
			if (_o.wpType == 1)
			{
				other.wp = _o;
			}
			
			if (_o.wpType == 2)
			{
				other.atEnd = true;
			}
		}
		
		init = true;
	}
}

else
{
	init = false;
}

if (!global.edit && (dsin(image_angle) == dsin(global.angleFix)) && (dcos(image_angle) == dcos(global.angleFix)))
{
	if (_c != noone)
	{
		with (_c)
		{
			if (other.cond == other.accConds[0])
			{
				if (object_index == obj_player)
				{
					if (!fall)
					{
						other.canMove = true;
					}
				}
			}
			
			if (other.cond == other.accConds[1])
			{
				if (!fall)
				{
					other.canMove = true;
				}
			}
			
			if (other.cond == other.accConds[2])
			{
				if (hazard)
				{
					if (!fall)
					{
						other.canMove = true;
					}
				}
			}
		}
	}
}

if (!global.edit)
{
	if (cond == accConds[3])
	{
		with (obj_button_parent)
		{
			for (var i = 0; i < array_length(trigger); i ++)
			{
				if (active)
				{
					if (trigger[i] == other.ID)
					{
						other.canMove = true;
					}
				}
			}
		}
	}
}

if (canMove && wp != noone && !atEnd && !global.edit)
{
	with (wp)
	{
		var _s = other,
			_px = pl[_s.wpPoint][0],
			_py = pl[_s.wpPoint][1],
			_dir = point_direction(_s.x, _s.y, _px, _py);
		
		if (_s.x == _px && _s.y == _py)
		{
			_s.wpPoint ++;
			
			with (obj_waypoint)
			{
				if (wpType == 2)
				{
					if (x == _s.x && y == _s.y)
					{
						with (_s)
						{
							atEnd = true;
						}
					}
				}
			}
		}
		
		else
		{
			if (_c != noone)
			{
				with (_c)
				{
					if (!move)
					{
						_s.x += lengthdir_x(other.moveSpeed, _dir);
						_s.y += lengthdir_y(other.moveSpeed, _dir);
						
						x += lengthdir_x(other.moveSpeed, _dir);
						y += lengthdir_y(other.moveSpeed, _dir);
						
						image_index = 1;
						
						canMove = false;
						canFall = false;
					}
				}
			}
			
			else
			{
				_s.x += lengthdir_x(moveSpeed, _dir);
				_s.y += lengthdir_y(moveSpeed, _dir);
			}
		}
	}
	
	move = true;
}

if (atEnd)
{
	if (_c != noone)
	{
		with (_c)
		{
			image_index = 0;
			
			canMove = true;
			canFall = true;
		}
	}
	
	canMove = false;
	move = false;
}
