function alt_edit(obj, sCat, sVal, tla)
{
	var _v = [],
		_b = 0;
	
	with (obj)
	{
		if (selected)
		{
			var st = variable_struct_get(variable_struct_get(accAttr, sCat), sVal);
			
			if (st == undefined && tla)
			{
				return [-1];
				break;
			}
			
			else
			{
				_v[_b] = st;
				_b ++;
			}
		}
	}
	
	return _v;
}
