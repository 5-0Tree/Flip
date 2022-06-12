/// @description Init

var baseW = display_get_width(),
	baseH = display_get_height(),
	ratio = baseW / baseH;

global.SCALE = 8;
global.ZOOM = 1;
global.HEIGHT = floor(baseH / global.SCALE);
global.WIDTH = floor(global.HEIGHT * ratio - 1);

surface_resize(application_surface, global.WIDTH * global.SCALE, global.HEIGHT * global.SCALE);

if (!instance_exists(obj_editor_control))
{
	global.edit = false;
}

depth = 100;

global.fullscreen = window_get_fullscreen();

showGrid = true;

global.surfGUI = surface_create(global.WIDTH, global.HEIGHT);

global.maxGridWidth = 100;
global.maxGridHeight = 100;

global.screenRotSpd = 5;
global.screenAngle = 0;
global.canRotate = false;
global.angleFix = 0;

global.gameOver = false;

if (room = rm_init)
{
	random_set_seed(irandom(1000000000));
	
	room_goto_next();
}
