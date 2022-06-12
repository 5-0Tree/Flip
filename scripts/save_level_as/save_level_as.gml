/// @description save_level

function save_level_as(level_name, save_as)
{
	var d = working_directory + "levelData.dat",
		o = file_text_open_read(d),
		num = 0,
		data = "",
		l_n = level_name,
		t_n = l_n,
		n = 1;
	
	while (!file_text_eof(o))
	{
		var o_s = file_text_readln(o);
		
		if (o_s != "")
		{
			var json = json_parse(o_s);
			
			num = json.LevelID + 1;
			
			if (json.LevelName == t_n)
			{
				t_n = level_name + " (" + string(n) + ")";
				
				l_n = t_n;
				n ++;
			}
		}
	}
	
	file_text_close(o);
	
	var ap = file_text_open_append(d),
		_n = 0;
	
	data = "{\"LevelID\" : " + string(num) + ", \"LevelName\" : " + "\"" + l_n + "\", ";
	
	with (obj_object_parent)
	{
		data += "\"GameObject" + string(_n) + "\" : {\"Object\" : " +
				string(object_index) +
				", \"Angle\" : " +
				string(image_angle) +
				", \"X\" : " +
				string(x) +
				", \"Y\" : " +
				string(y) +
				", \"Color\" : " +
				string(color[0]) +
				", \"ColorB\" : " +
				string(color[1]) +
				", \"Alpha\" : " +
				string(alpha) +
				", \"Group\" : " +
				string(group) +
				", \"Layer\" : " +
				string(editLayer) +
				", \"Movable\" : " +
				string(movable) +
				", \"AOrigin\" : " +
				string(a_origin) +
				", \"XOrigin\" : " +
				string(x_origin) +
				", \"YOrigin\" : " +
				string(y_origin) +
				", \"WaypointID\" : " +
				string(wpID) +
				", \"WaypointNum\" : " +
				string(wpNum) +
				", \"WaypointType\" : " +
				string(wpType) +
				", \"MoveSpeed\" : " +
				string(moveSpeed) +
				", \"PointList\" : " +
				string(pl) +
				", \"Locked\" : " +
				string(locked) +
				", \"Condition\" : \"" +
				string(cond) +
				"\", \"Trigger\" : " +
				string(trigger) +
				", \"ID\" : " +
				string(ID) +
				"}, ";
		_n ++;
	}
	
	data += "\"OBJs\" : " + string(_n) + "};\n";
	
	file_text_write_string(ap, data);
	
	file_text_close(ap);
}
