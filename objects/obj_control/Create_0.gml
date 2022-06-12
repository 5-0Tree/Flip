/// @description Start Up Game

var fname = working_directory + "levelData.dat";

if (!file_exists(fname))
{
	file_text_open_write(fname);
	file_text_close(fname);
}

global.devMode = false;
