function screenshake (_tremer = 1){
    if(instance_exists(obj_shake)){
        with (obj_shake) {
            if(_tremer > tremer){
                tremer = _tremer
            }
        }
    }
}