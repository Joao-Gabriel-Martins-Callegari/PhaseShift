
if (abrindo) {
    // Aumenta a escala (0.05 é a velocidade, pode ajustar)
    image_xscale += 0.05;
    image_yscale += 0.05;
    
    // Diminui a opacidade (transparência)
    image_alpha -= 0.05;
    
    // Se sumir completamente, se destrói
    if (image_alpha <= 0) {
        instance_destroy();
    }
}