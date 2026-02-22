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


movimentacao = function (){
    
    //Inputs
    left = keyboard_check(ord("A"))
    rigth = keyboard_check(ord("D"))
    space = keyboard_check_pressed(vk_space)
    
    var _colisoes_atuais = []
    
    array_push(_colisoes_atuais,obj_chao)
    if(global.mundo_atual == "mundo1"){
        array_push(_colisoes_atuais,obj_parede01)
    }else {
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