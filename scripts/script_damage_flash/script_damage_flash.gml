

function ativa_flash(cor = c_white){

	//crio a instancia do obj_flash
	var _flash = instance_create_depth(0, 0, 1, obj_flash);

	//descobrindo qual o tamanho da room baseado na sprite
	var _image_xscale = room_width	/ _flash.sprite_width;
	var _image_yscale = room_height / _flash.sprite_height;

	//deixando ele do tamanho da tela
	_flash.image_xscale = _image_xscale + 1; //+1 pra garantir
	_flash.image_yscale = _image_yscale + 1; // idem
	_flash.image_blend = cor;
}