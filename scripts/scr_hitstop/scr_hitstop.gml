//var de controle do hitstop
global.hitstop = false;

//metodo pra chamar o hitstop
function chama_hitstop(_tempo)
{
	//o hitstop fica true
	global.hitstop = true;
	
	//var que diz se o obj existe na room
	var _exist = instance_exists(obj_hitstop_maneger);
	
	//verificando se o obj está na room
	//se o obj não existir
	//eu crio ele
	//uso o depth, pois ele não precisa de uma layer especifica
	if (!_exist) instance_create_depth(0, 0, 0, obj_hitstop_maneger);
	
	//dizendo que o tempo que o hitstop terá
	obj_hitstop_maneger.timer_hitstop = _tempo;
}


//função para detectar/checar o background
function pega_backgrounds()
{
	
	//array
	var _bgs = [];
	
	//var para pegar todas as layers
	//ele as armazena numa array
	var _layers = layer_get_all();
	
	//var para pegar a largura da minha array
	var _qtd = array_length(_layers);
	
	//laço for
	//enquanto i (o indice, que começa do 0)
	//for menor que _qtd (a quantidade de itens dentro da lista, 
	// que começa a contar do 1)
	for (var i = 0; i < _qtd; i++)
	{
		//pegando a layer atual
		var _atual = _layers[i];
		
		//pegando o id das camadas que tenham elemento de BACKGROUND	
		//Lembrando, que só as camadas de background podem ter elemento de background
		//as outras não podem ter.
		//o game maker lê todas as camadas, sem exceção
		//As que NÃO são de Background, ele retorna -1, porque é invalido.
		//As que SÃO de Background, ele retorna de 0 pra cima.
		//Ou seja, se uma camada for -1, ele não é de Background
		//Se for diferente de -1, ela é
		//Pra conseguir essa informação, uso a função abaixo
		var _id_bg = layer_background_get_id(_atual);
		
		//se for diferente de -1
		//ou seja, se for uma camada de Background
		if (_id_bg != -1)
		{
			//se a minha layer for de Bg*
			//salvando o nome da layer atual 
			var _nome = layer_get_name(_atual);
			
			//mandando o nome pra array de Bg
			//array push -> pega o array atual e adiciona um item
			array_push(_bgs, _nome)
		}
		
	}
	
	//a função return é usada para dar um retorno pra minha função
	//ela faz com que a minha função pare.
	//tudo que vem depois dela, não roda
	return _bgs;
}


//função para travar os bgs
function trava_backgrounds(_lista_backgrounds)
{
	
	//pegando o tamanho do array
	var _qtd = array_length(_lista_backgrounds);
	
	//usando o laço de repetição for para passar pelos bgs
	for (var i = 0; i < _qtd; i++)
	{
		
		
		//verificando a layer atual
		var _atual = _lista_backgrounds[i];
		
		
		//salvando a hspeed dos bgs numa variavel
		var _hspeed = layer_get_hspeed(_atual);
		
		//salvando a vspeed dos bgs numa varivel
		var _vspeed = layer_get_vspeed(_atual);
		
		//mandando as velocidades certa de cada bg
		//para a array bgs_hspeed
		array_push(other.bgs_hspeed, _hspeed);
		
		//mandando as velocidades certa de cada bg
		//para a array bgs_vspeed
		array_push(other.bgs_vspeed, _vspeed);
		
		//parando os bgs
		layer_hspeed(_atual, 0);
		
		//parando os bgs
		layer_vspeed(_atual, 0);
	}
	
	
	
}


function destrava_backgrounds(_lista_backgrounds, _bgs_hspeed, _bgs_vspeed)
{

	//pegando o tamanho do array
	var _qtd = array_length(_lista_backgrounds);
	
	
	for (var i = 0; i < _qtd; i++)
	{
		//verificando a layer atual
		var _atual	= _lista_backgrounds[i]
		
		var _hspeed	=  _bgs_hspeed[i];
		
		var _vspeed	= _bgs_vspeed[i];
		
		//definindo a hspeed do bg atual
		layer_hspeed(_atual, _hspeed);
		
		//definindo a vspeed do bg atual
		layer_vspeed(_atual, _vspeed);
		
	}
	
	
	
}
