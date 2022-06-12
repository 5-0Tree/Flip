/// @description Draw Sprite Layers

if (image_number > 0 && asset_has_tags(sprite_index, "Block", asset_sprite))
{
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, image_blend2, image_alpha);
}

draw_self();
