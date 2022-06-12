/// @description pow(x, n)

function pow(x, n)
{
	var val = x;
	
	if (n < 1)
	{
		val = 1;
	}
	
	else
	{
		var i = 0;
		
		repeat (n - 1)
		{
			i ++;
		}
		
		repeat (i)
		{
			val *= val;
		}
	}
	
	return val;
}
