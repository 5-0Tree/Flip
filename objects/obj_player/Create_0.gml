/// @description Init

event_inherited();

depth = -10;

image_speed = 0;

canMove = true;
moveSpeed = 6;

a = 0;
defAng = image_angle;

s = false;

rot = -defAng;
rc = 1;

r = sqrt(sqr(sprite_width / 2) + sqr(sprite_height / 2));

xO = x;
yO = y;

accAttr.Main.Color = undefined;
