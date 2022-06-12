/// @description Draw Connections

if (wpType == 1)
{
	var _tnum = [id],
		_n = 1;
	
	with (obj_waypoint)
	{
		if (wpID = other.wpID)
		{
			for (var i = 0; i < instance_number(obj_waypoint); i ++)
			{
				with (instance_find(obj_waypoint, i))
				{
					if (wpID = other.wpID)
					{
						if (wpNum == _n)
						{
							depth = 18;
							
							_tnum[_n] = id;
							
							_n ++;
						}
					}
				}
			}
		}
	}
	
	if (array_length(_tnum) > 1)
	{
		for (var i = 0; i < array_length(_tnum) - 1; i ++)
		{
			draw_set_color($000000);
			draw_set_alpha(0.5 * image_alpha);
			
			draw_line_width(_tnum[i].x, _tnum[i].y, _tnum[i + 1].x, _tnum[i + 1].y, 2);
			
			draw_set_color($FFFFFF);
			draw_set_alpha(1.0 * image_alpha);
			
			draw_line_width(_tnum[i].x - 1, _tnum[i].y - 1, _tnum[i + 1].x - 1, _tnum[i + 1].y - 1, 2);
			
			draw_set_alpha(1.0);
		}
	}
}

draw_self();
