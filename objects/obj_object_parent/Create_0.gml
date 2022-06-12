/// @description Init

ID = id;

editLayer = 0;
selected = false;

editables = [];

active = false;

hazard = false;

fall = false;
movable = true;
move = false;
canMove = false;
canFall = true;

a_origin = image_angle;
x_origin = x;
y_origin = y;

wpID = 0;
wpNum = 0;
wpType = 0;

moveSpeed = 4;

locked = false;

cond = "";

trigger = noone;

group = 0;

pl = [];

color[0] = image_blend;
color[1] = $FFFFFF;
alpha = image_alpha;
