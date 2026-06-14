function screenshake(_treme = 0)
{
	//verificando se o obj_screenshake existe
	if (instance_exists(obj_screenshake))
	{
		//com with eu rodo o código dentro do obj
		with (obj_screenshake)
		{
			if (_treme > treme)
			{
				treme = _treme;
			}
		}
	}
	
}