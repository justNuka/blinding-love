// Si la vision est à 0, arrête tout dessin
if (vision_radius <= 0) {
    return;
}

// Dessine l'objet joueur normalement
draw_self();