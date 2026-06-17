
#region Variáveis

//velocidade 
//horizontal e vertical do player
velh     = 0;
max_velh = 1;
velv     = 0;
max_velv = 3.01;
vel      = 2;

// Variáveis de tempo para a patrulha
tempo_espera = 1 * game_get_speed(gamespeed_fps); 
timer_espera = 0;


//gavidade do player
grav = 0.25;

//vars do jogo
//verfica se estou no chão
chao = false;

//verifica se toquei em uma parede
parede = false;

//var que dita a minha direção
dir             = 1;


//var pra guardar a colisão do tileset do chão
var _layer      = layer_tilemap_get_id("tl_chao");

//variavel que quarda as colisões que eu tenho no jogo
colisoes        = [_layer];

//iniciando o efeito mola
inicio_ef_mola();

#endregion



#region Métodos

//metodo pra ajustar escala do player
ajusta_escala = function(){
    
    //se a minha velh for diferente de 0
    //a minha dir vai ser alterada de acordo com a minha velh
    //se ela for positiva, a função sing retorna 1
    //se for negativa -1
    //e como eu disse pra isso só funcionar se a velh for diferente de 0
    //não tenho o problema dele sumir pela img xscale ser 0
    //fiz desse jeito, porque garanto que ele não vai se mexer 
    //quando tiver saindo da tinta, por ex.
    if (velh != 0) dir = sign(velh);
    
    
}



//criando um método para checar se estou no chão
checa_chao = function()
{   
    
    chao = place_meeting(x, y + 1, colisoes);
    
}

checa_parede = function()
{
    
    parede = place_meeting(x + dir, y, colisoes);
    
}

//método para aplicar a velocidade à variaveis 
aplica_velocidade_player = function()
{
    
    //checo se estou no chão
    checa_chao();
    
    checa_parede();
    
    //se não estou no chão
    if (!chao) 
    { 
        //a velv recebe o valor da gravidade
        velv += grav;
    }
    
    //se não, se estou no chão
    else 
    {
        velv = 0; //zero a velv
        
        //aredondando o y
        y = round(y)
        
        //limitando o meu velv
        velv = clamp(velv, -max_velv, max_velv);
        
    }
    
}

//método de movimento
//o anterior apenas atribui um valor às variaveis
//esse aplica o movimento
movimento = function(){
    
    //adiciona essa velocidade ao x
    //faz com que se movimente
    //e colida com os obj
    //4 é o valor padrão da precisão da colisão
    move_and_collide(0, velv, colisoes, 4);
    
    //aplicando à velv
    move_and_collide(velh, velv, colisoes, 24);
}



//método de trocar sprite
troca_sprite = function(_sprite_atual = sprite_index){
    
    //se a sprite que eu tô usando no momento (sprite index)
    //for diferente da que eu quero colocar (_sprite_atual)
    //eu atualizo a minha sprite e zero o imagem index
    //assim eu faço a animação sempre começar do inicio
    // já que esse código roda só uma vez, antes da troca de sprites
    if (sprite_index != _sprite_atual)
    {
        
        sprite_index = _sprite_atual;
        
        image_index = 0;
        
    }
    
}

//método para ver se a animação acabou
acabou_animacao = function(){
    
    //ela pega a velocidade (fps) do meu sprite atual
    //que é 10
    //e divide pelo fps do jogo
    //que é 60
    var _spd = sprite_get_speed(sprite_index) / FPS;
    
    if (image_index + _spd >= image_number)
    {
       
        //a função retorna true 
       return true;
    }    
    
    
    
}



//metodos de estado
//metodo do estado parado
estado_parado = function(){
    
    //zerando as vars de mov pra garantir que o estado incie com elas zeradas
    //se estou parado, não tenho velocidade vertical
    velh = 0;
    velv = 0;
    
    //vou pra spr idle
    troca_sprite(spr_player_idle);
    
    //aplico a velocidade
    //nesse estado eu não vou me mover
    //só aplico pra conseguir pular
    aplica_velocidade_player();
    
    //definindo a sprite player
    //troca_sprite(spr_player_idle);
    //se estou apertando pra dirteita ou esquerda
    //diferente de, porque não posso apertar os 2 ao mesmo tempo
    //se são diferentes, estou me movendo
   // if (right != left)
   // {
        //mudo o estado para movendo
   //     estado = estado_movendo;
        
  //  }
    
    
    
    //se eu não estou no chão, vou para o estado de pulando
    if (!chao)
    {
        estado = estado_pulando;
        
    }
}

//método do estado movendo
estado_movendo = function(){
    
    //aplico velocidade
    velh = vel * dir;
     
    //passando o aplica velocidade
    //para pegar a velocidade certa
    aplica_velocidade_player();
    
    //denifinindo a sprite
    troca_sprite(spr_player_walk);
    
    
    // SE TOCOU NA PAREDE:
    if (parede)
    {
        //velh = 0;                        // Para o movimento horizontal
        timer_espera = tempo_espera;     // Inicia o cronômetro com 2 segundos
        estado = estado_esperando;       // Muda para o estado de espera
    }
    
    
    //se a minha velh é zero
    //ou seja, se estou parado
    if (velh == 0)
    {
        //vou para o estado parado
        estado = estado_parado;
        
    }
    
    //se o velv é diferente de 0
    //então eu não to no chão
    //ent, eu vou pro estado de pulando
    if (velv != 0) estado = estado_pulando;
}


//método do estado pulando
estado_pulando = function(){
    
    //aplico velocidade
    velh = vel * dir;
    
    //passando o aplica velocidade
    //para pegar a velocidade certa
    aplica_velocidade_player();
    
    //se estou indo pra cima
    //a minha velv é negativa
    if (velv < 0)
    {
        //troco o sprite
        troca_sprite(spr_player_jump_up);
        
        //se o obj_parede_one_way EXISTE na mnha array
        if (array_contains(colisoes, obj_parede_one_way))
        {
            
           //remolve o ultimo item da array -> array_pop(colisoes);
            
            //var para descobrir a posição do obj com base no index dele
            var _idx = array_get_index(colisoes, obj_parede_one_way);
            
            //remolvendo a parede one way da lista de colisoes
            //porque subindo e não descendo
            array_delete(colisoes, _idx, 1);
            
            
        }
        
    }
    else //se estou caindo, a minha velv é positiva 
    {
    	troca_sprite(spr_player_jump_down);
        
        //var pra verificar se estou colidindo com a parede one way
        var _parede_one_way_colidindo = place_meeting(x, y, obj_andaime);
        
        //se não estou colidindo com a parede one way
        if (!_parede_one_way_colidindo)
        {
            
            //se o obj_parede_one_way NÃO existe na minha array
            if (!array_contains(colisoes, obj_parede_one_way))
            {
                
                //adiciono a parede one way à lista de colisões
                array_push(colisoes, obj_parede_one_way);
            }
            
        }
        
    }
    
    
    
    //se toquei no chão
    if (chao)
    {
        //vou para o estado de parado
        estado = estado_movendo;
        
        //faço a particula
       // instance_create_depth(x, y, depth, obj_player_pouso_particula);
        
        //efeito mola
        ef_mola(1.2, 0.6);
    }
}

estado_esperando = function()
{
    
    //paro ele horizontalmente
    velh = 0;
    
    // Aplica gravidade e checa o chão normalmente enquanto espera
    aplica_velocidade_player();
    
    // Muda para a sprite dele parado
    troca_sprite(spr_player_idle);
    
    // Diminui o timer a cada frame
    timer_espera--;
    
    // Quando o tempo acabar (chegar a 0 ou menos)
    if (timer_espera <= 0)
    {
        dir = -dir;               // Vira para o lado contrário
        estado = estado_movendo;  // Volta a andar
    }
    
    // Se por acaso ele cair de uma plataforma enquanto espera
    if (velv != 0) estado = estado_pulando;
    
}


#endregion


//aqui ficam as últimas coisas do meu create
//a var estado, armazena o estado atual do player
estado = estado_movendo;