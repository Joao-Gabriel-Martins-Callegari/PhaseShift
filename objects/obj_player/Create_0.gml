spd = 3
grav = 0.3
velh = 0
velv = 0
max_velv = 5
left = false
rigth = false
space = false
chao = false


movimentacao = function (){
    
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
    
    
    velh = ((rigth - left) * spd)
    
    if(!chao){
        velv += grav
    }else {
    	velv = 0
        if(space and chao){
            velv -= max_velv
        }
    }
    
    move_and_collide(velh,0,_colisoes_atuais,4)
    move_and_collide(0,velv,_colisoes_atuais,4)
    chao = place_meeting(x,y+1,_colisoes_atuais)
}

