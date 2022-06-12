/// @description Draw GUI Surface

if (surface_exists(global.surfGUI))
{
	if (global.edit)
	{
	draw_surface_ext(global.surfGUI, x - global.WIDTH / 2 * global.ZOOM,
	 y - global.HEIGHT / 2 * global.ZOOM, global.ZOOM, global.ZOOM, 0, $FFFFFF, 1);
	}
}
