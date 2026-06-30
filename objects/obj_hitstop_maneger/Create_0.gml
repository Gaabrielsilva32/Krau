//timer do hitstop
//define quanto tempo o efeito durará
timer_hitstop = 0;


//detectando os backgrounds
lista_backgrounds = pega_backgrounds();

//pegando a velh dos bgs
bgs_hspeed = [];

//pegando a velv dos bgs
bgs_vspeed = [];


//metodo para parar o efeito
function desfaz_hitstop()
{
	//se o efeito não esta ativo, não faço nada
	if (!global.hitstop) return;
	
	//if o efeito esta ativo
	if (global.hitstop)
	{
		//diminuo o timer gradualmente
		timer_hitstop--;
		
		//fazendo as animações pararem
		with(all)
		{
			image_speed = 0;
            
            velh = 0;
            velv = 0;
		}
		
		trava_backgrounds(lista_backgrounds);
		
		
		//se o timer chegar a zero
		if (timer_hitstop <= 0)
		{
			//desativo o efeito
			global.hitstop = false;
			
			//a vel dos bgs voltam
			destrava_backgrounds(lista_backgrounds, bgs_hspeed, bgs_vspeed);
			
			//fazendo as animações voltarem
			with(all)
			{
				image_speed = 1;
			}
		}
	}
}