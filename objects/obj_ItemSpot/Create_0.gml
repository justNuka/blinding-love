/// obj_ItemSpot - Create

// Pourcentages actuels (à voir après) :
//  - 25% : pas d'item
//  - 15% : item rare (AugmentVision)
//  - 40% : item commun (SlowVision)
//  - 20% : item StopVision

var r = irandom(99);

if (r < 25) {
    // 25% : aucun item
}
else if (r < 25 + 15) {
    // 15% : item AugmentVision
    instance_create_layer(x, y, layer, obj_ItemAugmentVision);
}
else if (r < 25 + 15 + 40) {
    // 40% : item SlowVision
    instance_create_layer(x, y, layer, obj_ItemSlowVision);
}
else {
    // 20% : item StopVision
    instance_create_layer(x, y, layer, obj_ItemStopVision);
}

instance_destroy();