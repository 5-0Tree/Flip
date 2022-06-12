/// @description Resize Window

var baseW = display_get_width(),
	baseH = display_get_height(),
	ratio = baseW / baseH;

global.HEIGHT = floor(min(baseH, (global.fullscreen ? display_get_height() : window_get_height())));
global.WIDTH = floor(global.HEIGHT * ratio);
