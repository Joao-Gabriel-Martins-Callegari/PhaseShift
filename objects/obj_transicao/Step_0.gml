//Animando a sprite

if(entrando){
    img += img_vel

    if(img - img_num > cols +1){
        entrando = false
        room_goto_next()
    }
}else {
	img -= img_vel
    
    if(img < 0) instance_destroy(obj_transicao)
}