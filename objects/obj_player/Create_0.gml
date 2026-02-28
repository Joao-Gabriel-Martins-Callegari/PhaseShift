spd = 3
grav = 0.3
velh = 0
velv = 0
max_velv = 5
left = false
rigth = false
space = false
chao = false

walljump_forca = 4

//Dash do player
dash = false 

vel_dash = 10

dei_dash = false

timer_dash = 10
timer_duracao = timer_dash

qtd_chaves = instance_number(obj_chave)

global.powerUp = false

mask_index = spr_player_idle

movimentacao = function (){
    
    //Inputs
    left = keyboard_check(ord("A"))
    rigth = keyboard_check(ord("D"))
    space = keyboard_check_pressed(vk_space)
    
    var _colisoes_atuais = []
    
    array_push(_colisoes_atuais,obj_chao)
    
    if(qtd_chaves > 0){
        array_push(_colisoes_atuais, obj_cadeado)
    }
    
    if(global.mundo_atual == "mundo1"){
        obj_chao.image_index = 0
        image_index = 0
        array_push(_colisoes_atuais,obj_parede01)
    }else {
        obj_chao.image_index = 1
        image_index = 1
    	array_push(_colisoes_atuais,obj_parede02)
    }
    
    var _velh = (rigth - left) * spd 
    
    if(!chao){
        velv += grav
    }else {
    	velv = 0
        dei_dash = false
        timer_duracao = timer_dash
        if(space and chao){
            velv -= max_velv
        }
    }
    
    
    var _direita = place_meeting(x + 1, y, _colisoes_atuais)
    if(space and _direita){
        velv = -walljump_forca
        velh = -walljump_forca
    }
    
    var _esquerda = place_meeting(x-1,y,_colisoes_atuais)
    if(space and _esquerda){
        velv = -walljump_forca
        velh = walljump_forca
    }
    
    velh =lerp(velh,_velh,.1)
    
    
    var _powerUP = instance_place(x,y,obj_powerUp)
     
    if(_powerUP){
        global.powerUp = true
        instance_destroy(_powerUP)
    }
    
    abre_cadeado()
    
    move_and_collide(velh,0,_colisoes_atuais,24)
    move_and_collide(0,velv,_colisoes_atuais,24)
    chao = place_meeting(x,y+1,_colisoes_atuais)
    
    
    
}

dash_player = function (){
    if(!dei_dash){
        var _left = keyboard_check(ord("A"))
        var _right = keyboard_check(ord("D"))
        dash = keyboard_check_pressed(ord("J"))
        
        var _dir = point_direction(0,0,(_right - _left), 0)
        
        if(dash){
            image_yscale = 0.6
            screenshake(5)
            velh = lengthdir_x(vel_dash, _dir)
            velv = 0
            dei_dash = true
            timer_duracao = timer_dash; // Reinicia o timer aqui
        }
    }
    
    // Se estou no dash, o timer corre
    if (dei_dash) {
        timer_duracao--;
        if (timer_duracao <= 0) {
            // Quando o dash acaba, voltamos à velocidade normal
            velh = 0; 
            dei_dash = false;
        }
        
        // Efeito de rastro
        if(timer_duracao % 3 == 0){
            var _rastro = instance_create_depth(x,y,depth+1,obj_rastro)
            _rastro.sprite_index = sprite_index
            _rastro.image_index = image_index
            _rastro.image_xscale = image_xscale    
            _rastro.image_speed = 0    
        }
    }
    
    image_yscale = lerp(image_yscale, 1, .2)
}

morte_player = function (){
    
    var _espinhos = instance_place(x,y,obj_espinho)
    
    if(_espinhos){
        game_restart()
    }
    
}


abre_cadeado = function (){
    var _chave = instance_place(x,y,obj_chave)
    var _cadeado = instance_place(x,y,obj_cadeado)
    
    //Se eu colidi com uma chave
    if(_chave){ 
        //Eu destruo ela
        instance_destroy(_chave)
        //E diminuo o valor de chaves
        qtd_chaves--
    } 
    
    
    //Se o meu cadeado é diferente de noone(vazio)
    if(_cadeado != noone){
        //Eu verifico se não existe mais chaves no mapa
        //E se eu estou colidindo com o cadeado
        if(qtd_chaves <= 0 and _cadeado){
            //Se isso for true
            //Eu uso a imagem do cadeado desbloqueado
            _cadeado.image_index = 1
            
            _cadeado.abrindo = true
            _cadeado.mask_index = -1
            
        }else {
            //Se não, eu uso ele bloqueado
        	_cadeado.image_index = 0
        }
    }
    
}