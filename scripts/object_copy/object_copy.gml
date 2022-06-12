/// @description object_copy(obj)
/// @param obj
function object_copy(object)
{
	ds_grid_clear(global.copyObj, 0);
	ds_grid_resize(global.copyObj, 21, 1);
	
	var n = 0;
	
	repeat (instance_number(obj_object_parent))
	{
		n ++;
	}
	
	ds_grid_resize(global.copyObj, 21, n);
	
	for (var i = 0; i < n; i ++)
	{
		with (instance_find(object, i))
		{
			if (selected)
			{
				global.copyObj[# 0, i] = x;
				global.copyObj[# 1, i] = y;
				global.copyObj[# 2, i] = image_angle;
				global.copyObj[# 3, i] = color[0];
				global.copyObj[# 4, i] = color[1];
				global.copyObj[# 5, i] = alpha;
				global.copyObj[# 6, i] = group;
				global.copyObj[# 7, i] = editLayer;
				global.copyObj[# 8, i] = movable;
				global.copyObj[# 9, i] = a_origin;
				global.copyObj[# 10, i] = x_origin;
				global.copyObj[# 11, i] = y_origin;
				global.copyObj[# 12, i] = wpID;
				global.copyObj[# 13, i] = wpNum;
				global.copyObj[# 14, i] = wpType;
				global.copyObj[# 15, i] = moveSpeed;
				global.copyObj[# 16, i] = pl;
				global.copyObj[# 17, i] = locked;
				global.copyObj[# 18, i] = cond;
				global.copyObj[# 19, i] = trigger;
				global.copyObj[# 20, i] = ID;
			}
		}
	}
}
