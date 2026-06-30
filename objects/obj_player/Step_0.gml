//chamando o método de pegar inputs
pega_inputs();

//chama a checagem de se estou no chão
checa_chao();

//método de movimento
movimento();


perde_vida();

//finalizando o efeito mola
fim_ef_mola();

ajusta_escala();

//passando a var/função estado, que roda o meu estado atual
estado();

timer_vida--;

if (keyboard_check_pressed(ord("R"))) room_restart();

//show_debug_message(chao);

