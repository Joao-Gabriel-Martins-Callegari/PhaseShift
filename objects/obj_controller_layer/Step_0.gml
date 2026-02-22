if(keyboard_check_pressed(ord("F"))){
    global.mundo_atual = (global.mundo_atual == "mundo1") ? "mundo2" : "mundo1"
    
    
    if(global.mundo_atual == "mundo1"){
        layer_set_visible("mundo1", true)
        layer_set_visible("mundo2", false)
    }else {
        layer_set_visible("mundo1", false)
        layer_set_visible("mundo2", true)
    }
}