/// obj_MonsterParent - Create

// Comptage global
global.monsters_alive += 1;

// Vitesse de déplacement
speed_walk = 1.5;

// Direction initiale (errance) : on choisit aléatoirement gauche ou droite
hdir = choose(-1, 1);

// Pour la détection
detection_range = 450;

// État du monstre, par exemple : "wander", "chase"
state = "wander";
