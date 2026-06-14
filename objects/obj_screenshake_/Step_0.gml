//se treme for diferente de 0
if (treme > 0.1)
{
	//uma var pra tornar o x da viewport aleatório
	var _x = random_range(-treme, treme);
	
	//uma var pra tornar o y da viewport aleatório
	var _y = random_range(-treme, treme);
	
	//alterando o x e y da viewport
	//view current é pra seleciolar a viewport que eu estou
	view_set_xport(view_current, _x)
	
	view_set_yport(view_current, _y)
	
}
else //cheguei perto de 0 eu reseto o treme e a posição da viewport
{
	treme = 0;
	
	view_set_xport(view_current, 0);
	
	view_set_yport(view_current, 0);
}

treme = lerp(treme, 0, 0.1)