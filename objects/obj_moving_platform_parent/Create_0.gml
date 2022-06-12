/// @description Init

event_inherited();

depth = 10;

accConds = [
	"Player Over",
	"Active Over",
	"Enemy Over",
	"Button Active"
];

cond = accConds[0];
atEnd = false;

wp = noone;
wpPoint = 0;

init = false;

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
		Trigger : undefined
	}
};
