/// @description Draw Button

draw_self();

draw_sprite_ext(sprite_index, !active + 2, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, !active + 4, x, y, image_xscale, image_yscale, image_angle, $FFFFFF, image_alpha);
