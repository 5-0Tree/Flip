/// @description Draw Editor GUI

var _x = 0,
	_y = 0,
	_x2 = global.WIDTH,
	_y2 = global.HEIGHT,
	cenx = global.WIDTH / 2,
	ceny = global.HEIGHT / 2,
	mx = window_mouse_get_x() / global.SCALE,
	my = window_mouse_get_y() / global.SCALE,
	_sel = selObj;

gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);

surface_set_target(global.surfGUI);
draw_clear_alpha($000000, 0.0);
	
if (global.edit && surface_exists(global.surfGUI))
{
	if (mx < _x + 56 && my > _y + 16)
	{
		scroll[selCat] += (mouse_wheel_up() - mouse_wheel_down()) * 4;
	}
	
	scroll[selCat] = clamp(scroll[selCat], -max(0, ceil(array_length(variable_struct_get(objs, objNames[selCat])) / 2 + 1) * 24 - global.HEIGHT), 0);
	
	if (point_in_rectangle(mx, my, _x + 54 * global.expanded, ceny - 4, _x + 54 * global.expanded + 6, ceny + 4) && !altMenu && !open && !saveAs)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			expandPressed = true;
			
			clickingButton = true;
		}
		
		if (mouse_check_button_released(mb_left))
		{
			if (expandPressed)
			{
				global.expanded = !global.expanded;
			}
		}
	}
	
	else
	{
		expandPressed = false;
	}
	
	if (!mouse_check_button(mb_left))
	{
		expandPressed = false;
		
		clickingButton = false;
	}
	
	if (!mouse_check_button(mb_left))
	{
		selectX = mx + 1;
		selectY = my + 1;
	}
	
	if (global.expanded)
	{
		expandDir = -1;
	}
	
	else
	{
		expandDir = 1;
	}
	
	var o = 0,
		yy = 32 + scroll[selCat];
	
	if (global.expanded)
	{
		draw_set_color(color_pm[0]);
		draw_set_alpha(_alpha);
		
		draw_rectangle(_x, _y, _x + 56, _y + global.HEIGHT, false);
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x, _y, _x + 57, _y + global.HEIGHT, true);
		draw_rectangle(_x, _y, _x + 56, _y + global.HEIGHT, true);
		draw_rectangle(_x, _y, _x + 55, _y + global.HEIGHT, true);
		
		for (var xx = 16; xx < 56; xx += 24)
		{
			var _so = false;
			
			if (o < array_length(variable_struct_get(objs, objNames[selCat])))
			{
				if (point_in_rectangle(mx, my, _x + xx - 8, _y + yy - 8, _x + xx + 8, _y + yy + 8) && !altMenu && !open && !saveAs)
				{
					draw_set_color($FFDEAA);
					draw_set_alpha(0.8);
					
					if (mouse_check_button_pressed(mb_left) && !altMenu && !open && !saveAs)
					{
						if (selObj != variable_struct_get(objs, objNames[selCat])[o])
						{
							selObj = variable_struct_get(objs, objNames[selCat])[o];
						}
						
						else
						{
							selObj = -1;
						}
					}
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, true);
					
					draw_set_color($FFFFFF);
					draw_set_alpha(1.0);
				}
				
				if (selObj == variable_struct_get(objs, objNames[selCat])[o])
				{
					_so = true;
				}
				
				if (_so)
				{
					draw_set_color($FFDEAA);
					draw_set_alpha(0.6);
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, false);
					
					draw_set_alpha(0.8);
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, true);
					
					draw_set_color($FFFFFF);
					draw_set_alpha(1.0);
				}
				
				var spr = object_get_sprite(variable_struct_get(objs, objNames[selCat])[o]);
				
				if (sprite_get_number(spr) > 0 && asset_has_tags(spr, "Block", asset_sprite))
				{
					draw_sprite(spr, 1, _x + xx, _y + yy);
				}
				
				draw_sprite(spr, 0, _x + xx, _y + yy);
				
				if (xx >= 32)
				{
					xx = -8;
					yy += 24;
				}
				
				o ++;
			}
		}
	}
	
	draw_rectangle(_x + 54 * global.expanded, _y + global.HEIGHT / 2 - 5, _x + 54 * global.expanded + 6, _y + global.HEIGHT / 2 + 4, false);
	draw_sprite_ext(spr_arrow, expandPressed, _x + global.expanded * 53 + 4, _y + global.HEIGHT / 2, expandDir, 1, 0, $FFFFFF, 1);
	
	if (!altMenu && !open && !saveAs)
	{
		if (keyboard_check_pressed(ord("V")))
		{
			selObj = -1;
		}
	}
	
	if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_f2) || _sel != selObj || mouse_check_button_pressed(mb_right))
	{
		with (obj_waypoint)
		{
			if (wpID == obj_editor_control.wpID)
			{
				if (wpNum == obj_editor_control.wpNum - 1)
				{
					wpType = 2;
					
					obj_editor_control.wpID ++;
					obj_editor_control.wpNum = 0;
					obj_editor_control.wpType = 1;
					
					if (array_length(obj_editor_control.wpPlace) > 0)
					{
						global.hist[global.hNum][0] = "Add";
						global.hist[global.hNum][1] = obj_editor_control.wpPlace;
					}
					
					global.hNum ++;
					
					obj_editor_control.wpPlace = [];
				}
			}
		}
	}
	
	if (global.expanded)
	{
		draw_set_font(font_main);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var hover_l = false,
			hover_r = false;
		
		draw_rectangle(_x, _y, _x + 55, _y + 16, false);
		
		draw_set_color($282828);
		
		draw_text(_x + 28, _y + 9, objNames[selCat]);
		
		draw_set_color($FFFFFF);
		
		//Left button
		if (selCat > 0)
		{
			if (point_in_rectangle(mx, my, _x + 4, _y + 4, _x + 10, _y + 12))
			{
				if (!altMenu && !open && !saveAs)
				{
					if (mouse_check_button_pressed(mb_left))
					{
						selCat --;
					}
					
					hover_l = true;
				}
			}
			
			else
			{
				hover_l = false;
			}
			
			draw_sprite_ext(spr_arrow, hover_l, _x + 6, _y + 8, -1, 1, 0, $FFFFFF, 1);
		}
		
		//Right button
		if (selCat < array_length(objNames) - 1)
		{
			if (point_in_rectangle(mx, my, _x + 47, _y + 4, _x + 53, _y + 12))
			{
				if (!altMenu && !open && !saveAs)
				{
					if (mouse_check_button_pressed(mb_left) && !altMenu && !open && !saveAs)
					{
						selCat ++;
					}
					
					hover_r = true;
				}
			}
			
			else
			{
				hover_r = false;
			}
			
			draw_sprite_ext(spr_arrow, hover_r, _x + 50, _y + 8, 1, 1, 0, $FFFFFF, 1);
		}
	}
	
	draw_set_font(font_main);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	
	var hover_l = false,
		hover_r = false,
		_txt = string(global.Layer),
		_w = string_width(string(global.Layer));
	
	if (global.Layer < 0)
	{
		_txt = "All";
	}
	
	draw_rectangle(_x2, _y2, _x2 - 39, _y2 - 15, true);
	draw_rectangle(_x2, _y2, _x2 - 40, _y2 - 16, true);
	draw_rectangle(_x2, _y2, _x2 - 41, _y2 - 17, true);
	
	draw_set_color(color_pm[0]);
	draw_set_alpha(_alpha);
	
	draw_rectangle(_x2, _y2, _x2 - 40, _y2 - 16, false);
	
	draw_set_color($000000);
	
	draw_text(_x2 - 9, _y2 - 5, _txt);
	
	draw_set_color($FFFFFF);
	draw_set_alpha(1.0);
	
	draw_text(_x2 - 10, _y2 - 6, _txt);
	
	//Left button
	if (global.Layer >= 0)
	{
		if (point_in_rectangle(mx, my, _x2 - _w - 17, _y2 - 10, _x2 - _w - 11, _y2 - 2))
		{
			if (!altMenu && !open && !saveAs)
			{
				if (mouse_check_button_pressed(mb_left))
				{
					global.Layer --;
				}
				
				hover_l = true;
			}
		}
		
		else
		{
			hover_l = false;
		}
		
		if (keyboard_check_pressed(vk_left))
		{
			global.Layer --;
		}
		
		draw_sprite_ext(spr_arrow, hover_l, _x2 - _w - 15, _y2 - 6, -1, 1, 0, $FFFFFF, 1);
	}
	
	//Right button
	if (global.Layer < global.maxLayer)
	{
		if (point_in_rectangle(mx, my, _x2 - 9, _y2 - 10, _x2 - 3, _y2 - 2))
		{
			if (!altMenu && !open && !saveAs)
			{
				if (mouse_check_button_pressed(mb_left))
				{
					global.Layer ++;
				}
				
				hover_r = true;
			}
		}
		
		else
		{
			hover_r = false;
		}
		
		if (keyboard_check_pressed(vk_right))
		{
			global.Layer ++;
		}
		
		draw_sprite_ext(spr_arrow, hover_r, _x2 - 6, _y2 - 6, 1, 1, 0, $FFFFFF, 1);
	}
	
	with (obj_object_parent)
	{
		if (global.Layer > -1)
		{
			if (editLayer == global.Layer)
			{
				image_alpha = 1;
			}
			
			else
			{
				image_alpha = 0.5;
			}
		}
		
		else
		{
			image_alpha = 1;
		}
	}
	
	if (altMenu)
	{
		if (!trgMenu)
		{
			draw_set_color($000000);
			draw_set_alpha(0.4);
			
			draw_rectangle(_x, _y, _x2, _y2, false);
			
			draw_set_color($FFFFFF);
			draw_set_alpha(1.0);
			
			draw_rectangle(_x + 32, _y, _x2 - 32, _y2, false);
		}
		
		var col = true,
			clb = true,
			ang = true,
			alp = true,
			grp = true,
			lay = true,
			loc = true,
			con = true,
			spe = true,
			trg = true,
			aar = [col, clb, ang, alp, grp, lay, loc, con, spe, trg],
			bar = ["Color", "ColorB", "Angle", "Alpha", "Group", "Layer", "Locked", "Condition", "Speed", "Trigger"];
		
		for (var i = 0; i < array_length(aar); i ++)
		{
			aar[i] = alt_edit(obj_object_parent, "Main", bar[i], aar[i]);
		}
		
		//Work on alt menu...
		
		var __n = 0;
		
		for (var i = 0; i < array_length(aar); i ++)
		{
			draw_set_color($000000);
			
			var g = false,
				is_a = (bar[i] == "Color" ? 1 : 0),
				is_b = (bar[i] == "ColorB" ? 1 : 0),
				has_b = (aar[1][0] != -1 ? 1 : 0);
			
			if (array_length(aar[i]) > 0)
			{
				g = true;
			}
			
			if (g && aar[i][0] != -1 && !trgMenu)
			{
				var _v = undefined,
					_t = undefined;
					
				
				draw_set_halign(fa_left);
				
				if (has_b)
				{
					if (!is_b)
					{
						draw_text(_x + 48, _y + 12 + (i - !is_b + is_a - __n) * 16, bar[i]);
					}
				}
				
				else
				{
					draw_text(_x + 48, _y + 12 + (i - __n) * 16, bar[i]);
				}
				
				draw_set_halign(fa_right);
				
				if (array_length(aar[i]) > 0)
				{
					for (var j = 0; j < array_length(aar[i]); j ++)
					{
						if (j > 0)
						{
							if (_v != aar[i][j])
							{
								_t = "Mixed";
								
								break;
							}
						}
						
						_v = aar[i][j];
					}
					
					if (_t != "Mixed")
					{
						_t = _v;
					}
				}
				
				else
				{
					_t = aar[i][0];
				}
				
				if (bar[i] == "Color" || bar[i] == "ColorB")
				{
					if (_t == "Mixed")
					{
						draw_text(_x2 - 51 - is_b * 20, _y + 13 + (i - is_b - __n) * 16, "?");
					}
					
					else
					{
						if (colChg)
						{
							if (bar[i] == "Color") {
								_t = selCol[0];
							}
							
							else if (bar[i] == "ColorB")
							{
								_t = selCol[1];
							}
						}
						
						draw_set_color(_t);
						
						draw_rectangle(_x2 - 63 - is_b * 20, _y + 5 + (i - is_b - __n) * 16, _x2 - 49 - is_b * 20, _y + 19 + (i - is_b - __n) * 16, false);
					}
					
					if (point_in_rectangle(mx, my, _x2 - 64 - is_b * 20, _y + 4 + (i - is_b - __n) * 16, _x2 - 46.5 - is_b * 20, _y + 20.5 + (i - is_b - __n) * 16) && !colMenu)
					{
						if (mouse_check_button_pressed(mb_left))
						{
							if (bar[i] == "Color")
							{
								colType = 0;
							}
							
							else if (bar[i] == "ColorB")
							{
								colType = 1;
							}
							
							colMenu = true;
						}
						
						draw_set_color($FFDEAA);
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					draw_rectangle(_x2 - 63 - is_b * 20, _y + 5 + (i - is_b - __n) * 16, _x2 - 49 - is_b * 20, _y + 19 + (i - is_b - __n) * 16, true);
					
					draw_set_color($FFFFFF);
				}
				
				else if (bar[i] == "Condition")
				{
					var tstr = _t;
					
					if (conChg)
					{
						tstr = selCon;
					}
					
					if (point_in_rectangle(mx, my, _x2 - 50 - string_width(tstr), _y + 8 + (i - __n) * 16, _x2 - 48, _y + 14 + (i - __n) * 16) && !conMenu)
					{
						draw_set_color($FFDEAA);
						
						if (mouse_check_button_pressed(mb_left))
						{
							var iv = 0;
							
							with (obj_object_parent)
							{
								if (selected)
								{
									other.conTar[iv] = id;
									
									iv ++;
								}
							}
							
							conMenu = true;
						}
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					if (!has_b)
					{
						draw_text(_x2 - 48, _y + 12 + (i - __n) * 16, tstr);
					}
				}
				
				else if (bar[i] == "Trigger")
				{
					draw_sprite(spr_target, 0, _x2 - 56, _y + 12 + (i - __n) * 16);
					
					if (point_in_rectangle(mx, my, _x2 - 64, _y + 4 + (i - __n) * 16, _x2 - 48, _y + 20 + (i - __n) * 16) && !trgMenu)
					{
						draw_set_color($FFDEAA);
						
						if (mouse_check_button_pressed(mb_left))
						{
							var iv = 0;
							
							with (obj_object_parent)
							{
								if (selected)
								{
									other.trgTar[iv] = ID;
									
									iv ++;
								}
							}
							
							trgMenu = true;
						}
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					draw_rectangle(_x2 - 63, _y + 5 + (i - __n) * 16, _x2 - 49, _y + 19 + (i - __n) * 16, true);
					
				}
				
				else
				{
					if (bar[i] == "Locked")
					{
						if (_t)
						{
							_t = "True";
						}
						
						else
						{
							_t = "False";
						}
					}
					
					draw_text(_x2 - 48, _y + 12 + (i - has_b - __n) * 16, _t);
				}
			}
			
			else
			{
				__n ++;
			}
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape) && !colMenu && !conMenu)
		{
			with (obj_object_parent)
			{
				if (selected)
				{
					if (other.conChg)
					{
						cond = other.selCon;
					}
				}
			}
			
			selectingCol = false;
			
			selCol = [
				$FFFFFF,
				$FFFFFF
			];
			
			colChg = false;
			
			selCon = "";
			conChg = false;
			
			altMenu = false;
		}
	}
	
	//Menus
	
	if (colMenu)
	{
		draw_set_color($000000);
		draw_set_alpha(0.4);
		
		draw_rectangle(_x, _y, _x2, _y2, false);
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x + 32, _y + 16, _x2 - 32, _y2 - 16, false);
		
		draw_circle(cenx, ceny, 8, false);
		
		if (point_in_circle(mx, my, cenx + 1.5, ceny + 1, 9))
		{
			draw_set_color($FFDEAA);
			
			if (mouse_check_button_pressed(mb_left))
			{
				selCol[colType] = $FFFFFF;
				
				with (obj_object_parent)
				{
					if (selected)
					{
						color[other.colType] = $FFFFFF;
					}
				}
				
				colChg = true;
				
				colMenu = false;
			}
		}
		
		else
		{
			draw_set_color($000000);
		}
		
		draw_circle(cenx, ceny, 8, true);
		
		for (var i = 1; i < 256; i += 17)
		{
			var cx = floor(cenx + lengthdir_x(32, (i - 1) / 255 * 360 + 180)),
				cy = floor(ceny + lengthdir_y(32, (i - 1) / 255 * 360 + 180)),
				ccol = make_color_hsv(i - 1, 255, 255);
			
			draw_circle_color(cx, cy, 5, ccol, ccol, false);
			
			if (point_in_circle(mx, my, cx + 1.5, cy + 1, 5))
			{
				draw_set_color($FFDEAA);
				
				if (mouse_check_button_pressed(mb_left))
				{
					selCol[colType] = ccol;
					
					with (obj_object_parent)
					{
						if (selected)
						{
							color[other.colType] = ccol;
						}
					}
					
					colChg = true;
					
					colMenu = false;
				}
			}
			
			else
			{
				draw_set_color($000000);
			}
			
			draw_circle(cx, cy, 5, true);
		}
		
		if (keyboard_check_pressed(vk_escape))
		{
			colMenu = false;
		}
		
	}
	
	if (conMenu)
	{
		draw_set_color($000000);
		draw_set_alpha(0.4);
		
		draw_rectangle(_x, _y, _x2, _y2, false);
		
		var conds = mainConds,
			tcond = [];
		
		for (var i = 0; i < array_length(conTar); i ++)
		{
			with (conTar[i])
			{
				tcond[i] = accConds;
			}
		}
		
		for (var i = 0; i < array_length(tcond); i ++)
		{
			for (var j = 0; j < array_length(tcond[i]); j ++)
			{
				if (tcond[i][j] == undefined)
				{
					conds[j] = undefined;
				}
			}
		}
		
		for (var i = 0; i < array_length(conds); i ++)
		{
			if (conds[i] == undefined)
			{
				array_delete(conds, i, 1);
			}
		}
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x + 48, ceny - array_length(conds) * 8, _x2 - 48, ceny + array_length(conds) * 8, false);
		
		draw_set_halign(fa_center);
		
		for (var i = 0; i < array_length(conds); i ++)
		{
			if (point_in_rectangle(mx, my,
				cenx - 1 - string_width(conds[i]) / 2, ceny + 4 - array_length(conds) * 8 + i * 16,
				cenx + string_width(conds[i]) / 2, ceny + 12 - array_length(conds) * 8 + i * 16))
			{
				draw_set_color($FFDEAA);
				
				if (mouse_check_button_pressed(mb_left))
				{
					selCon = conds[i];
					conChg = true;
					
					conMenu = false;
				}
			}
			
			else
			{
				draw_set_color($000000);
			}
			
			draw_text(cenx, ceny + 9 - array_length(conds) * 8 + i * 16, conds[i]);
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape))
		{
			conMenu = false;
		}
	}
	
	if (trgMenu)
	{
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_circle(_x2 - 8, _y + 8, 8, false);
		
		var hover = false;
		
		if (point_in_circle(mx, my, _x2 - 8, _y + 8, 8))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				trgMenu = false;
			}
			
			hover = true;
		}
		
		else
		{
			if (mouse_check_button_pressed(mb_left))
			{
				var _c = ds_list_create();
				
				collision_point_list(mouse_x, mouse_y, obj_object_parent, false, true, _c, true);
				
				if (ds_list_size(_c) > 0)
				{
					for (var i = 0; i < ds_list_size(_c); i ++)
					{
						with (_c[| i])
						{
							if (accAttr.Main.Condition == "Button Active" && !selected)
							{
								global.trgFrom[0][i] = x;
								global.trgFrom[1][i] = y;
								
								for (var j = 0; j < array_length(other.trgTar); j ++)
								{
									with (other.trgTar[j])
									{
										trigger = [other.id];
										
										global.trgTo[0][j] = x;
										global.trgTo[1][j] = y;
									}
								}
								
								other.trgMenu = false;
							}
						}
					}
				}
			}
			
			hover = false;
		}
		
		draw_sprite_ext(spr_arrow, hover, _x2 - 8, _y + 8, -1, 1, 0, $FFFFFF, 1);
		
		if (keyboard_check_pressed(vk_escape))
		{
			trgMenu = false;
		}
	}
	
	if (!altMenu && !saveAs && !save)
	{
		if (open)
		{
			draw_set_color($000000);
			draw_set_alpha(0.4);
			
			draw_rectangle(_x, _y, _x2, _y2, false);
			
			draw_set_color($FFFFFF);
			draw_set_alpha(1.0);
			
			draw_rectangle(_x + 32, _y, _x2 - 32, _y2, false);
			
			draw_set_halign(fa_center);
			
			draw_set_color($000000);
			
			draw_text(cenx, _y + 8, "Open Level");
			
			draw_set_color($FFFFFF);
			
			var d = working_directory + "levelData.dat",
				o = file_text_open_read(d),
				tempData = [""],
				nameData = [""],
				_nn = 0;
			
			while (!file_text_eof(o))
			{
				tempData = file_text_readln(o);
				
				if (tempData != "")
				{
					var json = json_parse(tempData);
					
					nameData[_nn] = json.LevelName;
					_nn ++;
				}
			}
			
			file_text_close(o);
			
			draw_set_halign(fa_left);
			
			levelScroll += (mouse_wheel_up() - mouse_wheel_down()) * 4;
			levelScroll = clamp(levelScroll, -max(0, ceil(array_length(nameData)) * 16), 0);
			
			for (var i = 0; i < array_length(nameData); i ++)
			{
				if (point_in_rectangle(mx, my, _x + 39, _y + 16 + levelScroll + i * 16, _x + 39 + string_width(nameData[i]), _y + 24 + levelScroll + i * 16) && my > _y + 16)
				{
					draw_set_color($FFDEAA);
					
					if (mouse_check_button_pressed(mb_left))
					{
						global.go = false;
						
						load_level(nameData[i]);
						
						levelScroll = 0;
						
						open = false;
					}
				}
				
				else
				{
					draw_set_color($000000);
				}
				
				draw_text(_x + 40, _y + 22 + levelScroll + i * 16, nameData[i]);
			}
			
			if (keyboard_check_pressed(vk_escape))
			{
				levelScroll = 0;
				
				open = false;
			}
		}
	}
	
	if (!altMenu && (saveAs || save))
	{
		draw_set_color(color_pm[1]);
		draw_set_alpha(_alpha);
		
		draw_rectangle(_x, _y, _x2, _y2, false);
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x + 32, _y + 32, _x2 - 32, _y2 - 32, false);
		
		draw_set_halign(fa_center);
		
		draw_set_color($000000);
		
		draw_text(cenx, _y + 48, "Save Level As");
		
		draw_set_color($E8E8E8);
		
		draw_rectangle(_x + 46, _y + 59, _x2 - 46, _y2 - 68, false);
		
		draw_set_halign(fa_left);
		
		draw_set_color($000000);
		
		if (string_length(keyboard_string) > 20)
		{
			string_delete(keyboard_string, string_length(keyboard_string), string_length(keyboard_string) - 20);
		}
		
		if (keyboard_string == "")
		{
			draw_text(_x + 48, _y + 64, global.lname);
		}
		
		else
		{
			draw_text(_x + 48, _y + 64, keyboard_string);
			
			draw_set_color($7F7F7F);
			
			draw_text(_x + 50 + string_width(keyboard_string), _y + 64, "|");
			
			draw_set_color($FFFFFF);
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape))
		{
			keyboard_string = "";
			
			saveAs = false;
			save = false;
		}
		
		if (keyboard_check_pressed(vk_enter))
		{
			global.lname = keyboard_string;
			
			save_level_as(global.lname);
			
			keyboard_string = "";
			
			saveAs = false;
			save = false;
		}
	}
}

gpu_set_blendmode(bm_normal);

surface_reset_target();
