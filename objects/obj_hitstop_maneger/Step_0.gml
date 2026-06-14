desfaz_hitstop();

//debug
if (keyboard_check_pressed(vk_shift))
{
	//o efeito ativa
	global.hitstop = true;
	
	//por um segundo
	timer_hitstop = 60;
	
	trava_backgrounds(lista_backgrounds);
}

