//inicia o efeito mola
function inicio_ef_mola()
{
	//minha escala
	xscale = 1;
	yscale = 1;
}

function ef_mola(_xscale = 1, _yscale = 1)
{
	xscale = _xscale
	yscale = _yscale
}

function fim_ef_mola(_qt = 0.1)
{
	///voltando a escala normal
	xscale = lerp(xscale, 1, 0.1);
	yscale = lerp(yscale, 1, 0.1);
}

function desenhando_ef_mola()
{
	//me desenhando
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}



//colocar no draw
//if (mostrar) desenha_efeito_branco(desenhando_ef_mola);