if (instance_exists(obj_part_linha))
{
	//dando um brilho
	gpu_set_blendmode(bm_add);

	
	with (obj_part_linha)
	{
		//desenhand a sprite
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	
	//resetando
	gpu_set_blendmode(-1);
}