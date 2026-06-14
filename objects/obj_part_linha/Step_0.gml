if (global.hitstop) exit;

vida_atual--;


//valor
var _val = vida_atual / vida_max;

//fazendo ficar trasparente com o tempo
image_alpha = _val;

var _cor_nova = merge_colour(c_white, cor_original, _val);

//a sprite vai ter a cor original como padrão
image_blend = _cor_nova;

//diminuindo gradualmete em 4%
velh = _val * velh_original * _val;
velv = _val * velv_original * _val;

image_xscale = _val * escala_original;
image_yscale = image_xscale;



//ela some se está invisivel
if (vida_atual <= 0) instance_destroy();

x += velh;
y += velv;
