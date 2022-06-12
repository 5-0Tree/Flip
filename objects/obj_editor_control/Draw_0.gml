/// @description Draw Editor Main Area

var _x = (global.editX - global.WIDTH / 2 * global.ZOOM),
	_y = (global.editY - global.HEIGHT / 2 * global.ZOOM),
	_x2 = (global.editX + global.WIDTH / 2 * global.ZOOM),
	_y2 = (global.editY + global.HEIGHT / 2 * global.ZOOM),
	mx = mouse_x,
	my = mouse_y,
	grid_x = floor(mx / 16) * 16,
	grid_y = floor(my / 16) * 16;

if (global.edit)
{
	grid_x = floor(clamp(grid_x, 0, room_width - global.WIDTH / 2) / 16) * 16;
	grid_y = floor(clamp(grid_y, 0, room_height - global.HEIGHT / 2) / 16) * 16;
	
	if (mx > _x + (58 * global.expanded * global.ZOOM) &&
	 !(mx > _x2 - (40 * global.ZOOM) && my > _y2 - (16 * global.ZOOM)) &&
	 !keyboard_check(vk_space) && !expandPressed && !clickingButton)
	{
		var _h = false,
			_l = [],
			id_arr = [];
		
		if (object_exists(selObj))
		{
			if (selObj == obj_waypoint)
			{
				with (obj_waypoint)
				{
					if (wpID == other.wpID)
					{
						if (wpNum == other.wpNum - 1)
						{
							if (abs(x - mouse_x) < abs(y - mouse_y))
							{
								grid_x = x - 8;
							}
							
							else
							{
								grid_y = y - 8;
							}
						}
					}
				}
			}
			
			if (!keyboard_check(vk_control) && !altMenu && !open && !saveAs)
			{
				if (sprite_get_number(object_get_sprite(selObj)) > 0 && asset_has_tags(object_get_sprite(selObj), "Block", asset_sprite))
				{
					draw_sprite_ext(object_get_sprite(selObj), 1, grid_x + 8, grid_y + 8, 1, 1, angle, $FFFFFF, 0.6);
				}
				
				draw_sprite_ext(object_get_sprite(selObj), 0, grid_x + 8, grid_y + 8, 1, 1, angle, $FFFFFF, 0.6);
				
				if ((mouse_check_button_pressed(mb_left) && selObj == obj_waypoint) ^^ (mouse_check_button(mb_left) && selObj != obj_waypoint))
				{
					with (obj_object_parent)
					{
						selected = false;	
					}
					
					var can_place = false,
						_ds = ds_list_create();
					
					if (collision_point(grid_x + 8, grid_y + 8, obj_object_parent, false, true) != noone)
					{
						if (selObj == obj_waypoint)
						{
							if (collision_point(grid_x + 8, grid_y + 8, obj_waypoint, false, true) != noone)
							{
								can_place = false;
							}
							
							else
							{
								can_place = true;
							}
						}
						
						else
						{
							collision_point_list(grid_x + 8, grid_y + 8, obj_object_parent, false, true, _ds, false);
							
							for (var i = 0; i < ds_list_size(_ds); i ++)
							{
								if (_ds[| i].object_index == obj_waypoint)
								{
									can_place = true;
								}
								
								else
								{
									can_place = false;
									
									break;
								}
							}
						}
					}
					
					else
					{
						can_place = true;
					}
					
					if (ds_list_size(_ds) == 1)
					{
						if (_ds[| 0].object_index == obj_spikes)
						{
							can_place = true;
						}
					}
					
					ds_list_destroy(_ds);
					
					if (can_place && global.go)
					{
						with (instance_create_layer(grid_x + 8, grid_y + 8, "Objects", selObj))
						{
							var id_arr = [id],
								_b = false,
								_p = false;
							
							if (object_index == obj_waypoint)
							{
								_p = true;
								
								wpID = other.wpID;
								wpNum = other.wpNum;
								wpType = other.wpType;
								
								with (obj_waypoint)
								{
									if (wpID == other.wpID)
									{
										if (wpType == 1)
										{
											pl[other.wpNum] = [other.x, other.y];
										}
									}
								}
								
								other.wpNum ++;
								
								if (other.wpType == 1)
								{
									other.wpType = 0;
								}
								
								var in = 0;
								
								with (obj_waypoint)
								{
									if (wpID == other.wpID)
									{
										id_arr[in] = id;
										
										in ++;
									}
								}
								
								other.wpPlace = id_arr;
							}
							
							image_angle = other.angle;
							
							if (object_index == obj_spikes)
							{
								var _ds = ds_list_create();
								
								collision_point_list(x, y, obj_spikes, false, true, _ds, false);
								
								for (var i = 0; i < ds_list_size(_ds); i ++)
								{
									with (_ds[| i])
									{
										if (dsin(image_angle) == dsin(other.image_angle) && dcos(image_angle) == dcos(other.image_angle))
										{
											instance_destroy(other);
										
											_b = true;
										}
									}
								}
								
								ds_list_destroy(_ds);
							}
							
							if (object_index == obj_player)
							{
								defAng = image_angle;
								
								rot = -defAng;
							}
							
							editLayer = max(0, global.Layer);
							
							a_origin = image_angle;
							x_origin = x;
							y_origin = y;
							
							if (!_b)
							{
								global.hist[global.hNum] = ["Add", id_arr];
								
								if (!_p)
								{
									global.hNum ++;
								}
								
								array_resize(global.hist, global.hNum);
							}
							
							other.lchanged = true;
						}
					}
				}
			}
		}
		
		if (selObj == -1)
		{
			if (mouse_check_button_pressed(mb_left))
			{
				if (keyboard_check(vk_alt))
				{
					var _go = false;
					
					with (collision_point(mouse_x, mouse_y, obj_object_parent, false, true))
					{
						if (selected)
						{
							_go = true;
						}
					}
					
					if (_go && !keyboard_check(vk_shift))
					{
						var _c = 0,
							tcol = [],
							mixed = [
								false,
								false
							];
						
						with (obj_object_parent)
						{
							if (selected)
							{
								tcol[0][_c] = color[0];
								tcol[1][_c] = color[1];
								
								_c ++;
							}
						}
						
						for (var i = 0; i < 2; i ++)
						{
							for (var j = 0; j < array_length(tcol[i]); j ++)
							{
								with (obj_object_parent)
								{
									if (selected)
									{
										if (tcol[i][j] != color[i])
										{
											mixed[i] = true;
											
											break;
										}
									}
								}
							}
							
							{
								selCol[i] = tcol[i][0];
							}
						}
						
						selectingCol = true;
						
						altMenu = true;
					}
				}
				
				else if (!keyboard_check(vk_shift) && !altMenu && !open && !saveAs)
				{
					with (obj_object_parent)
					{
						selected = false;
					}
				}
			}
		}
		
		if (keyboard_check(vk_shift) && !altMenu && !open && !saveAs)
		{
			if (mouse_check_button_pressed(mb_left))
			{
				selectX = device_mouse_x(0);
				selectY = device_mouse_y(0);
			}
			
			if (selObj == -1)
			{
				if (mouse_check_button(mb_left))
				{
					selectXto = device_mouse_x(0);
					selectYto = device_mouse_y(0);
					
					draw_set_color($00FF00);
					draw_set_alpha(0.5);
					
					draw_rectangle(selectX, selectY, selectXto, selectYto, false);
					
					draw_set_alpha(1.0);
					
					draw_rectangle(selectX, selectY, selectXto, selectYto, true);
					
					draw_set_color($FFFFFF);
					
					if (!keyboard_check(vk_control))
					{
						with (obj_object_parent)
						{
							selected = false;
						}
					}
					
					var _ds = ds_list_create();
					
					collision_rectangle_list(selectX, selectY, mouse_x, mouse_y, obj_object_parent, false, true, _ds, false);
					
					for (var i = 0; i < ds_list_size(_ds); i ++)
					{
						with (_ds[| i])
						{
							if (editLayer == global.Layer || global.Layer == -1)
							{
								selected = true;
							}
						}
					}
					
					ds_list_destroy(_ds);
				}
			}
		}
		
		if (mouse_check_button(mb_right) && !altMenu && !open && !saveAs)
		{
			var _ds = ds_list_create(),
				_b = false,
				id_arr = [];
			
			collision_point_list(mouse_x, mouse_y, obj_object_parent, false, true, _ds, true);
			
			for (var i = 0; i < ds_list_size(_ds); i ++)
			{
				with (_ds[| i])
				{
					id_arr = [id];
					
					if (object_index == obj_waypoint)
					{
						other.wpID ++;
						other.wpNum = 0;
						other.wpType = 1;
						other.wpPlace = [];
						
						var in = 0;
						
						with (obj_waypoint)
						{
							if (wpID == other.wpID)
							{
								id_arr[in] = id;
								
								in ++;
							}
						}
					}
					
					if (object_index == obj_spikes)
					{
						if (ds_list_size(_ds) > 1)
						{
							id_arr[i] = id;
							
							if (i < ds_list_size(_ds) - 1)
							{
								continue;
							}
						}
					}
					
					if (global.go && (editLayer == global.Layer || global.Layer < 0))
					{
						global.hist[global.hNum] = ["Delete", id_arr];
						global.hNum ++;
						
						array_resize(global.hist, global.hNum);
						
						for (var j = 0; j < array_length(id_arr); j ++)
						{
							instance_deactivate_object(id_arr[j]);
						}
						
						other.lchanged = true;
					}
				}
				
				if (_b)
				{
					global.go = false;
						
					break;
				}
			}
			
			ds_list_destroy(_ds);
		}
		
		if (keyboard_check_pressed(vk_delete) || keyboard_check_pressed(vk_backspace))
		{
			var _ds = ds_list_create(),
				_i = 0,
				_h = false,
				_b = false,
				_l = [],
				id_arr = [];
			
			with (obj_object_parent)
			{
				if (selected)
				{
					_ds[| _i] = id;
					
					_i ++;
				}
			}
			
			show_debug_message(_ds);
			
			for (var i = 0; i < ds_list_size(_ds); i ++)
			{
				with (_ds[| i])
				{
					_l[i] = editLayer;
					id_arr[i] = id;
					
					if (object_index == obj_waypoint)
					{
						other.wpID ++;
						other.wpNum = 0;
						other.wpType = 1;
						other.wpPlace = [];
						
						var in = 0;
						
						with (obj_waypoint)
						{
							if (wpID == other.wpID)
							{
								id_arr[in] = id;
								
								in ++;
							}
						}
					}
					
					if (object_index == obj_spikes)
					{
						if (ds_list_size(_ds) > 1)
						{
							id_arr[i] = id;
							
							if (i < ds_list_size(_ds) - 1)
							{
								continue;
							}
						}
					}
				}
				
				other.lchanged = true;
			}
			
			show_debug_message(id_arr);
			
			if (array_length(id_arr) > 0)
			{
				for (var i = 0; i < array_length(_l); i ++)
				{
					if (id_arr[@ i].editLayer != global.Layer)
					{
						array_delete(id_arr, 0, 1);
					}
				}
				
				global.hist[global.hNum] = ["Delete", id_arr];
			
				array_resize(global.hist, global.hNum + 1);
			
				for (var j = 0; j < array_length(id_arr); j ++)
				{
					instance_deactivate_object(id_arr[j]);
				}
				
				_h = true;
			}
			
			if (_h)
			{
				global.hNum ++;
			}
			
			ds_list_destroy(_ds);
		}
		
		if (mouse_check_button_released(mb_right))
		{
			global.go = true;
		}
	}
	
	if (mouse_check_button_released(mb_left))
	{
		global.go = true;
	}
	
	if (array_length(global.trgFrom) > 0 && array_length(global.trgTo) > 0)
	{
		for (var i = 0; i < array_length(global.trgFrom); i ++)
		{
			for (var j = 0; j < array_length(global.trgTo); j ++)
			{
				draw_set_color($FF0000);
			
				draw_line_width(global.trgFrom[0][i], global.trgFrom[1][i], global.trgTo[0][j], global.trgTo[1][j], 2);
			
				draw_set_color($FFFFFF);
			}
		}
	}
}

if (keyboard_check_pressed(vk_f2))
{
	toggle_editor();
}
