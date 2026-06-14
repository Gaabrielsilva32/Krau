

//diminuindo a opacidade
image_alpha -= .1;


//se chegou no zero, ele some
if (image_alpha <= 0) instance_destroy();