/// @description Panning

if (dragStart)
{
	x = floor((dragX - event_data[? "rawposX"]) * (global.ZOOM / global.SCALE));
	y = floor((dragY - event_data[? "rawposY"]) * (global.ZOOM / global.SCALE));
	
	x = clamp(x, 0, global.maxGridWidth * 16);
	y = clamp(y, 0, global.maxGridHeight * 16);
	
	var CANG = dcos(global.screenAngle),
		SANG = dsin(global.screenAngle),
		vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0);
	
	camera_set_view_mat(cam, vm);
}
