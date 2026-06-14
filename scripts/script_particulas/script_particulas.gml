

function cria_particulas(_vida_min = 30, _vida_max = 60, _x = 0, _y = 0, _velh = 0, _velv = 0, _cor = c_white)
{
	//se o obj não existe, eu crio ele
	if (!instance_exists(obj_part_manager)) instance_create_depth(0, 0, 0, obj_part_manager);
	
	//a partir daqui o obj existe
	
	//com o obj da particula
	with (obj_part_manager)
	{
		//qnt de particulas
		var _qtd	= random_range(10, 20);
		var _vel	= abs(_velh) + abs(_velv);
		var _dir	= point_direction(0, 0, _velh, _velv)
		
	
		
		repeat(_qtd)
		{
			
			//varianda o x e o y
			var _x_positon_random = _x + random_range(-25, 25);
			var _y_position_random = _y + random_range(_velv, _velv * 4);
			
			//cria a instancia do obj
			var _part = instance_create_layer(_x_positon_random, _y_position_random, "particulas", obj_part_linha);
			
			
			var _vel_final = _vel + random_range(0, 2);
			
			with(_part){
			
				//dando uma variada na direção
				var _dir_part	= _dir + random_range(-30, 30);
				var _tam		= random_range(.2, .5);
			
				//descobrindo a velocidade necesaria para ir na direção correta
				velh_original	= lengthdir_x(_vel_final, _dir_part);
				velv_original	= lengthdir_y(_vel_final, _dir_part);
				escala_original = _tam;
				image_angle		= _dir_part;
				var _vida		= random_range(60, 120);
				vida_max		= _vida;
				vida_atual		= _vida;
				cor_original	= _cor;
			
				//escolhe a sprite da vez
				sprite_index	= choose(spr_part_linha, spr_part_trig);
			}
		}
	}
}