/// @description Init

event_inherited();

depth = 100;
image_speed = 0;

accConds = [
	"Player Over",
	"Active Over",
	"Enemy Over",
	undefined
];

active = false;

locked = false;
cond = accConds[0];
trigger = [noone];

accAttr = {
	Main : {
		Color : color[0],
		Angle : image_angle,
		Alpha : alpha,
		Group : group,
		Layer : editLayer,
		Locked : locked,
		Condition : cond,
		Speed : undefined,
		Trigger : trigger
	}
};
