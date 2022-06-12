/// @description Editor Controls

if (global.edit)
{
	if (!altMenu)
	{
		if (keyboard_check(vk_alt))
		{
			if (keyboard_check_pressed(ord("D")))
			{
				with (obj_object_parent)
				{
					selected = false;
				}
			}
		}
		
		else
		{
			//var _ds = ds_list_create(),
			//	_i = 0,
			//	_h = false,
			//	id_arr = [],
			//	x_arr = 0,
			//	y_arr = 0;
				
			//with (obj_object_parent)
			//{
			//	if (selected)
			//	{
			//		_ds[| _i] = id;
					
			//		_i ++;
			//	}
			//}
			
			//for (var i = 0; i < ds_list_size(_ds); i ++)
			//{
			//	with (_ds[| i])
			//	{
			//		var colp = object_get_parent(object_index) == obj_collision_parent;
					
			//		id_arr[i] = id;
			//		x_arr[i] = x;
			//		y_arr[i] = y;
					
			//		if (!colp)
			//		{
			//			x += (keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"))) * 16;
			//			y += (keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"))) * 16;
			//		}
			//	}
			//}
			
			//if (array_length(id_arr) > 0)
			//{
			//	global.hist[global.hNum] = ["Move", [id_arr, x_arr, y_arr]];
			
			//	array_resize(global.hist, global.hNum + 1);
			
			//	for (var j = 0; j < array_length(id_arr); j ++)
			//	{
			//		global.hist[global.hNum][1] = [id_arr, x_arr, y_arr];
			//	}
				
			//	_h = true;
			//}
			
			//if (_h)
			//{
			//	global.hNum ++;
			//}
			
			if (keyboard_check_pressed(ord("Q")))
			{
				angle += 90;
			}
			
			if (keyboard_check_pressed(ord("E")))
			{
				angle -= 90;
			}
			
			if (keyboard_check(vk_control))
			{
				if (keyboard_check_pressed(ord("S")))
				{
					//Save as
					if (keyboard_check(vk_shift))
					{
						keyboard_string = "";
						
						saveAs = true;
					}
					
					//Save
					else
					{
						keyboard_string = "";
						
						save = true;
					}
					
					lchanged = false;
				}
				
				if (keyboard_check_pressed(ord("O")))
				{
					open = true;
				}
				
				if (keyboard_check_pressed(ord("Z")) && array_length(wpPlace) == 0 && !altMenu && !open)
				{
					with (obj_object_parent)
					{
						selected = false;
					}
					
					//Redo
					if (keyboard_check(vk_shift))
					{
						if (global.hNum < array_length(global.hist))
						{
							if (global.hist[global.hNum][0] == "Add")
							{
								for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
								{
									instance_activate_object(global.hist[global.hNum][1][i]);
								}
								
								global.hNum ++;
							}
							
							else if (global.hist[global.hNum][0] == "Delete")
							{
								for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
								{
									instance_deactivate_object(global.hist[global.hNum][1][i]);
								}
								
								global.hNum ++;
							}
						}
					}
					
					//Undo
					else
					{
						if (global.hNum > 0)
						{
							if (global.hist[global.hNum - 1][0] == "Add")
							{
								global.hNum --;
								
								for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
								{
									instance_deactivate_object(global.hist[global.hNum][1][i]);
								}
							}
							
							else if (global.hist[global.hNum - 1][0] == "Delete")
							{
								global.hNum --;
								
								for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
								{
									instance_activate_object(global.hist[global.hNum][1][i]);
								}
							}
							
							//else if (global.hist[global.hNum - 1][0] == "Move")
							//{
							//	global.hNum --;
								
							//	for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
							//	{
							//		with (global.hist[global.hNum][1][i, [0]])
							//		{
							//			x = global.hist[global.hNum][1][i, [1]];
							//			y = global.hist[global.hNum][1][i, [2]];
							//		}
							//	}
							//}
						}
					}
				}
			}
		}
	}
}
