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

image_xscale = 1.6
image_yscale = image_xscale


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
        array_push(_colisoes_atuais,obj_parede01)
    }else {
        obj_chao.image_index = 1
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
    
    
    if(velh != 0){
        sprite_index = spr_player_run
    }else {
    	sprite_index = spr_player_idle
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
    
    move_and_collide(velh,0,_colisoes_atuais,12)
    move_and_collide(0,velv,_colisoes_atuais,12)
    chao = place_meeting(x,y+1,_colisoes_atuais)
}

dash_player = function (){
    
    if(!dei_dash){
        var _left = keyboard_check(ord("A"))
        var _right = keyboard_check(ord("D"))
        var _up = keyboard_check(ord("W"))
        var _down = keyboard_check(ord("S"))
        dash = keyboard_check_pressed(ord("J"))
        
        var _dir = point_direction(0,0,(_right - _left), 0)
        
        if(dash){
            screenshake(5)
            timer_duracao--
            velh = lengthdir_x(vel_dash,_dir)
            velv = 0
            dei_dash = true
        }
    }
    
    if(timer_duracao % 3 == 0){
        var _rastro = instance_create_depth(x,y,depth+1,obj_rastro)
       _rastro.sprite_index = sprite_index
       _rastro.image_index = image_index
       _rastro.image_xscale = image_xscale    
       _rastro.image_speed = 0    
    }
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
        }else {
            //Se não, eu uso ele bloqueado
        	_cadeado.image_index = 0
        }
    }
    
}


//Metodo de mudar de sprite
muda_sprite = function (_sprite = spr_chao){ //Passando uma sprite como parametro
    //Verificando se a minha sprite atual é diferente
    //Da sprite que eu passei como parametro
    if(sprite_index != _sprite){
        //Se sim, eu mudo minha sprite
        sprite_index = _sprite
        //Faço minha sprite começar do inicio
        image_index = 0
    }
}