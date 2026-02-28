if(instance_place(x,y,obj_player)){
    if(!instance_exists(obj_transicao)){
        instance_create_layer(x,y,"Transicao",obj_transicao)
    }
}