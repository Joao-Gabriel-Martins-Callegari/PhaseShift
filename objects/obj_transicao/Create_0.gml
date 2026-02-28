tamanho = sprite_get_width(spr_transicao)

cols = ceil(room_width / tamanho)

lins = ceil(room_height / tamanho)


//Variaveis para animação da sprite

//Imagem inicial
img = 0

img_vel = sprite_get_speed(spr_transicao) / game_get_speed(gamespeed_fps)

img_num = sprite_get_number(spr_transicao)-1


entrando = true