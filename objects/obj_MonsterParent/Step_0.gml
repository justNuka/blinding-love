/// obj_MonsterParent - Step

if !instance_exists(obj_Player) {
    // S'il n'y a pas de player, on peut éventuellement faire rien
    exit;
}

// Distance au joueur
var dist = point_distance(x, y, obj_Player.x, obj_Player.y);

// --- Gestion de l'état ---
switch (state) {
    
    case "wander":
        // 1) On se déplace horizontalement selon hdir
        if (place_free(x + hdir * speed_walk, y)) {
            x += hdir * speed_walk;
        } else {
            // Si on se cogne, on inverse la direction
            hdir = -hdir;
        }

        // 2) Si le joueur est proche (< detection_range), on passe en chase
        if (dist < detection_range) {
            state = "chase";
        }

        // 3) Possibilité de changer de direction aléatoirement toutes les X frames
        //    (non indispensable, mais rend l'errance plus dynamique)
        if (random(100) < 1) {
            hdir = choose(-1, 1);
        }

    break;

    case "chase":
        // Le monstre se dirige vers le joueur
        // Simplement : si le player est à gauche, hdir = -1, à droite => +1
        if (obj_Player.x < x) {
            hdir = -1;
        } else {
            hdir = 1;
        }

        // On avance un peu plus vite quand on chase, si tu veux
        var chase_speed = speed_walk * 1.8;
        if (place_free(x + hdir * chase_speed, y)) {
            x += hdir * chase_speed;
        }

        // Si le joueur s'éloigne au-delà de la detection_range, on retourne errer
        if (dist > detection_range + 50) {
            // Petit hysteresis pour éviter un on/off permanent
            state = "wander";
        }

    break;
}
