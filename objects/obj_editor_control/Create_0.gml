/// @description Init

depth = -90;

global.edit = true;
global.editX = 0;
global.editY = 0;
global.Layer = 0;
global.maxLayer = 99;


_alpha = 0.5;
_color = [
	$FFFFFF,
	$000000
];

for (var i = 0; i < array_length(_color); i ++)
{
	red[i] = color_get_red(_color[i]);
	green[i] = color_get_green(_color[i]);
	blue[i] = color_get_blue(_color[i]);
	
	color_pm[i] = make_colour_rgb(red[i] * _alpha, green[i] * _alpha, blue[i] * _alpha);
}

saveAs = false;
save = false;
open = false;

angle = 0;

wpID = 0;
wpNum = 0;
wpType = 1;
wpPlace = [];

selObj = -1;
selCat = 0;

scroll = [];
levelScroll = 0;

global.go = true;

global.expanded = 1;

expandDir = -1;
expandPressed = false;

clickingButton = false;

altMenu = false;
colMenu = false;
conMenu = false;
trgMenu = false;

selectingCol = false;
colType = 0;

selCol = [
	$FFFFFF,
	$FFFFFF
];

colChg = false;

conTar = [noone];
trgTar = [noone];

selCon = "";
conChg = false;

global.trgFrom = [];
global.trgTo = [];

mainConds = [
	"Player Over",
	"Active Over",
	"Enemy Over",
	"Button Active"
];

selectX = 0;
selectY = 0;
selectXto = 0;
selectYto = 0;

global.hist = [];
global.hNum = 0;
global.copyObj = ds_grid_create(10, 0);

objs = {
	Blocks : [
		obj_wall_1,
		obj_wall_2,
		obj_wall_3,
		obj_wall_4
	], Active : [
		obj_box_1,
		obj_button,
		obj_waypoint,
		obj_wall_sp_mp_1,
		obj_wall_sp_anti
	], Enemy : [
		obj_wall_sp_c,
		obj_wall_sp_m,
		obj_enemy_c,
		obj_enemy_m,
		obj_spikes
	], Player : [
		obj_player,
		obj_goal
	]
};

altAttr = {
	Main : {
		Color : undefined,
		ColorB : undefined,
		Angle : undefined,
		Alpha : undefined,
		Group : undefined,
		Layer : undefined,
		Locked : undefined,
		Condition : undefined,
		Speed : undefined,
		Trigger : undefined
	}
};

objNames = [
	"Blocks",
	"Active",
	"Enemy",
	"Player"
];
for (var i = 0; i < array_length(objNames) + 1; i ++)
{
	scroll[i] = 0;
}

global.lname = "New Level";

lchanged = false;

instance_create_layer(0, 0, "Control", obj_camera);
