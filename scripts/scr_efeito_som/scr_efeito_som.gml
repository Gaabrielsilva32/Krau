//funcão efeito explosão
function efeito_som(_sfx = sfx_explosion, _variacao = .1)
{	
	//var pra variar o valor do pitch
	var _pitch = random_range(1 + _variacao, 1 - _variacao);
	
	audio_play_sound(_sfx, 0, 0, , , _pitch);
}
#endregion