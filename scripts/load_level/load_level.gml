/// @description save_level

function load_level(level_name)
{
	var d = working_directory + "levelData.dat",
		o = file_text_open_read(d),
		data = [];
	
	while (!file_text_eof(o))
	{
		var o_l = file_text_readln(o);
		
		if (o_l != "")
		{
			var json = json_parse(o_l);
			
			if (json.LevelName == level_name)
			{
				instance_destroy(obj_object_parent);
				
				for (var i = 0; i < json.OBJs; i ++)
				{
					var s = variable_struct_get(json, "GameObject" + string(i));
					
					with (instance_create_layer(s.X, s.Y, "Objects", s.Object))
					{
						image_angle = s.Angle;
						color[0] = s.Color;
						color[1] = s.ColorB;
						alpha = s.Alpha;
						group = s.Group;
						editLayer = s.Layer;
						movable = s.Movable;
						a_origin = s.AOrigin;
						x_origin = s.XOrigin;
						y_origin = s.YOrigin;
						wpID = s.WaypointID;
						wpNum = s.WaypointNum;
						wpType = s.WaypointType;
						moveSpeed = s.MoveSpeed;
						pl = s.PointList;
						locked = s.Locked;
						cond = s.Condition;
						trigger = s.Trigger;
						ID = s.ID;
					}
				}
				
				global.hist = [];
				global.hNum = 0;
				
				global.lname = level_name;
			}
		}
	}
	
	file_text_close(o);
}
