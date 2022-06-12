/// @description Draw Editor Grid

if (global.edit)
{
	if (showGrid)
	{
		var maxi = global.maxGridWidth * 16,
			maxj = global.maxGridHeight * 16;
		
		draw_set_color($000000);
		draw_set_alpha(0.4);
		
		for (var i = 0; i < maxi + 16; i += 16)
		{
			draw_line_width(i - 1, -2, i - 1, maxj, 2);
		}
		
		for (var j = 0; j < maxj + 16; j += 16)
		{
			draw_line_width(-2, j - 1, maxi, j - 1, 2);
		}
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
	}
}